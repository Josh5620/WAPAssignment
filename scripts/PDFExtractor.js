const fs = require('fs').promises;
const path = require('path');
const pdf = require('pdf-parse');
const { v4: uuidv4 } = require('uuid');

// --- CONFIGURATION ---
const PDF_PATH = path.join(__dirname, '..', 'course_materials', 'pythonnotes.pdf'); // Corrected name
const SEED_OUTPUT_DIR = path.join(__dirname, '..', 'server', 'ProjectAPI', 'Data', 'Seeds');
const COURSE_TITLE = 'The Garden of Python'; // Using your new theme!

// Helper to escape single quotes for SQL
const escapeSql = (text) => text ? text.replace(/'/g, "''") : '';

async function generateSeeds() {
    console.log('✅ PDFExtractor.js is running!');
    console.log('Starting seed generation...');

    await fs.mkdir(SEED_OUTPUT_DIR, { recursive: true });
    console.log(`Output directory is: ${SEED_OUTPUT_DIR}`);

    // --- 1. Generate the Course Seed File ---
    const courseId = uuidv4();
    const courseSql = `
-- Seed for course: ${COURSE_TITLE}
-- This file is auto-generated.
INSERT INTO Courses (CourseId, Title, Description, Published)
VALUES ('${courseId}', '${escapeSql(COURSE_TITLE)}', 'A course on Python fundamentals, grown from the CodeSage garden.', 1);
GO
`;
    await fs.writeFile(path.join(SEED_OUTPUT_DIR, '02-python-course.sql'), courseSql);
    console.log('✅ Generated 02-python-course.sql');

    // --- 2. Parse PDF ---
    console.log(`Reading PDF from: ${PDF_PATH}`);
    let dataBuffer;
    try {
        dataBuffer = await fs.readFile(PDF_PATH);
    } catch (error) {
        console.error(`❌ ERROR: Could not read the PDF file at ${PDF_PATH}.`);
        console.error('Please ensure the file exists in `course_materials`.');
        return;
    }

    const data = await pdf(dataBuffer);
    const allText = data.text;

    // --- 3. Split by Chapter, NOT Page ---
    // This RegEx splits the text *before* "Chapter X:", keeping it.
    const chapterSplitPattern = /(?=^Chapter \d+: .*)/gm;
    const chapterBlobs = allText.split(chapterSplitPattern);

    let chapterSqls = [];
    let flashcardSqls = [];
    let questionSqls = [];

    console.log(`Found ${chapterBlobs.length - 1} potential chapters...`);

    // We skip blob[0] as it's everything *before* Chapter 1
    for (let i = 1; i < chapterBlobs.length; i++) {
        const blob = chapterBlobs[i];
        const chapterId = uuidv4();

        // --- A. Parse Chapter Title and Content ---
        const titleMatch = blob.match(/^Chapter \d+: (.*)/);
        const chapterTitle = titleMatch ? titleMatch[1].trim() : `Chapter ${i}`;

        // RegEx to find text between "Full Notes" and the *next* "Flashcards" header
        const notesMatch = blob.match(/Full Notes([\s\S]*?)(?=Flashcards \(\d+\))/);
        const chapterContent = notesMatch ? notesMatch[1].trim() : 'Content not found.';
        
        const chapterSql = `
-- Seed for Chapter ${i}: ${chapterTitle}
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('${chapterId}', '${escapeSql(chapterTitle)}', N'${escapeSql(chapterContent)}', ${i}, '${courseId}');
GO`;
        chapterSqls.push(chapterSql);

        // --- B. Parse Flashcards ---
        const flashcardsMatch = blob.match(/Flashcards \(\d+\)([\s\S]*?)(?=MCQs \(\d+\))/);
        if (flashcardsMatch) {
            const flashcardText = flashcardsMatch[1];
            // RegEx to find all "Q: ... A: ..." pairs
            const fcPattern = /\d+\. Q: (.*?)\n\s*A: (.*?)(?=\n\d+\. Q:|\nMCQs)/gs;
            let fcMatch;
            let orderIndex = 1;
            while ((fcMatch = fcPattern.exec(flashcardText)) !== null) {
                const question = fcMatch[1].trim();
                const answer = fcMatch[2].trim();
                
                // Generate Resource and Flashcard following proper schema
                const resourceId = uuidv4();
                const flashcardId = uuidv4();
                const resourceSql = `INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('${resourceId}', '${chapterId}', 'flashcard', NULL);\nGO`;
                const fcSql = `INSERT INTO Flashcards (FcId, ResourceId, FrontText, BackText, OrderIndex) VALUES ('${flashcardId}', '${resourceId}', N'${escapeSql(question)}', N'${escapeSql(answer)}', ${orderIndex});\nGO`;
                flashcardSqls.push(resourceSql + '\n' + fcSql);
                orderIndex++;
            }
        }

        // --- C. Parse MCQs (Questions) ---
        const mcqsMatch = blob.match(/MCQs \(\d+\) with Answers & Hints([\s\S]*)/);
        if (mcqsMatch) {
            const mcqText = mcqsMatch[1];
            // This RegEx is more complex. It finds a question, all 4 options, and the answer.
            const mcqPattern = /\d+\. ([\s\S]*?)\n\s*Hint: .*?\n\s*A\) (.*?)\n\s*B\) (.*?)\n\s*C\) (.*?)\n\s*D\) (.*?)\n\s*Answer: (A|B|C|D)/g;
            let mcqMatch;
            while ((mcqMatch = mcqPattern.exec(mcqText)) !== null) {
                const questionText = mcqMatch[1].trim().replace(/\n/g, ' '); // Clean up question text
                const options = {
                    A: mcqMatch[2].trim(),
                    B: mcqMatch[3].trim(),
                    C: mcqMatch[4].trim(),
                    D: mcqMatch[5].trim()
                };
                const answer = mcqMatch[6].trim();
                
                // Generate Resource, Question, and QuestionOptions following proper schema
                const resourceId = uuidv4();
                const questionId = uuidv4();
                
                const resourceSql = `INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('${resourceId}', '${chapterId}', 'mcq', NULL);\nGO`;
                const questionSql = `INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('${questionId}', '${resourceId}', N'${escapeSql(questionText)}', 'medium', NULL);\nGO`;
                
                // Generate options
                let optionSqls = [];
                Object.keys(options).forEach(key => {
                    const optionId = uuidv4();
                    const isCorrect = (key === answer) ? 1 : 0;
                    const optionSql = `INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('${optionId}', '${questionId}', N'${escapeSql(options[key])}', ${isCorrect});\nGO`;
                    optionSqls.push(optionSql);
                });
                
                questionSqls.push(resourceSql + '\n' + questionSql + '\n' + optionSqls.join('\n'));
            }
        }
    }

    // --- 4. Write All Seed Files ---
    if (chapterSqls.length > 0) {
        await fs.writeFile(path.join(SEED_OUTPUT_DIR, '03-python-chapters.sql'), chapterSqls.join('\n'));
        console.log(`✅ Generated 03-python-chapters.sql with ${chapterSqls.length} chapters.`);
    }
    if (flashcardSqls.length > 0) {
        await fs.writeFile(path.join(SEED_OUTPUT_DIR, '04-python-flashcards.sql'), flashcardSqls.join('\n'));
        console.log(`✅ Generated 04-python-flashcards.sql with ${flashcardSqls.length} flashcards.`);
    }
    if (questionSqls.length > 0) {
        await fs.writeFile(path.join(SEED_OUTPUT_DIR, '05-python-questions.sql'), questionSqls.join('\n'));
        console.log(`✅ Generated 05-python-questions.sql with ${questionSqls.length} MCQs.`);
    }

    console.log('\nSeed generation complete!');
}

generateSeeds().catch(console.error);