const fs = require('fs').promises;
const path = require('path');
const pdf = require('pdf-parse');
const { v4: uuidv4 } = require('uuid');

// --- CONFIGURATION ---
const PDF_PATH = path.join(__dirname, '..', 'course_materials', 'pythonnotes.pdf');
const SEED_OUTPUT_DIR = path.join(__dirname, '..', 'server', 'ProjectAPI', 'Data', 'Seeds');
const COURSE_TITLE = 'The Garden of Python';
const DEFAULT_TEACHER_ID = '213ac00b-c3df-4d60-a264-f5e8e5d3cb93'; 

/**
 * Escapes single quotes in a string for safe SQL insertion.
 * @param {string} text The text to escape.
 * @returns {string} The escaped text.
 */
const escapeSql = (text) => {
    if (typeof text !== 'string') {
        return '';
    }
    return text.replace(/'/g, "''");
};

/**
 * Generates a concise summary from chapter notes content.
 * Extracts key points and creates a 2-3 sentence summary.
 * @param {string} notesContent The full notes content for the chapter.
 * @param {string} chapterTitle The chapter title for context.
 * @returns {string} A concise summary of the chapter notes.
 */
const generateSummary = (notesContent, chapterTitle) => {
    if (!notesContent || notesContent.trim().length === 0) {
        return `Learn ${chapterTitle} concepts and fundamentals.`;
    }

    // Clean the content - preserve structure but normalize whitespace
    let content = notesContent.trim();
    
    // Split into sentences for better processing
    const sentences = content.split(/[.!?]+\s+/).filter(s => s.trim().length > 20);
    
    // Extract key sections (look for headings or important markers)
    const sections = content.split(/\n\s*\n/).filter(s => s.trim().length > 30);
    
    // Build summary from first meaningful sentences
    let summary = '';
    
    // Try to get the first 2-3 meaningful sentences (50-200 chars each)
    const meaningfulSentences = sentences.filter(s => {
        const len = s.trim().length;
        return len >= 50 && len <= 200;
    }).slice(0, 3);
    
    if (meaningfulSentences.length > 0) {
        summary = meaningfulSentences.join('. ');
        if (!summary.endsWith('.')) {
            summary += '.';
        }
    } else {
        // Fallback: use first section or first 250 characters
        if (sections.length > 0) {
            const firstSection = sections[0].trim();
            // Take first 250 chars and find last complete sentence
            if (firstSection.length > 250) {
                const truncated = firstSection.substring(0, 250);
                const lastPeriod = truncated.lastIndexOf('.');
                if (lastPeriod > 100) {
                    summary = truncated.substring(0, lastPeriod + 1);
                } else {
                    summary = truncated.trim() + '...';
                }
            } else {
                summary = firstSection;
                if (!summary.endsWith('.') && !summary.endsWith('!') && !summary.endsWith('?')) {
                    summary += '.';
                }
            }
        } else {
            // Last resort: first 250 characters
            summary = content.substring(0, 250).trim();
            const lastPeriod = summary.lastIndexOf('.');
            if (lastPeriod > 100) {
                summary = summary.substring(0, lastPeriod + 1);
            } else {
                summary += '...';
            }
        }
    }
    
    // Extract key topics/headings (lines that look like section headers)
    const headings = content.match(/(?:^|\n)([A-Z][A-Za-z\s]{10,60})(?:\n|$)/g) || [];
    const keyTopics = headings
        .map(h => h.replace(/^\n/, '').trim())
        .filter(h => !h.includes('Chapter') && !h.includes('Notes') && h.length > 10 && h.length < 80)
        .slice(0, 4);
    
    // Add key topics if summary is short enough
    if (keyTopics.length > 0 && summary.length < 350) {
        const topicsText = keyTopics.slice(0, 3).join(', ');
        if (summary.length + topicsText.length + 30 < 500) {
            summary += ` Key topics include: ${topicsText}.`;
        }
    }
    
    // Ensure summary is not too long (max 500 chars)
    if (summary.length > 500) {
        const lastPeriod = summary.substring(0, 500).lastIndexOf('.');
        if (lastPeriod > 300) {
            summary = summary.substring(0, lastPeriod + 1);
        } else {
            summary = summary.substring(0, 497) + '...';
        }
    }
    
    return summary.trim();
};

/**
 * Main function to generate all seed files.
 */
async function generateSeeds() {
    console.log('✅ PDFExtractor.js (v7 - Final) is running!');
    await fs.mkdir(SEED_OUTPUT_DIR, { recursive: true });
    console.log(`Output directory set to: ${SEED_OUTPUT_DIR}`);

    // --- 1. Generate the Course Seed File ---
    const courseId = uuidv4();
    const courseSql = `
-- Seed for course: ${COURSE_TITLE}
-- This course is assigned to the default teacher and set to 'Approved'.
INSERT INTO Courses (CourseId, Title, Description, Published, TeacherId, ApprovalStatus, PreviewContent)
VALUES ('${courseId}', '${escapeSql(COURSE_TITLE)}', 'A course on Python fundamentals, grown from the CodeSage garden.', 1, '${DEFAULT_TEACHER_ID}', 'Approved', 'Learn the basics of Python, from variables to data structures and OOP.');
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

    // --- 3. Define Whitespace-Tolerant RegEx Patterns ---
    
    // Splits the text at the start of "Chapter X:"
    const chapterSplitPattern = /(?=Chapter\s*\d{1,2}\s*:)/g;
    
    // Finds all text between "Full Notes" and the next major header
    const notesPattern = /Full\s*Notes([\s\S]*?)(?=(?:Flashcards\s*\(\d+\)|MCQs\s*\(\d+\)|Multiple-Choice\s*Questions\s*\(\d+\)))/;
    
    // Finds all text between "Flashcards(X)" and the next major header
    const flashcardsBlockPattern = /Flashcards\s*\(\d+\)([\s\S]*?)(?=(?:MCQs\s*\(\d+\)|Multiple-Choice\s*Questions\s*\(\d+\)))/;
    
    // Finds individual Q/A pairs, tolerating whitespace
    const flashcardItemPattern = /\d+\.\s*Q:\s*(.*?)\n\s*A:\s*(.*?)(?=\n\d+\.\s*Q:|\n(?:MCQs\s*\(\d+\)|Multiple-Choice\s*Questions\s*\(\d+\)))/gs;
    
    // Finds *either* "MCQs (X) with Answers & Hints" or "Multiple-Choice Questions (X)"
    const mcqsBlockPattern = /(?:MCQs\s*\(\d+\)\s*with\s*Answers\s*&\s*Hints|Multiple-Choice\s*Questions\s*\(\d+\))([\s\S]*?)(?=Chapter\s*\d{1,2}\s*:|$)/;
    
    // Finds individual MCQs, tolerating whitespace and optional "Hint:"
    const mcqItemPattern = /\d+\.\s*([\s\S]*?)\n\s*(?:Hint:\s*(.*?)\n)?\s*A\)\s*(.*?)\n\s*B\)\s*(.*?)\n\s*C\)\s*(.*?)\n\s*D\)\s*(.*?)\n\s*Answer:\s*(A|B|C|D)/g;

    // --- 4. Initialize SQL string arrays ---
    let chapterSqls = [];
    let resourceSqls = [];
    let flashcardSqls = [];
    let questionSqls = [];
    let optionSqls = [];

    // --- 5. Main Parsing Loop ---
    const chapterBlobs = allText.split(chapterSplitPattern);
    console.log(`Found ${chapterBlobs.length - 1} potential chapters...`);

    // We skip blob[0] (text before Chapter 1)
    for (let i = 1; i < chapterBlobs.length; i++) {
        const blob = chapterBlobs[i];
        const chapterId = uuidv4();

        // --- A. Parse Chapter & Create its Resources ---
        const titleMatch = blob.match(/^Chapter\s*\d{1,2}\s*:\s*(.*)/);
        const chapterTitle = titleMatch ? titleMatch[1].trim() : `Chapter ${i}`;

        // Find the "Full Notes" section
        let chapterContent = 'Content not found.';
        const notesMatch = blob.match(notesPattern);
        
        if (notesMatch) {
            chapterContent = notesMatch[1].trim();
        } else {
            // Fallback for chapters that *only* have notes (like Ch. 10)
            const simpleContentMatch = blob.match(/^Chapter\s*\d{1,2}\s*:[\s\S]*?Full\s*Notes([\s\S]*?)(?=Flashcards\s*\(\d+\)|Multiple-Choice\s*Questions\s*\(\d+\)|$)/);
            if (simpleContentMatch) {
                chapterContent = simpleContentMatch[1].trim();
            } else {
                 // Final fallback: just grab everything after the title line
                const fallbackMatch = blob.match(/^Chapter\s*\d{1,2}\s*:[\r\n]+([\s\S]*)/);
                if(fallbackMatch) {
                    chapterContent = fallbackMatch[1].trim();
                }
            }
        }
        
        // Generate a proper summary from the notes content
        const chapterSummary = generateSummary(chapterContent, chapterTitle);
        
        const chapterSql = `
-- Seed for Chapter ${i}: ${chapterTitle}
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('${chapterId}', '${escapeSql(chapterTitle)}', N'${escapeSql(chapterSummary)}', ${i}, '${courseId}');
GO`;
        chapterSqls.push(chapterSql);

        // --- Create ONE set of resources for this whole chapter ---
        const lessonResourceId = uuidv4();
        const flashcardResourceId = uuidv4();
        const quizResourceId = uuidv4();

        // 1. Lesson Resource
        resourceSqls.push(`
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('${lessonResourceId}', '${chapterId}', 'lesson', N'${escapeSql(chapterContent)}');
GO`);

        // 2. Flashcard Resource (wrapper)
        resourceSqls.push(`
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('${flashcardResourceId}', '${chapterId}', 'flashcard', '${escapeSql(chapterTitle)} Flashcards');
GO`);

        // 3. Quiz Resource (wrapper)
        resourceSqls.push(`
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('${quizResourceId}', '${chapterId}', 'mcq', '${escapeSql(chapterTitle)} Quiz');
GO`);


        // --- B. Parse Flashcards ---
        const flashcardsMatch = blob.match(flashcardsBlockPattern);
        if (flashcardsMatch) {
            const flashcardText = flashcardsMatch[1];
            let fcMatch;
            let orderIndex = 0;
            while ((fcMatch = flashcardItemPattern.exec(flashcardText)) !== null) {
                const question = fcMatch[1].trim();
                const answer = fcMatch[2].trim();
                
                // Link ALL flashcards to the ONE flashcardResourceId
                const fcSql = `INSERT INTO Flashcards (FcId, ResourceId, FrontText, BackText, OrderIndex) VALUES ('${uuidv4()}', '${flashcardResourceId}', N'${escapeSql(question)}', N'${escapeSql(answer)}', ${orderIndex});\nGO`;
                flashcardSqls.push(fcSql);
                orderIndex++;
            }
        }

        // --- C. Parse MCQs (Questions) ---
        const mcqsMatch = blob.match(mcqsBlockPattern);
        if (mcqsMatch) {
            const mcqText = mcqsMatch[1];
            let mcqMatch;
            while ((mcqMatch = mcqItemPattern.exec(mcqText)) !== null) {
                const questionId = uuidv4();
                const questionText = mcqMatch[1].trim().replace(/\n/g, ' ');
                const explanation = mcqMatch[2] ? mcqMatch[2].trim() : 'No hint provided.';
                const options = { A: mcqMatch[3].trim(), B: mcqMatch[4].trim(), C: mcqMatch[5].trim(), D: mcqMatch[6].trim() };
                const answerKey = mcqMatch[7].trim(); 
                
                // Link ALL questions to the ONE quizResourceId
                const qSql = `INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('${questionId}', '${quizResourceId}', N'${escapeSql(questionText)}', 'medium', N'${escapeSql(explanation)}');\nGO`;
                questionSqls.push(qSql);
                
                // Generate options for this question
                Object.keys(options).forEach(key => {
                    const isCorrect = (key === answerKey) ? 1 : 0;
                    const optionSql = `INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('${uuidv4()}', '${questionId}', N'${escapeSql(options[key])}', ${isCorrect});\nGO`;
                    optionSqls.push(optionSql);
                });
            }
        }
        console.log(`  ...Processed Chapter ${i}: ${chapterTitle}`);
    }

    // --- 4. Write All Seed Files ---
    await fs.writeFile(path.join(SEED_OUTPUT_DIR, '03-python-chapters.sql'), chapterSqls.join('\n'));
    console.log(`✅ Generated 03-python-chapters.sql with ${chapterSqls.length} chapters.`);
    
    await fs.writeFile(path.join(SEED_OUTPUT_DIR, '04-python-resources.sql'), resourceSqls.join('\n'));
    console.log(`✅ Generated 04-python-resources.sql with ${resourceSqls.length} resources.`);
    
    await fs.writeFile(path.join(SEED_OUTPUT_DIR, '05-python-flashcards.sql'), flashcardSqls.join('\n'));
    console.log(`✅ Generated 05-python-flashcards.sql with ${flashcardSqls.length} flashcards.`);

    await fs.writeFile(path.join(SEED_OUTPUT_DIR, '06-python-questions.sql'), questionSqls.join('\n'));
    console.log(`✅ Generated 06-python-questions.sql with ${questionSqls.length} questions.`);

    await fs.writeFile(path.join(SEED_OUTPUT_DIR, '07-python-question-options.sql'), optionSqls.join('\n'));
    console.log(`✅ Generated 07-python-question-options.sql with ${optionSqls.length} options.`);

    console.log('\nSeed generation complete!');
}

// --- Run the script ---
generateSeeds().catch(console.error);