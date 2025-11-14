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
    // Notes will always be set (never null) by the controller
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

