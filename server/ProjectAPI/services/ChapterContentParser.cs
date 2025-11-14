using System.Text.RegularExpressions;
using ProjectAPI.DTOs;

namespace ProjectAPI.Services;

/// <summary>
/// Parses HTML/text content from database into structured DTO sections
/// </summary>
public class ChapterContentParser
{
    /// <summary>
    /// Parses raw HTML/text content from database into structured notes sections
    /// Handles the actual format used in the database (plain text headings, *insert code example below* markers)
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

        // Try to extract introduction (first paragraph before first heading or bullet point)
        // Look for text before the first heading pattern (lines starting with capital letters, not bullets)
        var introPattern = @"^(.+?)(?=\n\s*[A-Z][A-Za-z\s]{10,}|$)";
        var introMatch = Regex.Match(rawContent, introPattern, RegexOptions.Singleline | RegexOptions.IgnoreCase);
        if (introMatch.Success)
        {
            var introText = introMatch.Groups[1].Value.Trim();
            // Only use as introduction if it's substantial and doesn't start with a bullet or heading
            if (introText.Length > 50 && !introText.StartsWith("•") && !introText.StartsWith("*"))
            {
                notes.Introduction = CleanHtml(introText);
            }
        }

        // Extract subtopics - look for headings (lines that are standalone, capitalized, not bullets)
        // Pattern: Line starting with capital letter, followed by content until next heading or end
        // Headings are typically: "Variables", "Data Types", "Input & Output", etc.
        var headingPattern = @"(?:^|\n)\s*([A-Z][A-Za-z\s&]{3,50})\s*(?=\n|$)";
        var headingMatches = Regex.Matches(rawContent, headingPattern, RegexOptions.Multiline);
        
        int order = 0;
        foreach (Match match in headingMatches)
        {
            var heading = match.Groups[1].Value.Trim();
            
            // Skip common non-heading patterns
            if (heading.Contains("insert code") || heading.Contains("Example:") || 
                heading.Contains("Output:") || heading.Contains("Explanation:") ||
                heading.Length < 3 || heading.Length > 80)
                continue;
            
            var contentStart = match.Index + match.Length;
            var nextMatch = headingMatches.Cast<Match>()
                .FirstOrDefault(m => m.Index > match.Index);
            
            var contentEnd = nextMatch?.Index ?? rawContent.Length;
            var content = rawContent.Substring(contentStart, contentEnd - contentStart).Trim();
            
            // Skip if content is too short or heading is too generic
            if (content.Length > 20 && !string.IsNullOrWhiteSpace(heading))
            {
                notes.Subtopics.Add(new SubtopicDto
                {
                    Heading = heading,
                    Content = CleanHtml(content),
                    Order = order++
                });
            }
        }

        // Extract code samples - look for "*insert code example below*" markers
        // The code follows immediately after this marker
        var codeMarkerPattern = @"\*insert code example below\*[\s\n]+(.*?)(?=\n\s*(?:\*insert|•|[A-Z][A-Za-z\s]{10,}|$))";
        var codeMatches = Regex.Matches(rawContent, codeMarkerPattern, RegexOptions.Singleline | RegexOptions.IgnoreCase);
        
        int codeIndex = 0;
        foreach (Match match in codeMatches)
        {
            var code = match.Groups[1].Value.Trim();
            
            // Clean up the code (remove leading/trailing whitespace, normalize)
            code = Regex.Replace(code, @"^\s+|\s+$", "", RegexOptions.Multiline);
            
            if (!string.IsNullOrWhiteSpace(code) && code.Length > 5)
            {
                notes.CodeSamples.Add(new CodeSampleDto
                {
                    Title = $"Code Example {++codeIndex}",
                    Code = code,
                    Language = "python" // Default to python for this course
                });
            }
        }

        // Also try to extract markdown-style code blocks (```) if present
        var markdownCodePattern = @"```(\w+)?\s*\n(.*?)```";
        var markdownMatches = Regex.Matches(rawContent, markdownCodePattern, RegexOptions.Singleline | RegexOptions.IgnoreCase);
        
        foreach (Match match in markdownMatches)
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
        var practicePattern = @"(?:Practice|Exercise|Try|Challenge)[\s\S]*?(?=\n\s*[A-Z][A-Za-z\s]{10,}|$)";
        var practiceMatch = Regex.Match(rawContent, practicePattern, RegexOptions.IgnoreCase | RegexOptions.Multiline);
        if (practiceMatch.Success)
        {
            notes.PracticeIdeas = CleanHtml(practiceMatch.Value.Trim());
        }

        // If no structured sections found, at least return the full content
        if (notes.Subtopics.Count == 0 && string.IsNullOrEmpty(notes.Introduction))
        {
            // Use first 500 chars as introduction
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

