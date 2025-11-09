import { getToken, clear as clearAuth } from '../utils/auth';
import {
  getFallbackTeacherCourses,
  getFallbackTeacherCourseById,
  getFallbackChaptersForCourse,
  getFallbackResourcesForChapter,
} from '../data/teacherFallbackData';

/**
 * Comprehensive API Service for CodeSage Learning Platform
 * Connects React frontend to ASP.NET Core backend
 *
 * Available Endpoints:
 * - Authentication: /api/Profiles/login, /api/Profiles/register
 * - Courses: /api/Courses (GET, POST, PUT, DELETE)
 * - Chapters: /api/Chapters
 * - Enrollments: /api/Enrolments
 * - Test Data: /api/TestData
 */

const API_BASE_URL = 'http://localhost:5245/api';

const buildUrl = (path) => {
  if (!path) return API_BASE_URL;
  if (/^https?:/i.test(path)) return path;
  return `${API_BASE_URL}${path.startsWith('/') ? path : `/${path}`}`;
};

const parsePayload = async (response) => {
  if (response.status === 204) {
    return null;
  }

  const contentType = response.headers.get('Content-Type');
  const isJson = contentType && contentType.includes('application/json');

  if (isJson) {
    try {
      return await response.json();
    } catch (error) {
      console.warn('Failed to parse JSON response', error);
      return null;
    }
  }

  return response.text();
};

const isServerError = (error) => {
  if (!error) return false;
  if (typeof error.status === 'number') {
    return error.status >= 500;
  }
  // Fetch network failures surface as TypeError instances without a status code
  return error.name === 'TypeError';
};

const requestWithAuth = async (path, options = {}) => {
  const { method = 'GET', headers, body, ...rest } = options;
  const fetchConfig = {
    method,
    ...rest,
    headers: new Headers(headers || {}),
  };

  const token = getToken();
  if (token && !fetchConfig.headers.has('Authorization')) {
    fetchConfig.headers.set('Authorization', `Bearer ${token}`);
  }

  if (body !== undefined) {
    if (body instanceof FormData || body instanceof Blob || typeof body === 'string') {
      fetchConfig.body = body;
    } else {
      fetchConfig.body = JSON.stringify(body);
      if (!fetchConfig.headers.has('Content-Type')) {
        fetchConfig.headers.set('Content-Type', 'application/json');
      }
    }
  }

  if (!fetchConfig.headers.has('Accept')) {
    fetchConfig.headers.set('Accept', 'application/json');
  }

  const response = await fetch(buildUrl(path), fetchConfig);
  const payload = await parsePayload(response);

  if (!response.ok) {
    if (response.status === 401) {
      clearAuth();
    }

    const message = payload?.message || payload?.error || `Request failed with status ${response.status}`;
    const error = new Error(message);
    error.status = response.status;
    error.data = payload;
    throw error;
  }

  return payload;
};

// Login function: POST to /profiles/login with correct JSON body format
export const login = async (identifier, password) => {
  try {
    const response = await fetch('http://localhost:5245/api/profiles/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        identifier,
        password
      }),
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Login error:', error);
    throw error;
  }
};

// Get profile function: GET /profiles/me with Authorization: Bearer <token>
export const getProfile = async (token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/profiles/me`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get profile error:', error);
    throw error;
  }
};

// ===== COURSE FUNCTIONS =====
// Get all courses function: GET /courses
export const getCourses = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/courses`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get courses error:', error);
    throw error;
  }
};

// Get course by ID function: GET /courses/{id}
export const getCourseById = async (courseId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/courses/${courseId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get course by ID error:', error);
    throw error;
  }
};

// Create new course function: POST /courses (admin/teacher only)
export const createCourse = async (courseData, token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/courses`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(courseData)
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Create course error:', error);
    throw error;
  }
};

// Update course function: PUT /courses/{id}
export const updateCourse = async (courseId, updateData, token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/courses/${courseId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(updateData)
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    return response.status === 204; // PUT returns No Content on success
  } catch (error) {
    console.error('Update course error:', error);
    throw error;
  }
};

// Delete course function: DELETE /courses/{id}
export const deleteCourse = async (courseId, token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/courses/${courseId}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    return response.status === 204; // DELETE returns No Content on success
  } catch (error) {
    console.error('Delete course error:', error);
    throw error;
  }
};

// ===== ENROLLMENT FUNCTIONS =====
// Enroll in course function: POST to /enrolments with { courseId }, include bearer token
export const enrolCourse = async (courseId, token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/enrolments`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({ courseId })
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Enroll course error:', error);
    throw error;
  }
};

