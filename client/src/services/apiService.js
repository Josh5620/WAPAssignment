const API_BASE_URL = 'http://localhost:5245/api';

// Auth Service
export const authService = {
    login: async (credentials) => {
        try {
            const response = await fetch(`${API_BASE_URL}/auth/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(credentials),
            });

            const data = await response.json();

            if (data.success) {
                localStorage.setItem('authToken', data.data.token);
                localStorage.setItem('user', JSON.stringify(data.data.user));
                return { success: true, data: data.data };
            } else {
                return { success: false, message: data.message };
            }
        } catch (error) {
            console.error('Login error:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    adminLogin: async (credentials) => {
        try {
            const response = await fetch(`${API_BASE_URL}/auth/admin-login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(credentials),
            });

            const data = await response.json();

            if (data.success) {
                localStorage.setItem('authToken', data.data.token);
                localStorage.setItem('user', JSON.stringify(data.data.user));
                return { success: true, data: data.data };
            } else {
                return { success: false, message: data.message };
            }
        } catch (error) {
            console.error('Admin login error:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    register: async (userData) => {
        try {
            const response = await fetch(`${API_BASE_URL}/auth/register`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(userData),
            });

            const data = await response.json();

            if (data.success) {
                localStorage.setItem('authToken', data.data.token);
                localStorage.setItem('user', JSON.stringify(data.data.user));
                return { success: true, data: data.data };
            } else {
                return { success: false, message: data.message };
            }
        } catch (error) {
            console.error('Registration error:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    logout: () => {
        localStorage.removeItem('authToken');
        localStorage.removeItem('user');
        return { success: true };
    },

    getCurrentUser: () => {
        try {
            const user = localStorage.getItem('user');
            return user ? JSON.parse(user) : null;
        } catch (error) {
            console.error('Error getting current user:', error);
            return null;
        }
    },

    getToken: () => {
        return localStorage.getItem('authToken');
    },

    isAuthenticated: () => {
        const token = localStorage.getItem('authToken');
        const user = localStorage.getItem('user');
        return !!(token && user);
    }
};

// Forum Service
export const forumService = {
    getAllPosts: async () => {
        try {
            const response = await fetch(`${API_BASE_URL}/forum`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching posts:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    getPost: async (id) => {
        try {
            const response = await fetch(`${API_BASE_URL}/forum/${id}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching post:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    createPost: async (postData) => {
        try {
            const token = authService.getToken();
            const response = await fetch(`${API_BASE_URL}/forum`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`,
                },
                body: JSON.stringify(postData),
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error creating post:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    updatePost: async (id, postData) => {
        try {
            const token = authService.getToken();
            const response = await fetch(`${API_BASE_URL}/forum/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`,
                },
                body: JSON.stringify(postData),
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error updating post:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    deletePost: async (id) => {
        try {
            const token = authService.getToken();
            const response = await fetch(`${API_BASE_URL}/forum/${id}`, {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${token}`,
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error deleting post:', error);
            return { success: false, message: 'Network error occurred' };
        }
    }
};

// Admin Service
export const adminService = {
    getDashboardData: async () => {
        try {
            const token = localStorage.getItem('authToken');
            const response = await fetch(`${API_BASE_URL}/admin/dashboard`, {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching dashboard data:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    getAllUsers: async () => {
        try {
            const token = localStorage.getItem('authToken');
            const response = await fetch(`${API_BASE_URL}/admin/users`, {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching users:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    updateUserRole: async (userId, role) => {
        try {
            const token = localStorage.getItem('authToken');
            const response = await fetch(`${API_BASE_URL}/admin/users/${userId}/role`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ role }),
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error updating user role:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    deleteUser: async (userId) => {
        try {
            const token = localStorage.getItem('authToken');
            const response = await fetch(`${API_BASE_URL}/admin/users/${userId}`, {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error deleting user:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    getAllForumPosts: async () => {
        try {
            const token = localStorage.getItem('authToken');
            const response = await fetch(`${API_BASE_URL}/admin/forum-posts`, {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching forum posts:', error);
            return { success: false, message: 'Network error occurred' };
        }
    },

    deleteForumPost: async (postId) => {
        try {
            const token = localStorage.getItem('authToken');
            const response = await fetch(`${API_BASE_URL}/admin/forum-posts/${postId}`, {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error deleting forum post:', error);
            return { success: false, message: 'Network error occurred' };
        }
    }
};
