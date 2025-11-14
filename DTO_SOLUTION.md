# DTO Solution for Chapter Data Structure

## Problem Statement

The database stores chapter notes as a single HTML/text blob in the `Resource.Content` field. The frontend needs this data split into structured sections (introduction, subtopics, code samples, practice ideas) to properly display content in different containers.

## Solution Overview

We'll create a **Data Transfer Object (DTO)** pattern that:
1. Structures the database content into logical sections
2. Parses HTML/text content to extract headings, code blocks, and sections
3. Provides a clean API response that the frontend can easily consume
4. Includes fallback to full content if parsing fails

---

## Implementation Steps

### Step 1: Create DTO Classes

Create a new folder `DTOs` in `server/ProjectAPI` and add the following file:

**File: `server/ProjectAPI/DTOs/ChapterContentDto.cs`**

```csharp
namespace ProjectAPI.DTOs;

/// <summary>
/// Main DTO for chapter content - structures database content for frontend consumption
/// </summary>
public class ChapterContentDto
{
    public Guid ChapterId { get; set; }
    public string ChapterTitle { get; set; } = string.Empty;
    public string? ChapterSummary { get; set; }
    public int Number { get; set; }
    public Guid CourseId { get; set; }
    public CourseInfoDto? Course { get; set; }
    
    // Structured content sections
    public ChapterNotesDto? Notes { get; set; }
    public List<FlashcardDto> Flashcards { get; set; } = new();
    public QuizResourceDto? Quiz { get; set; }
    public PracticeLabDto? PracticeLab { get; set; }
}

public class CourseInfoDto
{
    public Guid CourseId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
}

/// <summary>
/// Structured notes content - splits the database HTML blob into logical sections
/// </summary>
public class ChapterNotesDto
{
    public string? FullContent { get; set; } // Original HTML for fallback
    public string? Introduction { get; set; }
    public List<SubtopicDto> Subtopics { get; set; } = new();
    public List<CodeSampleDto> CodeSamples { get; set; } = new();
    public string? PracticeIdeas { get; set; }
    public string? Summary { get; set; }
}

public class SubtopicDto
{
    public string Heading { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public int Order { get; set; }
}

public class CodeSampleDto
{
    public string Title { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public string? Language { get; set; } = "python";
    public string? Explanation { get; set; }
}

public class FlashcardDto
{
    public Guid FcId { get; set; }
    public string FrontText { get; set; } = string.Empty;
    public string BackText { get; set; } = string.Empty;
    public int OrderIndex { get; set; }
}

public class QuizResourceDto
{
    public Guid ResourceId { get; set; }
    public List<QuestionDto> Questions { get; set; } = new();
}

public class QuestionDto
{
    public Guid QuestionId { get; set; }
    public string Stem { get; set; } = string.Empty;
    public string? Difficulty { get; set; }
    public string? Explanation { get; set; }
    public List<QuestionOptionDto> Options { get; set; } = new();
}

public class QuestionOptionDto
{
    public Guid OptionId { get; set; }
    public string OptionText { get; set; } = string.Empty;
    public bool IsCorrect { get; set; }
}

public class PracticeLabDto
{
    public string? Description { get; set; }
    public string? StarterCode { get; set; }
    public string? ExpectedOutput { get; set; }
}
```

---

### Step 2: Create Content Parser Service

**File: `server/ProjectAPI/Services/ChapterContentParser.cs`**