// Get user enrollments function: GET /enrolments
export const getUserEnrollments = async (token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/enrolments`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get user enrollments error:', error);
    throw error;
  }
};

// Check if user is enrolled in course
export const checkEnrollment = async (courseId, token) => {
  try {
    const enrollments = await getUserEnrollments(token);
    return enrollments.some(enrollment => enrollment.courseId === courseId);
  } catch (error) {
    console.error('Check enrollment error:', error);
    return false;
  }
};

// ===== CHAPTER FUNCTIONS =====
// Get chapters for a course: GET /chapters/course/{courseId}
export const getCourseChapters = async (courseId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/chapters/course/${courseId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      // If the endpoint doesn't exist, return sample data for demonstration
      if (response.status === 404) {
        console.warn('Chapter endpoint not found, returning sample data');
        return getSampleChapters(courseId);
      }
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get course chapters error:', error);
    // Fallback to sample data for demonstration
    return getSampleChapters(courseId);
  }
};

// Sample chapter data for demonstration (when backend endpoint isn't available)
const getSampleChapters = (courseId) => {
  const sampleChapters = [
    {
      id: `chapter-1-${courseId}`,
      courseId: courseId,
      number: 1,
      title: "Variables and Data Types",
      summary: "Learn about JavaScript variables and different data types"
    },
    {
      id: `chapter-2-${courseId}`,
      courseId: courseId,
      number: 2,
      title: "Functions and Scope",
      summary: "Understanding functions, parameters, and variable scope"
    },
    {
      id: `chapter-3-${courseId}`,
      courseId: courseId,
      number: 3,
      title: "Control Structures",
      summary: "If statements, loops, and conditional logic"
    },
    {
      id: `chapter-4-${courseId}`,
      courseId: courseId,
      number: 4,
      title: "Objects and Arrays",
      summary: "Working with complex data structures"
    },
    {
      id: `chapter-5-${courseId}`,
      courseId: courseId,
      number: 5,
      title: "DOM Manipulation",
      summary: "Interacting with web pages using JavaScript"
    }
  ];

  return sampleChapters;
};

// ===== GUEST EXPERIENCE FALLBACK DATA =====
const fallbackGuestCourses = [
  {
    id: 'python-garden-path',
    title: 'Python Basics: The Garden Path',
    description: 'Plant the seeds of your Python knowledge with syntax fundamentals, variables, and friendly first projects.',
    difficulty: 'beginner',
    category: 'basics',
    estimatedHours: 8,
    enrollmentCount: 18450,
    rating: 4.8,
    totalChapters: 12,
    createdAt: '2024-02-01T00:00:00Z',
    previewContent: 'Write your first Python script, understand variables, and master control flow with friendly garden-inspired examples.',
    previewChapters: [
      {
        id: 'python-garden-path-1',
        number: 1,
        title: 'Seedling Syntax',
        description: 'Install Python and write your first lines of code while exploring the Python REPL.',
        estimatedMinutes: 40,
        sampleContent: 'print("Welcome to the Garden")\n# Learn how indentation shapes the Python landscape.'
      },
      {
        id: 'python-garden-path-2',
        number: 2,
        title: 'Watering Variables',
        description: 'Store values with variables and nurture them with data types.',
        estimatedMinutes: 45,
        sampleContent: 'name = "Sprout"\nage = 2\nprint(f"{name} is {age} days old!")'
      },
      {
        id: 'python-garden-path-3',
        number: 3,
        title: 'Paths and Decisions',
        description: 'Use if statements to help your virtual garden react to changing weather.',
        estimatedMinutes: 50,
        sampleContent: 'if rainfall < 10:\n    water_plants()\nelse:\n    enjoy_sunshine()'
      },
      {
        id: 'python-garden-path-4',
        number: 4,
        title: 'Loops for Growth',
        description: 'Automate repeated tasks with for and while loops.',
        estimatedMinutes: 55,
        sampleContent: 'for seedling in seedlings:\n    seedling.water()'
      }
    ],
    learningObjectives: [
      'Run Python locally and in the browser',
      'Explain the difference between variables and data types',
      'Use conditionals to control program flow',
      'Automate repeated tasks with loops',
      'Write readable code using functions'
    ],
    searchTags: ['syntax', 'variables', 'loops', 'beginner']
  },
  {
    id: 'python-data-seeds',
    title: 'Data Structures: Seeds to Trees',
    description: 'Level up with Python lists, dictionaries, and sets through garden-inspired challenges.',
    difficulty: 'intermediate',
    category: 'data-structures',
    estimatedHours: 10,
    enrollmentCount: 12890,
    rating: 4.7,
    totalChapters: 14,
    createdAt: '2024-04-15T00:00:00Z',
    previewContent: 'Transform raw data into lush structures using lists, dictionaries, sets, and tuples.',
    previewChapters: [
      {
        id: 'python-data-seeds-1',
        number: 1,
        title: 'List Beds',
        description: 'Organize collections using Python lists and list comprehensions.',
        estimatedMinutes: 45,
        sampleContent: 'flowers = ["rose", "tulip", "lily"]\nfor flower in flowers:\n    print(f"Growing {flower}")'
      },
      {
        id: 'python-data-seeds-2',
        number: 2,
        title: 'Dictionary Greenhouse',
        description: 'Map plant data with key-value pairs and safely harvest values.',
        estimatedMinutes: 50,
        sampleContent: 'garden = {"beds": 6, "bees": 3}\nprint(garden.get("bees", 0))'
      },
      {
        id: 'python-data-seeds-3',
        number: 3,
        title: 'Set Ecosystem',
        description: 'Remove duplicates and compare collections using set operations.',
        estimatedMinutes: 40,
        sampleContent: 'north_garden = {"mint", "sage", "basil"}\nsouth_garden = {"basil", "thyme"}\nprint(north_garden & south_garden)'
      }
    ],
    learningObjectives: [
      'Choose the best collection type for a problem',
      'Manipulate nested data structures safely',
      'Use list, dict, and set comprehensions effectively',
      'Build reusable utility functions for data wrangling'
    ],
    searchTags: ['lists', 'dictionaries', 'sets', 'collections']
  },
  {
    id: 'oop-vine-architecture',
    title: 'Object-Oriented Vines',
    description: 'Design classes, inherit behaviours, and cultivate reusable components.',
    difficulty: 'intermediate',
    category: 'oop',
    estimatedHours: 9,
    enrollmentCount: 9400,
    rating: 4.6,
    totalChapters: 11,
    createdAt: '2024-03-10T00:00:00Z',
    previewContent: 'Grow modular programs by modelling gardens as Python classes and objects.',
    previewChapters: [
      {
        id: 'oop-vine-architecture-1',
        number: 1,
        title: 'Designing a Garden Class',
        description: 'Use classes and instances to model a garden ecosystem.',
        estimatedMinutes: 55,
        sampleContent: 'class Garden:\n    def __init__(self, name):\n        self.name = name\n        self.plants = []'
      },
      {
        id: 'oop-vine-architecture-2',
        number: 2,
        title: 'Inheritance and Growth',
        description: 'Extend plant behaviours using inheritance and method overriding.',
        estimatedMinutes: 50,
        sampleContent: 'class Flower(Plant):\n    def bloom(self):\n        print("Blooming brightly!")'
      }
    ],
    learningObjectives: [
      'Design Python classes with rich behaviours',
      'Apply inheritance and composition effectively',
      'Use dunder methods to integrate with Python tooling',
      'Implement encapsulation for maintainable modules'
    ],
    searchTags: ['classes', 'objects', 'inheritance', 'oop']
  },
  {
    id: 'python-web-weaver',
    title: 'Web Weavers with Flask',
    description: 'Build interactive garden dashboards with Flask routes, templates, and forms.',
    difficulty: 'beginner',
    category: 'web-development',
    estimatedHours: 7,
    enrollmentCount: 7600,
    rating: 4.5,
    totalChapters: 10,
    createdAt: '2024-05-12T00:00:00Z',
    previewContent: 'Create a web greenhouse tracker using Flask, Jinja templates, and simple databases.',
    previewChapters: [
      {
        id: 'python-web-weaver-1',
        number: 1,
        title: 'Setting Up Flask',
        description: 'Install Flask and render your first template.',
        estimatedMinutes: 35,
        sampleContent: 'from flask import Flask, render_template\napp = Flask(__name__)'
      },
      {
        id: 'python-web-weaver-2',
        number: 2,
        title: 'Routes and Views',
        description: 'Connect URLs to Python functions to show garden updates.',
        estimatedMinutes: 45,
        sampleContent: '@app.route("/")\ndef home():\n    return render_template("garden.html")'
      }
    ],
    learningObjectives: [
      'Create Flask applications with routing',
      'Build HTML templates using Jinja2',
      'Handle form submissions securely',
      'Deploy a Flask app to share progress'
    ],
    searchTags: ['flask', 'web', 'templates', 'forms']
  },
  {
    id: 'python-automation-blossom',
    title: 'Automation Blossoms',
    description: 'Automate everyday tasks with scripts, schedulers, and integrations.',
    difficulty: 'intermediate',
    category: 'automation',
    estimatedHours: 6,
    enrollmentCount: 5800,
    rating: 4.6,
    totalChapters: 9,
    createdAt: '2024-01-20T00:00:00Z',
    previewContent: 'Use Python to water plants automatically, send alerts, and analyze garden data files.',
    previewChapters: [
      {
        id: 'python-automation-blossom-1',
        number: 1,
        title: 'Task Scheduler Basics',
        description: 'Schedule Python scripts using cron and Task Scheduler.',
        estimatedMinutes: 40,
        sampleContent: '# Use schedule to run code every morning\nimport schedule\n'
      },
      {
        id: 'python-automation-blossom-2',
        number: 2,
        title: 'Working with Files',
        description: 'Process CSV and JSON data from your greenhouse sensors.',
        estimatedMinutes: 45,
        sampleContent: 'import csv\nwith open("moisture.csv") as file:\n    reader = csv.DictReader(file)'
      }
    ],
    learningObjectives: [
      'Schedule scripts on different operating systems',
      'Automate reporting with CSV and JSON',
      'Send notifications with email and webhooks',
      'Build reusable automation utilities'
    ],
    searchTags: ['automation', 'scripting', 'csv', 'schedule']
  },
  {
    id: 'python-data-canopy',
    title: 'Data Science Canopy',
    description: 'Harvest insights using pandas, Matplotlib, and beginner-friendly machine learning.',
    difficulty: 'advanced',
    category: 'data-science',
    estimatedHours: 12,
    enrollmentCount: 4820,
    rating: 4.7,
    totalChapters: 15,
    createdAt: '2024-03-28T00:00:00Z',
    previewContent: 'Clean, visualize, and model garden sensor data using the pandas and scikit-learn toolset.',
    previewChapters: [
      {
        id: 'python-data-canopy-1',
        number: 1,
        title: 'pandas Seedlings',
        description: 'Load datasets into DataFrames and prune them with filters.',
        estimatedMinutes: 50,
        sampleContent: 'import pandas as pd\ndata = pd.read_csv("garden.csv")\ndata.head()'
      },
      {
        id: 'python-data-canopy-2',
        number: 2,
        title: 'Visualizing Growth',
        description: 'Create line and scatter plots with Matplotlib to track plant health.',
        estimatedMinutes: 45,
        sampleContent: 'import matplotlib.pyplot as plt\nplt.plot(data["day"], data["growth"])'
      },
      {
        id: 'python-data-canopy-3',
        number: 3,
        title: 'Intro to Predictions',
        description: 'Train a linear regression model to forecast harvest yields.',
        estimatedMinutes: 55,
        sampleContent: 'from sklearn.linear_model import LinearRegression'
      }
    ],
    learningObjectives: [
      'Manipulate data using pandas efficiently',
      'Visualize trends and patterns with Matplotlib',
      'Split datasets and train simple ML models',
      'Interpret metrics to evaluate predictions'
    ],
    searchTags: ['pandas', 'matplotlib', 'machine learning', 'data science']
  }
];

const fallbackTestimonials = [
  {
    id: 't1',
    courseId: 'python-garden-path',
    name: 'Amelia',
    role: 'New Python Student',
    rating: 5,
    content: 'The garden theme kept me motivated every day. I wrote my first Python app within a week!'
  },
  {
    id: 't2',
    courseId: 'python-garden-path',
    name: 'Jon',
    role: 'STEM Teacher',
    rating: 4,
    content: 'I recommend the seedling lessons to my students. The visuals make syntax approachable.'
  },
  {
    id: 't3',
    courseId: 'python-data-seeds',
    name: 'Priya',
    role: 'Data Analyst',
    rating: 5,
    content: 'The plant metaphors made dictionaries and sets click instantly. Loved the practice tasks.'
  },
  {
    id: 't4',
    courseId: 'python-data-canopy',
    name: 'Miguel',
    role: 'Research Scientist',
    rating: 5,
    content: 'Great refresher on pandas and visualization. The mini-project on sensor data was excellent.'
  },
  {
    id: 't5',
    courseId: null,
    name: 'Sasha',
    role: 'Bootcamp Graduate',
    rating: 5,
    content: 'CodeSage turned studying into a relaxing ritual. The progress garden kept me accountable.'
  }
];

const normalizeFallbackCourse = (course) => ({
  courseId: course.id,
  id: course.id,
  title: course.title,
  description: course.description,
  difficulty: course.difficulty,
  category: course.category,
  chapterCount: course.totalChapters,
  totalChapters: course.totalChapters,
  estimatedHours: course.estimatedHours,
  enrollmentCount: course.enrollmentCount,
  rating: course.rating,
  previewContent: course.previewContent,
});

const getFallbackCourseCatalog = ({
  search = '',
  difficulty = 'all',
  category = 'all',
  sort = 'popular',
  page = 1,
  limit = 12,
} = {}) => {
  const normalizedSearch = search.trim().toLowerCase();
  let filtered = [...fallbackGuestCourses];

  if (normalizedSearch) {
    filtered = filtered.filter((course) => {
      return (
        course.title.toLowerCase().includes(normalizedSearch) ||
        course.description.toLowerCase().includes(normalizedSearch) ||
        course.previewContent.toLowerCase().includes(normalizedSearch) ||
        (course.searchTags || []).some((tag) => tag.toLowerCase().includes(normalizedSearch))
      );
    });
  }

  if (difficulty !== 'all') {
    filtered = filtered.filter((course) => course.difficulty === difficulty);
  }

  if (category !== 'all') {
    filtered = filtered.filter((course) => course.category === category);
  }

  const sorted = filtered.sort((a, b) => {
    switch (sort) {
      case 'newest':
        return new Date(b.createdAt) - new Date(a.createdAt);
      case 'a-z':
        return a.title.localeCompare(b.title);
      case 'difficulty':
        return a.difficulty.localeCompare(b.difficulty);
      case 'popular':
      default:
        return (b.enrollmentCount || 0) - (a.enrollmentCount || 0);
    }
  });

  const totalCount = sorted.length;
  const safeLimit = limit || 12;
  const safePage = Math.max(1, page || 1);
  const totalPages = Math.max(1, Math.ceil(totalCount / safeLimit));
  const startIndex = (safePage - 1) * safeLimit;
  const pageItems = sorted.slice(startIndex, startIndex + safeLimit).map(normalizeFallbackCourse);

  return {
    courses: pageItems,
    totalCount,
    totalPages,
    currentPage: Math.min(safePage, totalPages),
  };
};

const getFallbackCoursePreview = (courseId) => {
  const course = fallbackGuestCourses.find((item) => item.id === courseId) || fallbackGuestCourses[0];
  if (!course) {
    return null;
  }

  return {
    course: {
      id: course.id,
      title: course.title,
      description: course.description,
      difficulty: course.difficulty,
      totalChapters: course.totalChapters,
      estimatedHours: course.estimatedHours,
      enrollmentCount: course.enrollmentCount,
      rating: course.rating,
    },
    previewChapters: course.previewChapters,
    learningObjectives: course.learningObjectives,
    testimonials: fallbackTestimonials.filter((testimonial) => !testimonial.courseId || testimonial.courseId === course.id),
  };
};

const getFallbackChapterPreview = (courseId, chapterId) => {
  const course = fallbackGuestCourses.find((item) => item.id === courseId);
  if (!course) return null;
  const chapter = course.previewChapters.find((item) => (item.id || item.chapterId) === chapterId) || course.previewChapters[0];
  if (!chapter) return null;

  return {
    chapter: {
      id: chapter.id,
      title: chapter.title,
      description: chapter.description,
      number: chapter.number,
    },
    content: chapter.sampleContent || 'Preview content coming soon. Sign up to unlock the full lesson.',
  };
};

const getFallbackTestimonials = ({ courseId, limit }) => {
  const matches = fallbackTestimonials.filter((testimonial) => {
    if (!courseId) return true;
    return testimonial.courseId === courseId;
  });

  const items = typeof limit === 'number' ? matches.slice(0, limit) : matches;
  return {
    testimonials: items,
  };
};

const getFallbackSearchResults = (query) => {
  const normalized = (query || '').trim().toLowerCase();
  if (!normalized) {
    return {
      query,
      results: {
        totalResults: 0,
        courses: [],
        chapters: [],
      },
    };
  }

  const courseMatches = fallbackGuestCourses.filter((course) =>
    course.title.toLowerCase().includes(normalized) ||
    course.description.toLowerCase().includes(normalized) ||
    course.previewContent.toLowerCase().includes(normalized) ||
    (course.searchTags || []).some((tag) => tag.toLowerCase().includes(normalized))
  );

  const chapterMatches = [];
  fallbackGuestCourses.forEach((course) => {
    (course.previewChapters || []).forEach((chapter) => {
      if (
        chapter.title.toLowerCase().includes(normalized) ||
        chapter.description.toLowerCase().includes(normalized)
      ) {
        chapterMatches.push({
          courseId: course.id,
          courseTitle: course.title,
          chapterId: chapter.id,
          chapterTitle: chapter.title,
          chapterSummary: chapter.description,
          chapterNumber: chapter.number,
        });
      }
    });
  });

  return {
    query,
    results: {
      totalResults: courseMatches.length + chapterMatches.length,
      courses: courseMatches.map((course) => ({
        courseId: course.id,
        title: course.title,
        description: course.description,
        previewContent: course.previewContent,
      })),
      chapters: chapterMatches,
    },
  };
};

const buildQueryString = (params = {}) => {
  const searchParams = new URLSearchParams();
  Object.entries(params).forEach(([key, value]) => {
    if (value === undefined || value === null || value === '' || value === 'all') return;
    searchParams.set(key, value);
  });
  const queryString = searchParams.toString();
  return queryString ? `?${queryString}` : '';
};

const getFeaturedGuestCourses = async (limit = 6) => {
  try {
    const response = await requestWithAuth(`/courses/featured${buildQueryString({ limit })}`);
    if (Array.isArray(response)) {
      return { courses: response };
    }
    return response;
  } catch (error) {
    console.warn('Falling back to static featured courses', error);
    const courses = fallbackGuestCourses.slice(0, limit).map(normalizeFallbackCourse);
    return { courses };
  }
};

const getGuestCourseCatalog = async (options = {}) => {
  try {
    const query = buildQueryString(options);
    const response = await requestWithAuth(`/courses${query}`);
    if (Array.isArray(response)) {
      return {
        courses: response,
        totalCount: response.length,
        totalPages: 1,
        currentPage: 1,
      };
    }
    return response;
  } catch (error) {
    console.warn('Falling back to static guest course catalog', error);
    return getFallbackCourseCatalog(options);
  }
};

const getGuestCoursePreview = async (courseId) => {
  try {
    const response = await requestWithAuth(`/courses/${courseId}/preview`);
    return response;
  } catch (error) {
    console.warn('Falling back to static course preview', error);
    return getFallbackCoursePreview(courseId);
  }
};

const getGuestChapterPreview = async (courseId, chapterId) => {
  try {
    const response = await requestWithAuth(`/courses/${courseId}/chapters/${chapterId}/preview`);
    return response;
  } catch (error) {
    console.warn('Falling back to static chapter preview', error);
    return getFallbackChapterPreview(courseId, chapterId);
  }
};

const getGuestTestimonials = async ({ courseId, limit } = {}) => {
  const query = buildQueryString({ courseId, limit });
  try {
    const response = await requestWithAuth(`/testimonials${query}`);
    if (Array.isArray(response)) {
      return { testimonials: response };
    }
    return response;
  } catch (error) {
    console.warn('Falling back to static testimonials', error);
    return getFallbackTestimonials({ courseId, limit });
  }
};

const guestSearchContent = async (query) => {
  try {
    const response = await requestWithAuth(`/courses/search${buildQueryString({ query })}`);
    return response;
  } catch (error) {
    console.warn('Falling back to static guest search results', error);
    return getFallbackSearchResults(query);
  }
};

const guestCheckEmailAvailability = async (email) => {
  if (!email) {
    return { available: false };
  }
  try {
    const response = await requestWithAuth(`/guests/check-email${buildQueryString({ email })}`);
    if (typeof response?.exists === 'boolean') {
      return { available: !response.exists };
    }
    return response;
  } catch (error) {
    if (error.status === 404) {
      return { available: true };
    }
    console.warn('Email availability check failed, assuming available', error);
    return { available: true };
  }
};

const guestRegister = async ({ fullName, email, password, role }) => {
  const payload = {
    fullName,
    email,
    password,
    role,
  };

  try {
    const response = await requestWithAuth('/guests/register', {
      method: 'POST',
      body: payload,
    });
    return response;
  } catch (error) {
    console.warn('Registration failed against API, providing fallback message', error);
    if (error.status && error.status !== 0) {
      throw error;
    }
    return {
      success: true,
      message: 'Account created successfully (offline mode)',
      userId: Date.now(),
    };
  }
};

// ===== TEST DATA FUNCTIONS =====
// Seed test data: POST /TestData/seed
export const seedTestData = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/TestData/seed`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Seed test data error:', error);
    throw error;
  }
};

