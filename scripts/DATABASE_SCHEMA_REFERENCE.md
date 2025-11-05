# Database Schema Reference for PDFExtractor (Updated from ER Diagram)

## Complete Table Column Reference

### 1. **Courses** Table
```sql
CREATE TABLE Courses (
    CourseId        UNIQUEIDENTIFIER PRIMARY KEY,
    Title           NVARCHAR(MAX) NOT NULL,
    Description     NVARCHAR(MAX) NULL,
    PreviewContent  NVARCHAR(MAX) NULL,
    Published       BIT NOT NULL DEFAULT 1
);
```

**Required for PDF Extraction:**
- `CourseId` - Generate with `uuidv4()`
- `Title` - Course title from PDF
- `Description` - Optional course description
- `Published` - Set to `1` (true)

---

### 2. **Chapters** Table
```sql
CREATE TABLE Chapters (
    ChapterId UNIQUEIDENTIFIER PRIMARY KEY,
    CourseId  UNIQUEIDENTIFIER NOT NULL,
    Number    INT NOT NULL,
    Title     NVARCHAR(MAX) NOT NULL,
    Summary   NVARCHAR(MAX) NULL,
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);
```

**Required for PDF Extraction:**
- `ChapterId` - Generate with `uuidv4()`
- `CourseId` - Reference to the Course
- `Number` - Sequential chapter number (1, 2, 3...)
- `Title` - Chapter title extracted from PDF
- `Summary` - Optional chapter summary

---

### 3. **Resources** Table
```sql
CREATE TABLE Resources (
    ResourceId UNIQUEIDENTIFIER PRIMARY KEY,
    ChapterId  UNIQUEIDENTIFIER NOT NULL,
    Type       NVARCHAR(MAX) NOT NULL,  -- "note", "flashcard", "mcq"
    Content    NVARCHAR(MAX) NULL,
    FOREIGN KEY (ChapterId) REFERENCES Chapters(ChapterId)
);
```

**Types Available:**
- `"note"` - Text content/notes
- `"flashcard"` - Flashcard study material
- `"mcq"` - Multiple choice questions

---

### 4. **Flashcards** Table (if creating flashcards)
```sql
CREATE TABLE Flashcards (
    FcId       UNIQUEIDENTIFIER PRIMARY KEY,
    ResourceId UNIQUEIDENTIFIER NOT NULL,
    FrontText  NVARCHAR(MAX) NULL,
    BackText   NVARCHAR(MAX) NULL,
    OrderIndex INT NOT NULL,
    FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId)
);
```

---

### 5. **Questions** Table (if creating MCQs)
```sql
CREATE TABLE Questions (
    QuestionId  UNIQUEIDENTIFIER PRIMARY KEY,
    ResourceId  UNIQUEIDENTIFIER NOT NULL,
    Stem        NVARCHAR(MAX) NOT NULL,     -- The question text
    Difficulty  NVARCHAR(MAX) NOT NULL,     -- "easy", "medium", "hard"
    Explanation NVARCHAR(MAX) NULL,
    FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId)
);
```

---

### 6. **QuestionOptions** Table (for MCQ answers)
```sql
CREATE TABLE QuestionOptions (
    OptionId   UNIQUEIDENTIFIER PRIMARY KEY,
    QuestionId UNIQUEIDENTIFIER NOT NULL,
    OptionText NVARCHAR(MAX) NOT NULL,
    IsCorrect  BIT NOT NULL,
    FOREIGN KEY (QuestionId) REFERENCES Questions(QuestionId)
);
```

---

## 🎯 **Recommended PDFExtractor Structure**

Based on your current database schema, here's the optimal extraction approach:

### **Approach 1: Simple Content Extraction (Current)**
```javascript
// Generate course
INSERT INTO Courses (Id, Title, Description, Published, CreatedAt)
VALUES ('${courseId}', '${title}', '${description}', 1, GETDATE());

// Generate chapters with content
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary, CreatedAt)
VALUES ('${chapterId}', '${courseId}', ${number}, '${title}', '${summary}', GETDATE());

// Generate resources (notes) for each chapter
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES ('${resourceId}', '${chapterId}', 'note', N'${content}');
```

### **Approach 2: Enhanced with Flashcards & MCQs**
```javascript
// After creating basic structure, add:

// Create flashcards from key concepts
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES ('${flashcardResourceId}', '${chapterId}', 'flashcard', NULL);

INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES ('${flashcardId}', '${flashcardResourceId}', '${question}', '${answer}', ${order});

// Create MCQ questions
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES ('${mcqResourceId}', '${chapterId}', 'mcq', NULL);

INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES ('${questionId}', '${mcqResourceId}', '${questionText}', 'medium', '${explanation}');

INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES ('${optionId}', '${questionId}', '${optionText}', ${isCorrect});
```

---

## 🔧 **Missing Columns in Current Extractor**

Your current PDFExtractor is missing these **required** columns:

### **Chapters Table:**
- ✅ `Id` - You have this
- ✅ `CourseId` - You have this  
- ❌ **`Number`** - MISSING (required INT)
- ✅ `Title` - You have this
- ❌ **`Summary`** - MISSING (optional but recommended)
- ❌ **`CreatedAt`** - MISSING (add GETDATE())

### **Courses Table:**
- ❌ **`CreatedAt`** - MISSING (add GETDATE())

---

## 📋 **Updated SQL Template (Correct Column Names)**

```sql
-- Course
INSERT INTO Courses (CourseId, Title, Description, Published)
VALUES ('${courseId}', N'${escapeSql(title)}', N'${escapeSql(description)}', 1);

-- Chapter with correct column names
INSERT INTO Chapters (ChapterId, CourseId, Number, Title, Summary)
VALUES ('${chapterId}', '${courseId}', ${chapterNumber}, N'${escapeSql(title)}', N'${escapeSql(summary)}');

-- Resource for chapter content
INSERT INTO Resources (ResourceId, ChapterId, Type, Content)
VALUES ('${resourceId}', '${chapterId}', 'note', N'${escapeSql(content)}');

-- Optional: Flashcard example
INSERT INTO Flashcards (FcId, ResourceId, FrontText, BackText, OrderIndex)
VALUES ('${flashcardId}', '${resourceId}', N'${escapeSql(question)}', N'${escapeSql(answer)}', ${order});

-- Optional: Question example
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation)
VALUES ('${questionId}', '${resourceId}', N'${escapeSql(questionText)}', 'medium', N'${escapeSql(explanation)}');

-- Optional: Question Options
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect)
VALUES ('${optionId}', '${questionId}', N'${escapeSql(optionText)}', ${isCorrect});
```

This reference should help you update your PDFExtractor to match your exact database schema! 🎯