```csharp
using System.Text.RegularExpressions;
using ProjectAPI.DTOs;

namespace ProjectAPI.Services;

/// <summary>
/// Parses HTML/text content from database into structured DTO sections
/// </summary>
public class ChapterContentParser
{
    /// <summary>
    /// Parses raw HTML content into structured notes sections
    /// </summary>
    public static ChapterNotesDto ParseNotesContent(string? rawContent)
    {
        if (string.IsNullOrWhiteSpace(rawContent))
        {
            return new ChapterNotesDto { FullContent = rawContent };
        }

        var notes = new ChapterNotesDto
        {
            FullContent = rawContent // Keep original for fallback
        };

        // Try to extract introduction (first paragraph or section before first heading)
        var introMatch = Regex.Match(rawContent, @"^(.*?)(?=\n\s*[#]|$)", RegexOptions.Singleline | RegexOptions.IgnoreCase);
        if (introMatch.Success && introMatch.Groups[1].Value.Trim().Length > 50)
        {
            notes.Introduction = CleanHtml(introMatch.Groups[1].Value.Trim());
        }

        // Extract subtopics (headings followed by content)
        // Pattern: # Heading or ## Heading or ### Heading followed by content
        var headingPattern = @"(?:^|\n)\s*(#{1,3})\s+(.+?)(?=\n\s*#|$)";
        var headingMatches = Regex.Matches(rawContent, headingPattern, RegexOptions.Multiline | RegexOptions.IgnoreCase);
        
        int order = 0;
        foreach (Match match in headingMatches)
        {
            var heading = match.Groups[2].Value.Trim();
            var contentStart = match.Index + match.Length;
            var nextMatch = headingMatches.Cast<Match>()
                .FirstOrDefault(m => m.Index > match.Index);
            
            var contentEnd = nextMatch?.Index ?? rawContent.Length;
            var content = rawContent.Substring(contentStart, contentEnd - contentStart).Trim();
            
            // Skip if heading is too generic or content is too short
            if (heading.Length > 3 && heading.Length < 100 && content.Length > 20)
            {
                notes.Subtopics.Add(new SubtopicDto
                {
                    Heading = heading,
                    Content = CleanHtml(content),
                    Order = order++
                });
            }
        }

        // Extract code samples (code blocks)
        var codeBlockPattern = @"```(\w+)?\s*\n(.*?)```";
        var codeMatches = Regex.Matches(rawContent, codeBlockPattern, RegexOptions.Singleline | RegexOptions.IgnoreCase);
        
        int codeIndex = 0;
        foreach (Match match in codeMatches)
        {
            var language = match.Groups[1].Value.Trim();
            var code = match.Groups[2].Value.Trim();
            
            if (!string.IsNullOrWhiteSpace(code))
            {
                notes.CodeSamples.Add(new CodeSampleDto
                {
                    Title = $"Code Example {++codeIndex}",
                    Code = code,
                    Language = string.IsNullOrWhiteSpace(language) ? "python" : language.ToLower()
                });
            }
        }

        // Extract practice ideas (look for sections with "practice", "exercise", "try", etc.)
        var practicePattern = @"(?:Practice|Exercise|Try|Challenge)[\s\S]*?(?=\n\s*#|$)";
        var practiceMatch = Regex.Match(rawContent, practicePattern, RegexOptions.IgnoreCase | RegexOptions.Multiline);
        if (practiceMatch.Success)
        {
            notes.PracticeIdeas = CleanHtml(practiceMatch.Value.Trim());
        }

        // If no structured sections found, at least return the full content
        if (notes.Subtopics.Count == 0 && string.IsNullOrEmpty(notes.Introduction))
        {
            notes.Introduction = CleanHtml(rawContent.Substring(0, Math.Min(500, rawContent.Length)));
        }

        return notes;
    }

    /// <summary>
    /// Cleans HTML content while preserving structure
    /// </summary>
    private static string CleanHtml(string html)
    {
        if (string.IsNullOrWhiteSpace(html))
            return string.Empty;

        // Remove excessive whitespace but preserve line breaks
        html = Regex.Replace(html, @"\s+", " ");
        html = Regex.Replace(html, @"\n\s*\n", "\n\n");
        
        return html.Trim();
    }
}
```

---

### Step 3: Update StudentsController

**File: `server/ProjectAPI/Controllers/StudentsController.cs`**

Add these using statements at the top:

```csharp
using ProjectAPI.DTOs;
using ProjectAPI.Services;
```

Replace the existing `GetChapterContent` method (around lines 280-362) with:

```csharp
[HttpGet("chapters/{chapterId}/content")]
public async Task<IActionResult> GetChapterContent(Guid chapterId, CancellationToken ct = default)
{
    try
    {
        var chapter = await _context.Chapters
            .Include(ch => ch.Course)
            .Include(ch => ch.Resources)
                .ThenInclude(r => r.Questions)
                    .ThenInclude(q => q.QuestionOptions)
            .Include(ch => ch.Resources)
                .ThenInclude(r => r.Flashcards)
            .FirstOrDefaultAsync(ch => ch.ChapterId == chapterId, ct);

        if (chapter == null)
        {
            return NotFound(new { error = "Chapter not found" });
        }

        // Build DTO with structured content
        var dto = new ChapterContentDto
        {
            ChapterId = chapter.ChapterId,
            ChapterTitle = chapter.Title,
            ChapterSummary = chapter.Summary,
            Number = chapter.Number,
            CourseId = chapter.CourseId,
            Course = new CourseInfoDto
            {
                CourseId = chapter.Course.CourseId,
                Title = chapter.Course.Title,
                Description = chapter.Course.Description
            }
        };

        // Process resources and structure them
        var lessonResource = chapter.Resources.FirstOrDefault(r => 
            r.Type.ToLower() == "lesson" || r.Type.ToLower() == "note" || r.Type.ToLower() == "text");
        
        if (lessonResource != null)
        {
            // Parse the notes content into structured sections
            dto.Notes = ChapterContentParser.ParseNotesContent(lessonResource.Content);
        }

        // Process flashcards
        var flashcardResource = chapter.Resources.FirstOrDefault(r => r.Type.ToLower() == "flashcard");
        if (flashcardResource != null)
        {
            dto.Flashcards = flashcardResource.Flashcards
                .OrderBy(f => f.OrderIndex)
                .Select(f => new FlashcardDto
                {
                    FcId = f.FcId,
                    FrontText = f.FrontText,
                    BackText = f.BackText,
                    OrderIndex = f.OrderIndex
                })
                .ToList();
        }

        // Process quiz
        var quizResource = chapter.Resources.FirstOrDefault(r => r.Type.ToLower() == "mcq");
        if (quizResource != null)
        {
            dto.Quiz = new QuizResourceDto
            {
                ResourceId = quizResource.ResourceId,
                Questions = quizResource.Questions
                    .OrderBy(q => q.QuestionId)
                    .Select(q => new QuestionDto
                    {
                        QuestionId = q.QuestionId,
                        Stem = q.Stem,
                        Difficulty = q.Difficulty,
                        Explanation = q.Explanation,
                        Options = q.QuestionOptions
                            .OrderBy(qo => qo.OptionId)
                            .Select(qo => new QuestionOptionDto
                            {
                                OptionId = qo.OptionId,
                                OptionText = qo.OptionText,
                                IsCorrect = qo.IsCorrect
                            })
                            .ToList()
                    })
                    .ToList()
            };
        }

        return Ok(dto);
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Error retrieving chapter content for chapter {ChapterId}", chapterId);
        return StatusCode(500, new { error = "An error occurred while retrieving chapter content" });
    }
}
```

---

### Step 4: Update Frontend to Use Structured DTO

**File: `client/src/pages/ChapterPage.jsx`**

Update the `resources` useMemo (around line 117):

```javascript
const resources = useMemo(() => {
  if (!chapterData) {
    return { lesson: null, flashcards: null, quiz: null, notes: null };
  }
  
  // Handle DTO structure
  return {
    lesson: chapterData.notes ? {
      content: chapterData.notes.fullContent || '',
      structured: chapterData.notes // Structured sections
    } : null,
    flashcards: chapterData.flashcards || [],
    quiz: chapterData.quiz || null,
    notes: chapterData.notes // Full structured notes object
  };
}, [chapterData]);
```

Update the render section (around line 437) to use structured sections:

```javascript
{hasStartedLearning && resources.notes && (
  <div className="lesson-content">
    {/* Introduction */}
    {resources.notes.introduction && (
      <div className="lesson-introduction">
        <div 
          className="lesson-html-content"
          dangerouslySetInnerHTML={{ __html: resources.notes.introduction }}
        />
      </div>
    )}
    
    {/* Subtopics */}
    {resources.notes.subtopics && resources.notes.subtopics.length > 0 && (
      <div className="lesson-subtopics">
        {resources.notes.subtopics.map((subtopic, index) => (
          <div key={index} className="subtopic-section">
            <h3>{subtopic.heading}</h3>
            <div 
              className="lesson-html-content"
              dangerouslySetInnerHTML={{ __html: subtopic.content }}
            />
          </div>
        ))}
      </div>
    )}
    
    {/* Code Samples */}
    {resources.notes.codeSamples && resources.notes.codeSamples.length > 0 && (
      <div className="lesson-code-samples">
        <h3>Code Examples</h3>
        {resources.notes.codeSamples.map((sample, index) => (
          <div key={index} className="code-sample">
            <h4>{sample.title}</h4>
            <pre><code className={`language-${sample.language}`}>{sample.code}</code></pre>
            {sample.explanation && <p>{sample.explanation}</p>}
          </div>
        ))}
      </div>
    )}
    
    {/* Practice Ideas */}
    {resources.notes.practiceIdeas && (
      <div className="lesson-practice">
        <h3>Practice Ideas</h3>
        <div 
          className="lesson-html-content"
          dangerouslySetInnerHTML={{ __html: resources.notes.practiceIdeas }}
        />
      </div>
    )}
    
    {/* Fallback to full content if structured sections aren't available */}
    {!resources.notes.introduction && 
     (!resources.notes.subtopics || resources.notes.subtopics.length === 0) && 
     resources.notes.fullContent && (
      <div className="lesson-content-wrapper">
        <div 
          className="lesson-html-content"
          dangerouslySetInnerHTML={{ __html: resources.notes.fullContent }}
        />
      </div>
    )}
  </div>
)}
```

---

## How It Works

1. **DTO Structure**: The `ChapterContentDto` provides a clean, structured representation of chapter data separated into logical sections (notes, flashcards, quiz, practice lab).

2. **Content Parsing**: The `ChapterContentParser` uses regex patterns to:
   - Extract introduction (text before first heading)
   - Extract subtopics (markdown headings #, ##, ### with their content)
   - Extract code samples (markdown code blocks with ```)
   - Extract practice ideas (sections mentioning "practice", "exercise", etc.)

3. **Fallback Strategy**: If parsing fails or no structured sections are found, the original `FullContent` is returned so the frontend can still display the content.

4. **Frontend Consumption**: The frontend receives structured data and can render each section in its appropriate container, making the UI more organized and maintainable.

---

## Benefits

✅ **Separation of Concerns**: Database structure vs. API structure vs. Frontend structure  
✅ **Maintainability**: Easy to modify parsing logic without changing database schema  
✅ **Flexibility**: Can adjust how content is split without affecting stored data  
✅ **Backward Compatibility**: Fallback to full content ensures existing functionality still works  
✅ **Type Safety**: Strongly-typed DTOs prevent runtime errors  

---

## Testing

After implementation, test the endpoint:

```http
GET /api/students/chapters/{chapterId}/content
```

Expected response structure:
```json
{
  "chapterId": "...",
  "chapterTitle": "...",
  "chapterSummary": "...",
  "number": 1,
  "courseId": "...",
  "course": { ... },
  "notes": {
    "fullContent": "...",
    "introduction": "...",
    "subtopics": [
      {
        "heading": "...",
        "content": "...",
        "order": 0
      }
    ],
    "codeSamples": [
      {
        "title": "...",
        "code": "...",
        "language": "python"
      }
    ],
    "practiceIdeas": "..."
  },
  "flashcards": [ ... ],
  "quiz": { ... }
}
```

---

## Notes

- The parser uses regex which works well for markdown-style content. For more complex HTML, consider using an HTML parser library like `HtmlAgilityPack`.
- The parsing patterns can be adjusted based on your actual content format.
- The DTO structure can be extended with additional fields as needed (e.g., `PracticeLab`, `VideoLinks`, etc.).