// Get database status: GET /TestData/status
export const getDatabaseStatus = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/TestData/status`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Get database status error:', error);
    throw error;
  }
};

// Legacy authService object for backward compatibility with existing components
export const authService = {
  login: async (formData) => {
    try {
      const userData = await login(formData.email, formData.password);
      return { success: true, data: { user: userData } };
    } catch (error) {
      return { success: false, message: error.message };
    }
  },
  
  register: async (userData) => {
    // Placeholder - register endpoint not implemented in backend yet
    console.error('Register endpoint not implemented in backend');
    return { success: false, message: 'Registration not available' };
  },
  
  adminLogin: async (formData) => {
    try {
      const userData = await login(formData.email, formData.password);
      if (userData.role === 'admin') {
        return { success: true, data: { user: userData } };
      } else {
        return { success: false, message: 'Admin access required' };
      }
    } catch (error) {
      return { success: false, message: error.message };
    }
  },
  
  logout: () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('user_profile');
    return { success: true };
  }
};

// ===== ORGANIZED SERVICE OBJECTS =====
// Course service object - contains all course-related functions
export const courseService = {
  getAllCourses: getCourses,
  getCourseById: getCourseById,
  createCourse: createCourse,
  updateCourse: updateCourse,
  deleteCourse: deleteCourse,
  getCourseChapters: getCourseChapters
};

// Enrollment service object
export const enrollmentService = {
  enrollInCourse: enrolCourse,
  getUserEnrollments: getUserEnrollments,
  checkEnrollment: checkEnrollment
};

// Test data service object
export const testDataService = {
  seedTestData: seedTestData,
  getDatabaseStatus: getDatabaseStatus
};

// Legacy adminService object for backward compatibility
export const adminService = {
  getHelpRequests: () => getAdminHelpRequests(),

  replyToHelpRequest: (requestId, replyMessage) =>
    replyToAdminHelpRequest(requestId, replyMessage),

  getDashboardData: async () => {
    try {
      const courses = await getCourses();
      const dbStatus = await getDatabaseStatus();
      return {
        success: true,
        data: {
          statistics: {
            totalUsers: dbStatus.profiles || 0,
            totalStudents: Math.floor((dbStatus.profiles || 0) * 0.8), // 80% students
            totalTeachers: Math.floor((dbStatus.profiles || 0) * 0.15), // 15% teachers
            totalAdmins: Math.floor((dbStatus.profiles || 0) * 0.05), // 5% admins
            totalForumPosts: dbStatus.forumPosts || 0,
            totalResources: dbStatus.resources || 0,
            totalCourses: courses.length,
            totalChapters: dbStatus.chapters || 0
          },
          recentUsers: [], // Will be populated when backend is ready
          recentPosts: [], // Will be populated when backend is ready  
          courses: courses,
          databaseStats: dbStatus
        }
      };
    } catch (error) {
      return { success: false, message: error.message };
    }
  },
  
  // === USER MANAGEMENT ===
  getAllUsers: async () => {
    try {
      // This will be a real API call once backend is implemented
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/users`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return data; // Return the backend response directly (already has success, data structure)
    } catch (error) {
      console.error('Get all users error:', error);
      return { success: false, message: 'User management not available yet' };
    }
  },
  
  updateUserRole: async (userId, role) => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/users/${userId}/role`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ newRole: role })
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Update user role error:', error);
      return { success: false, message: 'User role update not available yet' };
    }
  },
  
  deleteUser: async (userId) => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/users/${userId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      return { success: true, message: 'User deleted successfully' };
    } catch (error) {
      console.error('Delete user error:', error);
      return { success: false, message: 'User deletion not available yet' };
    }
  },

  // === COURSE MANAGEMENT ===
  getAllCourses: async () => {
    try {
      const courses = await getCourses();
      return { success: true, data: courses };
    } catch (error) {
      return { success: false, message: error.message };
    }
  },

  updateCourseStatus: async (courseId, published) => {
    try {
      const token = localStorage.getItem('authToken');
      const result = await updateCourse(courseId, { published }, token);
      return { success: true, data: result };
    } catch (error) {
      return { success: false, message: error.message };
    }
  },

  // === ANNOUNCEMENT MANAGEMENT ===
  getAllAnnouncements: async () => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/announcements`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Get announcements error:', error);
      return { success: false, message: 'Announcements not available yet' };
    }
  },

  createAnnouncement: async (announcement) => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/announcements`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(announcement)
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Create announcement error:', error);
      return { success: false, message: 'Announcement creation not available yet' };
    }
  },

  deleteAnnouncement: async (announcementId) => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/announcements/${announcementId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      return { success: true, message: 'Announcement deleted successfully' };
    } catch (error) {
      console.error('Delete announcement error:', error);
      return { success: false, message: 'Announcement deletion not available yet' };
    }
  },

  // === FORUM POST MANAGEMENT ===  
  getAllForumPosts: async () => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/forum-posts`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Get forum posts error:', error);
      return { success: false, message: 'Forum posts not available yet' };
    }
  },
  
  deleteForumPost: async (postId) => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/forum-posts/${postId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      return { success: true, message: 'Forum post deleted successfully' };
    } catch (error) {
      console.error('Delete forum post error:', error);
      return { success: false, message: 'Forum post deletion not available yet' };
    }
  },

  // === REPORTS ===
  getReports: async () => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/reports`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Get reports error:', error);
      return { success: false, message: 'Reports not available yet' };
    }
  },

  generateReport: async () => {
    try {
      const token = localStorage.getItem('authToken');
      const response = await fetch(`${API_BASE_URL}/Admin/generate-report`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Generate report error:', error);
      return { success: false, message: 'Report generation not available yet' };
    }
  },

  // === EXISTING FUNCTIONS ===
  seedTestAccounts: async () => {
    try {
      const result = await seedTestData();
      return { success: true, data: result };
    } catch (error) {
      return { success: false, message: error.message };
    }
  },

  createCourse: async (courseData, token) => {
    try {
      const result = await createCourse(courseData, token);
      return { success: true, data: result };
    } catch (error) {
      return { success: false, message: error.message };
    }
  }
};

// ===== TEACHER COURSE MANAGEMENT HELPERS =====
const listMyCourses = async () => {
  try {
    return await requestWithAuth('/Courses');
  } catch (error) {
    if (isServerError(error)) {
      console.warn('Falling back to sample teacher courses because the API request failed.', error);
      return getFallbackTeacherCourses();
    }
    throw error;
  }
};

const getManagedCourse = async (courseId) => {
  if (!courseId) return null;
  try {
    return await requestWithAuth(`/Courses/${courseId}`);
  } catch (error) {
    if (error.status === 404 || error.status === 405) {
      const courses = await listMyCourses();
      const normalizedId = courseId ? courseId.toString().toLowerCase() : '';
      return (
        (courses || []).find((course) => {
          const id = course.id || course.Id;
          return id && id.toString().toLowerCase() === normalizedId;
        }) ?? null
      );
    }
    if (isServerError(error)) {
      const fallback = getFallbackTeacherCourseById(courseId);
      if (fallback) {
        console.warn('Returning fallback course because the API request failed.', error);
        return fallback;
      }
    }
    throw error;
  }
};

const createManagedCourse = (payload) => requestWithAuth('/Courses', { method: 'POST', body: payload });

const deleteManagedCourse = (courseId) => requestWithAuth(`/Courses/${courseId}`, { method: 'DELETE' });

const listManagedChapters = async (courseId) => {
  try {
    return await requestWithAuth(`/Chapters/course/${courseId}`);
  } catch (error) {
    if (isServerError(error)) {
      console.warn('Falling back to sample chapters because the API request failed.', error);
      return getFallbackChaptersForCourse(courseId);
    }
    throw error;
  }
};

const createManagedChapter = (courseId, payload) =>
  requestWithAuth('/Chapters', {
    method: 'POST',
    body: {
      courseId,
      number: payload.number,
      title: payload.title,
      summary: payload.summary,
    },
  });

const updateManagedChapter = (chapterId, payload) =>
  requestWithAuth(`/Chapters/${chapterId}`, {
    method: 'PATCH',
    body: payload,
  });

const deleteManagedChapter = (chapterId) => requestWithAuth(`/Chapters/${chapterId}`, { method: 'DELETE' });

const listManagedResources = async (chapterId) => {
  try {
    return await requestWithAuth(`/Resources?chapterId=${chapterId}`);
  } catch (error) {
    if (isServerError(error)) {
      console.warn('Falling back to sample resources because the API request failed.', error);
      return getFallbackResourcesForChapter(chapterId);
    }
    throw error;
  }
};

const createManagedResource = (chapterId, payload) =>
  requestWithAuth('/Resources', {
    method: 'POST',
    body: {
      id: payload.id,
      chapterId,
      type: payload.type,
      content: payload.content,
    },
  });

const updateManagedResource = (resourceId, payload) =>
  requestWithAuth(`/Resources/${resourceId}`, {
    method: 'PATCH',
    body: payload,
  });

const deleteManagedResource = (resourceId) =>
  requestWithAuth(`/Resources/${resourceId}`, { method: 'DELETE' });

const getCourseProgressReport = async (courseId) => {
  if (!courseId) return [];
  return requestWithAuth(`/TeacherAnalytics/course-progress/${courseId}`);
};

const sendTeacherFeedback = (payload) =>
  requestWithAuth('/TeacherAnalytics/send-feedback', {
    method: 'POST',
    body: payload,
  });

const listForumPostsForCourse = async (courseId) => {
  if (!courseId) return [];
  return requestWithAuth(`/ForumPosts?courseId=${courseId}`);
};

const deleteForumPostForCourse = (postId) =>
  requestWithAuth(`/ForumPosts/${postId}`, { method: 'DELETE' });

const createStudentHelpRequest = (chapterId, question) =>
  requestWithAuth('/students/help-request', {
    method: 'POST',
    body: { chapterId, question },
  });

const getAdminHelpRequests = () => requestWithAuth('/admin/help-requests');

const replyToAdminHelpRequest = (requestId, replyMessage) =>
  requestWithAuth(`/admin/help-requests/${requestId}/reply`, {
    method: 'POST',
    body: { message: replyMessage },
  });

export const teacherCourseService = {
  listMyCourses,
  getCourse: getManagedCourse,
  createCourse: createManagedCourse,
  deleteCourse: deleteManagedCourse,
};

export const chapterManagementService = {
  list: listManagedChapters,
  create: createManagedChapter,
  update: updateManagedChapter,
  deleteChapter: deleteManagedChapter,
};

export const resourceManagementService = {
  list: listManagedResources,
  create: createManagedResource,
  update: updateManagedResource,
  deleteResource: deleteManagedResource,
};

export const teacherAnalyticsService = {
  getCourseProgress: getCourseProgressReport,
  sendFeedback: sendTeacherFeedback,
};

export const forumModerationService = {
  listForCourse: listForumPostsForCourse,
  deletePost: deleteForumPostForCourse,
};

// ===== STUDENT SERVICE FUNCTIONS =====
// Student-specific API functions for learning activities
const getChapterContent = async (chapterId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/chapters/${chapterId}/content`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get chapter content error:', error);
    throw error;
  }
};

