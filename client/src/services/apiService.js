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

// Login function: POST to /auth/login (AuthController endpoint)
export const login = async (email, password) => {
  try {
    const response = await fetch('http://localhost:5245/api/auth/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email,      // AuthController expects 'email' field
        password    // AuthController expects 'password' field
      }),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    console.log('✓ Login successful - raw backend response:', data);
    
    // AuthController returns: { access_token, token_type, user: { userId, email, fullName, role } }
    // Normalize the response format for AuthContext
    const normalizedData = {
      access_token: data.access_token,
      token: data.access_token,
      user: {
        ...data.user,
        id: data.user.userId  // Add 'id' field that maps to 'userId' for compatibility
      },
      role: data.user.role
    };
    
    console.log('✓ Normalized login data being returned:', normalizedData);
    return normalizedData;
  } catch (error) {
    console.error('Login error:', error);
    throw error;
  }
};

// Get profile function: GET /auth/profile with Authorization: Bearer <token>
export const getProfile = async (token) => {
  try {
    const response = await fetch(`${API_BASE_URL}/auth/profile`, {
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

export const updateProfile = async (token, profileData) => {
  try {
    const response = await fetch(`${API_BASE_URL}/auth/profile`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(profileData)
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Update profile error:', error);
    throw error;
  }
};

// Register function: POST to /auth/register (AuthController endpoint)
export const register = async (fullName, email, password) => {
  try {
    const response = await fetch('http://localhost:5245/api/auth/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        fullName,   // AuthController expects 'fullName' field
        email,      // AuthController expects 'email' field
        password    // AuthController expects 'password' field
      }),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    console.log('✓ Registration successful:', data);
    return data;
  } catch (error) {
    console.error('Registration error:', error);
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
export const enrolCourse = async (courseId) => {
  if (!courseId) {
    throw new Error('courseId is required to enroll');
  }

  try {
    return await requestWithAuth('/students/enrollments', {
      method: 'POST',
      body: { courseId }
    });
  } catch (error) {
    console.error('Enroll course error:', error);
    throw error;
  }
};

export const getMyCourses = async () => {
  try {
    return await requestWithAuth('/students/my-courses');
  } catch (error) {
    console.error('Get my courses error:', error);
    throw error;
  }
};

export const unenrollFromCourse = async (enrollmentId) => {
  if (!enrollmentId) {
    throw new Error('enrollmentId is required to unenroll');
  }

  try {
    await requestWithAuth(`/students/enrollments/${enrollmentId}`, {
      method: 'DELETE'
    });
    return true;
  } catch (error) {
    console.error('Unenroll error:', error);
    throw error;
  }
};

export const getStudentCertificates = async () => {
  try {
    return await requestWithAuth('/students/certificates');
  } catch (error) {
    console.error('Get certificates error:', error);
    throw error;
  }
};

// Get user enrollments function: wraps students/my-courses response
export const getUserEnrollments = async () => {
  try {
    const response = await getMyCourses();
    if (!response) return [];
    if (Array.isArray(response)) return response;
    if (Array.isArray(response?.courses)) {
      return response.courses;
    }
    return [];
  } catch (error) {
    console.error('Get user enrollments error:', error);
    throw error;
  }
};

// Check if user is enrolled in course
export const checkEnrollment = async (courseId) => {
  try {
    const enrollments = await getUserEnrollments();
    return enrollments.some((enrollment) => enrollment.courseId === courseId);
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

// Then update getFeaturedGuestCourses to NOT fall back:
const getFeaturedGuestCourses = async (limit = 6) => {
  try {
    const response = await fetch(`${API_BASE_URL}/guests/courses${buildQueryString({ limit })}`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    
    if (Array.isArray(data)) {
      return { courses: data };
    }
    return { courses: data.courses || [] };
  } catch (error) {
    console.error('Failed to fetch featured courses:', error);
    return { courses: [] }; // Return empty array instead of fallback
  }
};

// Update getGuestCourseCatalog to remove fallback
const getGuestCourseCatalog = async (options = {}) => {
  try {
    const query = buildQueryString(options);
    
    const response = await fetch(`${API_BASE_URL}/guests/courses${query}`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    
    return {
      courses: data.courses || [],
      totalCount: data.total || 0,
      totalPages: Math.ceil((data.total || 0) / (options.limit || 12)),
      currentPage: options.page || 1
    };
  } catch (error) {
    console.error('Failed to fetch course catalog:', error);
    return {
      courses: [],
      totalCount: 0,
      totalPages: 0,
      currentPage: 1
    };
  }
};

// Update getGuestCoursePreview to remove fallback
const getGuestCoursePreview = async (courseId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/guests/courses/${courseId}/preview`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Failed to fetch course preview:', error);
    throw error; // Throw instead of returning fallback
  }
};

// Update getGuestChapterPreview to remove fallback
const getGuestChapterPreview = async (courseId, chapterId) => {
  try {
    const response = await requestWithAuth(`/courses/${courseId}/chapters/${chapterId}/preview`);
    return response;
  } catch (error) {
    console.error('Failed to fetch chapter preview:', error);
    throw error; // Throw instead of returning fallback
  }
};

// Update getGuestTestimonials to remove fallback
const getGuestTestimonials = async ({ courseId, limit } = {}) => {
  const query = buildQueryString({ courseId, limit });
  try {
    const response = await fetch(`${API_BASE_URL}/guests/testimonials${query}`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const data = await response.json();
    
    if (Array.isArray(data)) {
      return { testimonials: data };
    }
    return data;
  } catch (error) {
    console.error('Failed to fetch testimonials:', error);
    return { testimonials: [] }; // Return empty array instead of fallback
  }
};

// Update guestSearchContent to remove fallback
const guestSearchContent = async (query) => {
  try {
    const response = await requestWithAuth(`/courses/search${buildQueryString({ query })}`);
    return response;
  } catch (error) {
    console.error('Search failed:', error);
    return { results: [] }; // Return empty results instead of fallback
  }
};

// Update the helper function to build query strings
const buildQueryString = (params) => {
  if (!params || Object.keys(params).length === 0) return '';
  const query = new URLSearchParams();
  Object.entries(params).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== '') {
      query.append(key, value);
    }
  });
  const queryString = query.toString();
  return queryString ? `?${queryString}` : '';
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
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
      console.log('🔑 Getting admin courses with token:', token ? 'Token present' : 'No token');
      
      const response = await fetch(`${API_BASE_URL}/Admin/courses`, {
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
      console.log('📚 Admin courses response:', data);
      return data;
    } catch (error) {
      console.error('Get admin courses error:', error);
      return { success: false, message: error.message };
    }
  },

  createCourse: async (courseData) => {
    try {
      const token = getToken();
      const response = await fetch(`${API_BASE_URL}/Admin/courses`, {
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
      return { success: true, data: data };
    } catch (error) {
      console.error('Create course error:', error);
      return { success: false, message: 'Course creation not available yet' };
    }
  },

  updateCourse: async (courseId, courseData) => {
    try {
      const token = getToken();
      const response = await fetch(`${API_BASE_URL}/Admin/courses/${courseId}`, {
        method: 'PUT',
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
      return { success: true, data: data };
    } catch (error) {
      console.error('Update course error:', error);
      return { success: false, message: 'Course update not available yet' };
    }
  },

  deleteCourse: async (courseId) => {
    try {
      const token = getToken();
      const response = await fetch(`${API_BASE_URL}/Admin/courses/${courseId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      return { success: true, message: 'Course deleted successfully' };
    } catch (error) {
      console.error('Delete course error:', error);
      return { success: false, message: 'Course deletion not available yet' };
    }
  },

  updateCourseStatus: async (courseId, published) => {
    try {
      const token = getToken();
      const response = await fetch(`${API_BASE_URL}/Admin/courses/${courseId}/status`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ published })
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Update course status error:', error);
      return { success: false, message: 'Course status update not available yet' };
    }
  },

  // === COURSE APPROVAL SYSTEM ===
  getPendingApprovalCourses: async () => {
    try {
      const token = getToken();
      const response = await fetch(`${API_BASE_URL}/Admin/courses/pending-approval`, {
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
      return { success: true, data: data.data || [] };
    } catch (error) {
      console.error('Get pending courses error:', error);
      return { success: false, message: 'Pending courses not available yet', data: [] };
    }
  },

  approveCourse: async (courseId, approved, rejectionReason = '') => {
    try {
      const token = getToken();
      const userProfile = JSON.parse(localStorage.getItem('user_profile') || '{}');
      
      const response = await fetch(`${API_BASE_URL}/Admin/courses/${courseId}/approve`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          approved,
          rejectionReason,
          adminUserId: userProfile.id || userProfile.userId
        })
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data = await response.json();
      return { success: true, data: data };
    } catch (error) {
      console.error('Approve course error:', error);
      return { success: false, message: 'Course approval not available yet' };
    }
  },

  // === ANNOUNCEMENT MANAGEMENT ===
  getAllAnnouncements: async () => {
    try {
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
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
      const token = getToken();
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

// ===== TEACHER HELP REQUEST FUNCTIONS =====
const getTeacherHelpRequests = () => requestWithAuth('/teachers/help-requests');

const respondToTeacherHelpRequest = (helpRequestId, response) =>
  requestWithAuth(`/teachers/help-requests/${helpRequestId}/respond`, {
    method: 'POST',
    body: { response },
  });

// Teacher Question Management
const createQuestion = async (chapterId, questionData) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/teachers/chapters/${chapterId}/questions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      },
      body: JSON.stringify(questionData)
    });
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Create question error:', error);
    throw error;
  }
};

const getChapterQuestions = async (chapterId) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/teachers/chapters/${chapterId}/questions`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get chapter questions error:', error);
    throw error;
  }
};

const updateQuestion = async (questionId, questionData) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/teachers/questions/${questionId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      },
      body: JSON.stringify(questionData)
    });
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Update question error:', error);
    throw error;
  }
};

const deleteQuestion = async (questionId) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/teachers/questions/${questionId}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
    });
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Delete question error:', error);
    throw error;
  }
};

export const teacherCourseService = {
  listMyCourses,
  getCourse: getManagedCourse,
  createCourse: createManagedCourse,
  deleteCourse: deleteManagedCourse,
};

export const teacherQuestionService = {
  createQuestion,
  getChapterQuestions,
  updateQuestion,
  deleteQuestion,
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/chapters/${chapterId}/content`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/chapters/${chapterId}/flashcards`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/chapters/${chapterId}/quizzes`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get quiz questions error:', error);
    throw error;
  }
};

// Get quiz information (time limit, attempt limits, etc.)
const getQuizInfo = async (chapterId) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/quizzes/chapters/${chapterId}/info`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get quiz info error:', error);
    throw error;
  }
};

// Start a new quiz attempt (tracks timer)
const startQuiz = async (chapterId) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/quizzes/start`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      },
      body: JSON.stringify({ chapterId })
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Start quiz error:', error);
    throw error;
  }
};

// Get quiz attempt history
const getQuizHistory = async (chapterId) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/quizzes/chapters/${chapterId}/history`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get quiz history error:', error);
    throw error;
  }
};

const submitQuiz = async (chapterId, answers, timeSpentSeconds = null, attemptId = null) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/quizzes/submit`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      },
      body: JSON.stringify({
        chapterId,
        answers,
        timeSpentSeconds,
        attemptId
      })
    });
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Submit quiz error:', error);
    throw error;
  }
};

