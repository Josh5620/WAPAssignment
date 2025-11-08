import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import GuestCourseCatalog from '../components/GuestCourseCatalog';
import GuestSearch from '../components/GuestSearch';
import GuestAccessPrompt from '../components/GuestAccessPrompt';
import GuestRestrictionBanner from '../components/GuestRestrictionBanner';
import PrimaryButton from '../components/PrimaryButton';
import { api } from '../services/apiService';
import '../styles/GuestCoursesPage.css';

const DIFFICULTY_OPTIONS = [
  { value: 'all', label: 'All Levels' },
  { value: 'beginner', label: 'Beginner' },
  { value: 'intermediate', label: 'Intermediate' },
  { value: 'advanced', label: 'Advanced' },
];

const CATEGORY_OPTIONS = [
  { value: 'all', label: 'All Categories' },
  { value: 'basics', label: 'Basics' },
  { value: 'data-structures', label: 'Data Structures' },
  { value: 'oop', label: 'Object-Oriented Programming' },
  { value: 'web-development', label: 'Web Development' },
  { value: 'automation', label: 'Automation' },
  { value: 'data-science', label: 'Data Science' },
];

const SORT_OPTIONS = [
  { value: 'popular', label: 'Most Popular' },
  { value: 'newest', label: 'Newest' },
  { value: 'a-z', label: 'A - Z' },
  { value: 'difficulty', label: 'Difficulty' },
];

const INITIAL_STATE = {
  search: '',
  difficulty: 'all',
  category: 'all',
  sort: 'popular',
  page: 1,
  limit: 12,
};