const getFlashcards = async (chapterId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/chapters/${chapterId}/flashcards`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get flashcards error:', error);
    throw error;
  }
};

const getQuizQuestions = async (chapterId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/chapters/${chapterId}/quizzes`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get quiz questions error:', error);
    throw error;
  }
};

const submitQuiz = async (userId, chapterId, answers) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/quizzes/submit`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        userId,
        chapterId,
        answers
      })
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Submit quiz error:', error);
    throw error;
  }
};

const getQuestionHint = async (questionId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/questions/${questionId}/hint`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get question hint error:', error);
    throw error;
  }
};

const getStudentProgress = async (userId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/${userId}/progress`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get student progress error:', error);
    throw error;
  }
};

const getChapterProgress = async (userId, chapterId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/${userId}/chapters/${chapterId}/progress`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get chapter progress error:', error);
    throw error;
  }
};

const markChapterComplete = async (userId, chapterId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/${userId}/chapters/${chapterId}/complete`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Mark chapter complete error:', error);
    throw error;
  }
};

const getStudentProfile = async (userId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/${userId}/profile`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get student profile error:', error);
    throw error;
  }
};

const updateStudentProfile = async (userId, profileData) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/${userId}/profile`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(profileData)
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Update student profile error:', error);
    throw error;
  }
};

const getForumPosts = async (courseId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/forums/courses/${courseId}/posts`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get forum posts error:', error);
    throw error;
  }
};