const getQuestionHint = async (questionId) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/questions/${questionId}/hint`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/${userId}/progress`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/${userId}/chapters/${chapterId}/progress`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/${userId}/chapters/${chapterId}/complete`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/${userId}/profile`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/${userId}/profile`, {
      method: 'PATCH',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      },
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/forums/courses/${courseId}/posts`, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
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
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/forums/posts`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      },
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

const getForumComments = async (forumId) => {
  try {
    return await requestWithAuth(`/students/forums/posts/${forumId}/comments`);
  } catch (error) {
    console.error('Get forum comments error:', error);
    throw error;
  }
};

const createForumComment = async (forumId, content, parentCommentId = null) => {
  try {
    const token = getToken();
    const response = await fetch(`${API_BASE_URL}/students/forums/posts/${forumId}/comments`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: token ? `Bearer ${token}` : '',
      },
      body: JSON.stringify({
        content,
        parentCommentId,
      }),
    });

    if (!response.ok) {
      const payload = await parsePayload(response);
      const message =
        payload?.error ||
        payload?.message ||
        (typeof payload === 'string' && payload.trim().length ? payload : null) ||
        `HTTP ${response.status}: ${response.statusText}`;
      const error = new Error(message);
      error.status = response.status;
      error.data = payload;
      throw error;
    }

    return await response.json();
  } catch (error) {
    console.error('Create forum comment error:', error);
    throw error;
  }
};

