import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../services/apiService';
import GuestRestrictionBanner from './GuestRestrictionBanner';
import GuestAccessPrompt from './GuestAccessPrompt';

const GuestSearch = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [results, setResults] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const handleSearch = async (e) => {
    e.preventDefault();
    
    if (!searchQuery.trim()) {
      setError('Please enter a search term');
      return;
    }

    try {
      setLoading(true);
      setError(null);
      const data = await api.guests.searchContent(searchQuery);
      setResults(data);
    } catch (err) {
      console.error('Search failed:', err);
      setError(err.message || 'Search failed. Please try again.');
      setResults(null);
    } finally {
      setLoading(false);
    }
  };

  const handleViewCourse = (courseId) => {
    navigate(`/guest/courses/${courseId}/preview`);
  };

  return (
    <div className="guest-search">
      <GuestRestrictionBanner 
        message="Search results are limited to public content only. Register or log in to search and access all course materials, quizzes, and resources."
      />

      <div className="search-header">
        <h2>Search Courses</h2>
        <p className="search-notice">
          <strong>Limited Search:</strong> Results show only public course information. Register for full search access.
        </p>
      </div>

      <form className="search-form" onSubmit={handleSearch}>
        <div className="search-input-group">
          <input
            type="text"
            className="search-input"
            placeholder="Search courses, chapters..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
          <button
            type="submit"
            className="search-button"
            disabled={loading}
          >
            {loading ? 'Searching...' : 'Search'}
          </button>
        </div>
      </form>

      {error && (
        <div className="search-error">
          <p>{error}</p>
        </div>
      )}

      {results && (
        <div className="search-results">
          <div className="results-header">
            <h3>Search Results</h3>
            <p className="results-count">
              Found {results.results.totalResults} result(s) for "{results.query}"
            </p>
            <p className="results-notice">
              <strong>⚠️ Limited Results:</strong> {results.message}
            </p>
          </div>

          {results.results.courses && results.results.courses.length > 0 && (
            <div className="results-section">
              <h4>Courses ({results.results.courses.length})</h4>
              <div className="results-grid">
                {results.results.courses.map((course) => (
                  <div key={course.courseId} className="result-card course-result">
                    <h5>{course.title}</h5>
                    {course.description && <p>{course.description}</p>}
                    {course.previewContent && (
                      <p className="preview-text">{course.previewContent}</p>
                    )}
                    <button
                      className="view-button"
                      onClick={() => handleViewCourse(course.courseId)}
                    >
                      View Preview
                    </button>
                  </div>
                ))}
              </div>
            </div>
          )}

          {results.results.chapters && results.results.chapters.length > 0 && (
            <div className="results-section">
              <h4>Chapters ({results.results.chapters.length})</h4>
              <div className="results-list">
                {results.results.chapters.map((chapter) => (
                  <div key={chapter.chapterId} className="result-card chapter-result">
                    <div className="chapter-result-header">
                      <span className="chapter-number">
                        Chapter {chapter.chapterNumber}
                      </span>
                      <span className="course-name">{chapter.courseTitle}</span>
                    </div>
                    <h5>{chapter.chapterTitle}</h5>
                    {chapter.chapterSummary && (
                      <p>{chapter.chapterSummary}</p>
                    )}
                    <button
                      className="view-button"
                      onClick={() => handleViewCourse(chapter.courseId)}
                    >
                      View Course Preview
                    </button>
                  </div>
                ))}
              </div>
            </div>
          )}

          {results.results.totalResults === 0 && (
            <div className="no-results">
              <p>No results found for "{results.query}"</p>
              <p>Try different keywords or browse the course catalog.</p>
            </div>
          )}
        </div>
      )}

      {results && results.results.totalResults > 0 && (
        <GuestAccessPrompt
          title="Want to See More?"
          message="Register to access full course content, detailed search results, and all learning materials!"
          featureList={[
            'Full course content search',
            'Search within quizzes and flashcards',
            'Access to all course materials',
            'Advanced search filters'
          ]}
        />
      )}
    </div>
  );
};

export default GuestSearch;