const GuestCoursesPage = () => {
  const navigate = useNavigate();
  const isLoggedIn = getUser() !== null;
  const [filters, setFilters] = useState(INITIAL_STATE);
  const [debouncedSearch, setDebouncedSearch] = useState('');
  const [courses, setCourses] = useState([]);
  const [totalPages, setTotalPages] = useState(1);
  const [totalCount, setTotalCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    if (isLoggedIn) {
      navigate('/courses', { replace: true });
    }
  }, [isLoggedIn, navigate]);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearch(filters.search);
    }, 350);

    return () => clearTimeout(timer);
  }, [filters.search]);

  useEffect(() => {
    let isMounted = true;
    const fetchCourses = async () => {
      try {
        setLoading(true);
        const response = await api.guests.getCourseCatalog({
          search: debouncedSearch,
          difficulty: filters.difficulty,
          category: filters.category,
          sort: filters.sort,
          page: filters.page,
          limit: filters.limit,
        });

        if (!isMounted) return;
        setCourses(response.courses || []);
        setTotalPages(response.totalPages || 1);
        setTotalCount(response.totalCount || (response.courses || []).length);
        setError('');
      } catch (err) {
        console.error('Failed to load guest courses:', err);
        if (isMounted) {
          setError('We had trouble loading courses. Please try again in a moment.');
        }
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    };

    fetchCourses();
    return () => {
      isMounted = false;
    };
  }, [debouncedSearch, filters.category, filters.difficulty, filters.page, filters.sort, filters.limit]);

  if (isLoggedIn) {
    return null;
  }

  const updateFilter = (key, value) => {
    setFilters((prev) => ({
      ...prev,
      [key]: value,
      page: key === 'page' ? value : 1,
    }));
  };

  const activeFilters = useMemo(() => {
    const pills = [];
    if (filters.search) pills.push({ key: 'search', label: `Search: ${filters.search}` });
    if (filters.difficulty !== 'all') pills.push({ key: 'difficulty', label: DIFFICULTY_OPTIONS.find((o) => o.value === filters.difficulty)?.label });
    if (filters.category !== 'all') pills.push({ key: 'category', label: CATEGORY_OPTIONS.find((o) => o.value === filters.category)?.label });
    if (filters.sort !== 'popular') pills.push({ key: 'sort', label: SORT_OPTIONS.find((o) => o.value === filters.sort)?.label });
    return pills.filter(Boolean);
  }, [filters]);

  const clearFilter = (key) => {
    if (key === 'search') {
      updateFilter('search', '');
    } else if (key === 'difficulty') {
      updateFilter('difficulty', 'all');
    } else if (key === 'category') {
      updateFilter('category', 'all');
    } else if (key === 'sort') {
      updateFilter('sort', 'popular');
    }
  };

  const clearAllFilters = () => {
    setFilters(INITIAL_STATE);
  };

  return (
    <>
      <Navbar />
      <div className="guest-courses-page">
        <GuestRestrictionBanner message="Sign up to access full chapters, quizzes, and personalized progress tracking." />
        <header className="guest-courses-header">
          <div className="guest-courses-heading">
            <h1>Explore Python Courses</h1>
            <p>
              Browse a curated curriculum designed to grow with you. Preview the first chapters before joining CodeSage.
            </p>
          </div>
          <PrimaryButton size="md" onClick={() => navigate('/register')}>
            Get Started Free
          </PrimaryButton>
        </header>

        <section className="guest-courses-filters" aria-label="Course filters">
          <div className="filter-row">
            <div className="filter-search">
              <label htmlFor="course-search" className="filter-label">
                Search courses
              </label>
              <input
                id="course-search"
                type="search"
                value={filters.search}
                onChange={(event) => updateFilter('search', event.target.value)}
                placeholder="Search by title, topic, or keyword"
              />
            </div>
            <div className="filter-group">
              <label htmlFor="difficulty-select" className="filter-label">Difficulty</label>
              <select
                id="difficulty-select"
                value={filters.difficulty}
                onChange={(event) => updateFilter('difficulty', event.target.value)}
              >
                {DIFFICULTY_OPTIONS.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>
            <div className="filter-group">
              <label htmlFor="category-select" className="filter-label">Category</label>
              <select
                id="category-select"
                value={filters.category}
                onChange={(event) => updateFilter('category', event.target.value)}
              >
                {CATEGORY_OPTIONS.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>
            <div className="filter-group">
              <label htmlFor="sort-select" className="filter-label">Sort by</label>
              <select
                id="sort-select"
                value={filters.sort}
                onChange={(event) => updateFilter('sort', event.target.value)}
              >
                {SORT_OPTIONS.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {activeFilters.length > 0 && (
            <div className="active-filters" role="status" aria-live="polite">
              {activeFilters.map((filter) => (
                <button
                  key={filter.key}
                  className="filter-pill"
                  onClick={() => clearFilter(filter.key)}
                >
                  {filter.label}
                  <span aria-hidden>×</span>
                </button>
              ))}
              <PrimaryButton variant="ghost" size="sm" onClick={clearAllFilters}>
                Clear All
              </PrimaryButton>
            </div>
          )}
        </section>

        <section className="guest-course-results" aria-live="polite">
          {loading && <div className="guest-courses-loading">Loading courses…</div>}
          {!loading && error && <div className="guest-courses-error">{error}</div>}
          {!loading && !error && courses.length === 0 && (
            <div className="guest-courses-empty">
              <h3>No courses found</h3>
              <p>Try adjusting your filters or search terms to discover more courses.</p>
              <PrimaryButton variant="outline" onClick={clearAllFilters}>
                Clear filters
              </PrimaryButton>
            </div>
          )}
          {!loading && !error && courses.length > 0 && (
            <GuestCourseCatalog courses={courses} limit={filters.limit} />
          )}
        </section>

        <div className="guest-courses-pagination" role="navigation" aria-label="Courses pagination">
          <button
            className="pagination-button"
            onClick={() => updateFilter('page', Math.max(1, filters.page - 1))}
            disabled={filters.page === 1}
            aria-label="Previous page"
          >
            Previous
          </button>
          <div className="pagination-pages">
            {Array.from({ length: totalPages }, (_, index) => index + 1).map((page) => (
              <button
                key={page}
                className={`page-number${page === filters.page ? ' is-active' : ''}`}
                onClick={() => updateFilter('page', page)}
              >
                {page}
              </button>
            ))}
          </div>
          <button
            className="pagination-button"
            onClick={() => updateFilter('page', Math.min(totalPages, filters.page + 1))}
            disabled={filters.page === totalPages}
            aria-label="Next page"
          >
            Next
          </button>
        </div>

        <section className="guest-search-section" aria-label="Advanced search">
          <details>
            <summary>Looking for something specific? Try the advanced search.</summary>
            <GuestSearch />
          </details>
        </section>

        <aside className="guest-courses-cta">
          <GuestAccessPrompt
            title="Want full access?"
            message="Create a free account to unlock quizzes, flashcards, progress tracking, and community features."
            featureList={[
              'Complete chapter library',
              'Interactive quizzes with hints',
              'Flashcards and practice challenges',
              'Track your growth across paths',
              'Unlock badges and achievements',
              'Join the learner community',
            ]}
          />
        </aside>
      </div>
    </>
  );
};

export default GuestCoursesPage;