const getLeaderboard = async (userId = null) => {
  try {
    const token = getToken();
    const url = userId 
      ? `${API_BASE_URL}/students/leaderboard?userId=${userId}`
      : `${API_BASE_URL}/students/leaderboard`;
    const response = await fetch(url, {
      method: 'GET',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : ''
      }
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    return await response.json();
  } catch (error) {
    console.error('Get leaderboard error:', error);
    throw error;
  }
};

const getNotifications = async (unreadOnly = false) => {
  const query = unreadOnly ? '?unreadOnly=true' : '';
  try {
    return await requestWithAuth(`/notifications${query}`);
  } catch (error) {
    console.error('Get notifications error:', error);
    throw error;
  }
};

const markNotificationRead = async (notificationId) => {
  if (!notificationId) return null;
  try {
    return await requestWithAuth(`/notifications/${notificationId}/read`, {
      method: 'POST',
    });
  } catch (error) {
    console.error('Mark notification read error:', error);
    throw error;
  }
};

const markAllNotificationsRead = async () => {
  try {
    return await requestWithAuth('/notifications/mark-all-read', {
      method: 'POST',
    });
  } catch (error) {
    console.error('Mark all notifications read error:', error);
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
  },
  // Authentication
  auth: {
    login,
    getProfile,
    updateProfile,
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
    getQuizInfo,
    startQuiz,
    getQuizHistory,
    submitQuiz,
    getQuestionHint,
    getStudentProgress,
    getChapterProgress,
    markChapterComplete,
    getStudentProfile,
    updateStudentProfile,
    enrollInCourse: enrolCourse,
    listMyCourses: getMyCourses,
    unenroll: unenrollFromCourse,
    getCertificates: getStudentCertificates,
    getForumPosts,
    createForumPost,
    getForumComments,
    createForumComment,
    createHelpRequest: createStudentHelpRequest,
    getLeaderboard
  },

  notifications: {
    list: getNotifications,
    markRead: markNotificationRead,
    markAllRead: markAllNotificationsRead,
  },

  // Teacher-specific functions
  teachers: {
    getHelpRequests: getTeacherHelpRequests,
    respondToHelpRequest: respondToTeacherHelpRequest,
    getMyCourses: listMyCourses,
    getCourse: getManagedCourse,
    createCourse: createManagedCourse,
    deleteCourse: deleteManagedCourse,
    createQuestion,
    getChapterQuestions,
    updateQuestion,
    deleteQuestion
  }
};

// ===== QUICK ACCESS FUNCTIONS =====
// For backward compatibility and quick access
export const quickApi = {
  // Most commonly used functions
  login: (email, password) => login(email, password),
  getCourses: () => getCourses(),
  getCourse: (id) => getCourseById(id),
  enrollInCourse: (courseId) => enrolCourse(courseId),
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
