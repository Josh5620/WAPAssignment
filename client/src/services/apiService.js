import { getToken, clear as clearAuth } from '../utils/auth';

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
  getDashboardData: async () => {
    try {
      const courses = await getCourses();
      const dbStatus = await getDatabaseStatus();
      return {
        success: true,
        data: {
          totalUsers: dbStatus.profiles || 0,
          totalPosts: dbStatus.questions || 0, // Using questions as posts for now
          totalCourses: courses.length,
          courses: courses,
          databaseStats: dbStatus
        }
      };
    } catch (error) {
      return { success: false, message: error.message };
    }
  },
  
  getAllUsers: async () => {
    // Placeholder - user management not implemented in backend yet
    console.error('User management endpoints not implemented in backend');
    return { success: false, message: 'User management not available' };
  },
  
  updateUserRole: async (userId, role) => {
    // Placeholder
    console.error('Update user role endpoint not implemented in backend');
    return { success: false, message: 'User role update not available' };
  },
  
  deleteUser: async (userId) => {
    // Placeholder
    console.error('Delete user endpoint not implemented in backend');
    return { success: false, message: 'User deletion not available' };
  },
  
  getAllForumPosts: async () => {
    // Placeholder - forum not implemented
    console.error('Forum endpoints not implemented in backend');
    return { success: false, message: 'Forum not available' };
  },
  
  deleteForumPost: async (postId) => {
    // Placeholder
    console.error('Delete forum post endpoint not implemented in backend');
    return { success: false, message: 'Forum post deletion not available' };
  },

  // New admin functions using the API
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
const listMyCourses = () => requestWithAuth('/Courses');

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
    throw error;
  }
};

const createManagedCourse = (payload) => requestWithAuth('/Courses', { method: 'POST', body: payload });

const deleteManagedCourse = (courseId) => requestWithAuth(`/Courses/${courseId}`, { method: 'DELETE' });

const listManagedChapters = (courseId) => requestWithAuth(`/Chapters/course/${courseId}`);

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

const listManagedResources = (chapterId) => requestWithAuth(`/Resources?chapterId=${chapterId}`);

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

// ===== COMPREHENSIVE API OBJECT =====
// Main API object that contains all services organized by category
export const api = {
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