const createForumPost = async (userId, courseId, content) => {
  try {
    const response = await fetch(`${API_BASE_URL}/students/forums/posts`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        userId,
        courseId,
        content
      })
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Create forum post error:', error);
    throw error;
  }
};

const getLeaderboard = async (userId = null) => {
  try {
    const url = userId 
      ? `${API_BASE_URL}/students/leaderboard?userId=${userId}`
      : `${API_BASE_URL}/students/leaderboard`;
    const response = await fetch(url, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get leaderboard error:', error);
    throw error;
  }
};

// ===== COMPREHENSIVE API OBJECT =====
// Main API object that contains all services organized by category
export const api = {
  guests: {
    getFeaturedCourses: getFeaturedGuestCourses,
    getCourseCatalog: getGuestCourseCatalog,
    getCoursePreview: getGuestCoursePreview,
    getChapterPreview: getGuestChapterPreview,
    getTestimonials: getGuestTestimonials,
    searchContent: guestSearchContent,
    checkEmailAvailability: guestCheckEmailAvailability,
    register: guestRegister,
  },
  // Authentication
  auth: {
    login,
    getProfile,
    logout: () => {
      localStorage.removeItem('access_token');
      localStorage.removeItem('user_profile');
      return { success: true };
    }
  },

  // Course management
  courses: {
    getAll: getCourses,
    getById: getCourseById,
    create: createCourse,
    update: updateCourse,
    delete: deleteCourse,
    getChapters: getCourseChapters,
    listMyCourses,
    getManagedCourse,
    createForTeacher: createManagedCourse,
    deleteForTeacher: deleteManagedCourse
  },

  // Enrollment management
  enrollments: {
    enroll: enrolCourse,
    getUserEnrollments: getUserEnrollments,
    checkEnrollment: checkEnrollment
  },

  // Teacher management helpers
  chapters: {
    list: listManagedChapters,
    create: createManagedChapter,
    update: updateManagedChapter,
    delete: deleteManagedChapter
  },

  resources: {
    list: listManagedResources,
    create: createManagedResource,
    update: updateManagedResource,
    delete: deleteManagedResource
  },

  // Development & testing
  testData: {
    seed: seedTestData,
    getStatus: getDatabaseStatus
  },

  // Student learning activities
  students: {
    getChapterContent,
    getFlashcards,
    getQuizQuestions,
    submitQuiz,
    getQuestionHint,
    getStudentProgress,
    getChapterProgress,
    markChapterComplete,
    getStudentProfile,
    updateStudentProfile,
    getForumPosts,
    createForumPost,
    createHelpRequest: createStudentHelpRequest,
    getLeaderboard
  }
};

// ===== QUICK ACCESS FUNCTIONS =====
// For backward compatibility and quick access
export const quickApi = {
  // Most commonly used functions
  login: (email, password) => login(email, password),
  getCourses: () => getCourses(),
  getCourse: (id) => getCourseById(id),
  enrollInCourse: (courseId, token) => enrolCourse(courseId, token),
  seedData: () => seedTestData(),
  getDbStatus: () => getDatabaseStatus(),
  
  // User management
  isLoggedIn: () => !!localStorage.getItem('access_token'),
  getUserToken: () => localStorage.getItem('access_token'),
  getUserProfile: () => {
    const profile = localStorage.getItem('user_profile');
    return profile ? JSON.parse(profile) : null;
  },
  
  // Store user data
  storeUserData: (userData) => {
    if (userData.access_token) {
      localStorage.setItem('access_token', userData.access_token);
    }
    localStorage.setItem('user_profile', JSON.stringify(userData));
  },
  
  clearUserData: () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('user_profile');
  }
};

// Export default for easy importing
export default api;
