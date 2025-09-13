import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { adminService } from '../services/apiService';
import TestingNav from '../components/TestingNav';
import '../styles/AdminDashboard.css';

const AdminDashboard = () => {
    const [dashboardData, setDashboardData] = useState(null);
    const [users, setUsers] = useState([]);
    const [forumPosts, setForumPosts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [activeTab, setActiveTab] = useState('overview');
    const [selectedUser, setSelectedUser] = useState(null);
    const [newRole, setNewRole] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        const user = JSON.parse(localStorage.getItem('user') || '{}');
        if (!user.isAdmin) {
            navigate('/');
            return;
        }
        loadDashboardData();
    }, [navigate]);

    const loadDashboardData = async () => {
        try {
            setLoading(true);
            const response = await adminService.getDashboardData();
            if (response.success) {
                setDashboardData(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load dashboard data');
        } finally {
            setLoading(false);
        }
    };

    const loadUsers = async () => {
        try {
            const response = await adminService.getAllUsers();
            if (response.success) {
                setUsers(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load users');
        }
    };

    const loadForumPosts = async () => {
        try {
            const response = await adminService.getAllForumPosts();
            if (response.success) {
                setForumPosts(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load forum posts');
        }
    };

    const handleTabChange = (tab) => {
        setActiveTab(tab);
        if (tab === 'users' && users.length === 0) {
            loadUsers();
        } else if (tab === 'posts' && forumPosts.length === 0) {
            loadForumPosts();
        }
    };

    const handleUpdateUserRole = async (userId, role) => {
        try {
            const response = await adminService.updateUserRole(userId, role);
            if (response.success) {
                setUsers(users.map(user => 
                    user.id === userId ? { ...user, role, isAdmin: role === 'admin', isTeacher: role === 'teacher', isStudent: role === 'student' } : user
                ));
                setSelectedUser(null);
                setNewRole('');
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to update user role');
        }
    };

    const handleDeleteUser = async (userId) => {
        if (window.confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
            try {
                const response = await adminService.deleteUser(userId);
                if (response.success) {
                    setUsers(users.filter(user => user.id !== userId));
                } else {
                    setError(response.message);
                }
            } catch (err) {
                setError('Failed to delete user');
            }
        }
    };

    const handleDeletePost = async (postId) => {
        if (window.confirm('Are you sure you want to delete this forum post? This action cannot be undone.')) {
            try {
                const response = await adminService.deleteForumPost(postId);
                if (response.success) {
                    setForumPosts(forumPosts.filter(post => post.id !== postId));
                } else {
                    setError(response.message);
                }
            } catch (err) {
                setError('Failed to delete forum post');
            }
        }
    };

    const handleLogout = () => {
        localStorage.removeItem('authToken');
        localStorage.removeItem('user');
        navigate('/admin-login');
    };

    if (loading) {
        return (
            <div className="admin-dashboard">
                <div className="loading">Loading dashboard...</div>
            </div>
        );
    }

    return (
        <div className="admin-dashboard">
            <TestingNav />
            <header className="admin-header">
                <h1>Admin Dashboard</h1>
                <div className="admin-header-actions">
                    <button onClick={() => navigate('/')} className="btn-secondary">
                        Back to Site
                    </button>
                    <button onClick={handleLogout} className="btn-danger">
                        Logout
                    </button>
                </div>
            </header>

            {error && (
                <div className="error-message">
                    {error}
                    <button onClick={() => setError('')} className="error-close">×</button>
                </div>
            )}

            <nav className="admin-nav">
                <button 
                    className={`nav-tab ${activeTab === 'overview' ? 'active' : ''}`}
                    onClick={() => handleTabChange('overview')}
                >
                    Overview
                </button>
                <button 
                    className={`nav-tab ${activeTab === 'users' ? 'active' : ''}`}
                    onClick={() => handleTabChange('users')}
                >
                    Users
                </button>
                <button 
                    className={`nav-tab ${activeTab === 'posts' ? 'active' : ''}`}
                    onClick={() => handleTabChange('posts')}
                >
                    Forum Posts
                </button>
            </nav>

            <main className="admin-content">
                {activeTab === 'overview' && dashboardData && (
                    <div className="overview-tab">
                        <div className="stats-grid">
                            <div className="stat-card">
                                <h3>Total Users</h3>
                                <p className="stat-number">{dashboardData.statistics.totalUsers}</p>
                            </div>
                            <div className="stat-card">
                                <h3>Students</h3>
                                <p className="stat-number">{dashboardData.statistics.totalStudents}</p>
                            </div>
                            <div className="stat-card">
                                <h3>Teachers</h3>
                                <p className="stat-number">{dashboardData.statistics.totalTeachers}</p>
                            </div>
                            <div className="stat-card">
                                <h3>Admins</h3>
                                <p className="stat-number">{dashboardData.statistics.totalAdmins}</p>
                            </div>
                            <div className="stat-card">
                                <h3>Forum Posts</h3>
                                <p className="stat-number">{dashboardData.statistics.totalForumPosts}</p>
                            </div>
                            <div className="stat-card">
                                <h3>Resources</h3>
                                <p className="stat-number">{dashboardData.statistics.totalResources}</p>
                            </div>
                        </div>

                        <div className="recent-activities">
                            <div className="recent-section">
                                <h3>Recent Users</h3>
                                <div className="recent-list">
                                    {dashboardData.recentUsers.map(user => (
                                        <div key={user.id} className="recent-item">
                                            <div className="recent-info">
                                                <strong>{user.fullName}</strong>
                                                <span className={`role-badge ${user.role}`}>{user.role}</span>
                                            </div>
                                            <small>{new Date(user.createdAt).toLocaleDateString()}</small>
                                        </div>
                                    ))}
                                </div>
                            </div>

                            <div className="recent-section">
                                <h3>Recent Forum Posts</h3>
                                <div className="recent-list">
                                    {dashboardData.recentPosts.map(post => (
                                        <div key={post.id} className="recent-item">
                                            <div className="recent-info">
                                                <strong>{post.title}</strong>
                                                <small>by {post.authorName}</small>
                                            </div>
                                            <small>{new Date(post.createdAt).toLocaleDateString()}</small>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                )}

                {activeTab === 'users' && (
                    <div className="users-tab">
                        <h2>User Management</h2>
                        <div className="users-table">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Created</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {users.map(user => (
                                        <tr key={user.id}>
                                            <td>{user.fullName}</td>
                                            <td>{user.email}</td>
                                            <td>
                                                <span className={`role-badge ${user.role}`}>
                                                    {user.role}
                                                </span>
                                            </td>
                                            <td>{new Date(user.createdAt).toLocaleDateString()}</td>
                                            <td>
                                                <button 
                                                    onClick={() => {
                                                        setSelectedUser(user);
                                                        setNewRole(user.role);
                                                    }}
                                                    className="btn-secondary btn-sm"
                                                >
                                                    Edit Role
                                                </button>
                                                <button 
                                                    onClick={() => handleDeleteUser(user.id)}
                                                    className="btn-danger btn-sm"
                                                >
                                                    Delete
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {activeTab === 'posts' && (
                    <div className="posts-tab">
                        <h2>Forum Posts Management</h2>
                        <div className="posts-list">
                            {forumPosts.map(post => (
                                <div key={post.id} className="post-item">
                                    <div className="post-header">
                                        <h4>{post.title}</h4>
                                        <span className="post-author">by {post.authorName}</span>
                                        <span className="post-date">{new Date(post.createdAt).toLocaleDateString()}</span>
                                    </div>
                                    <p className="post-content">{post.content}</p>
                                    <div className="post-actions">
                                        <button 
                                            onClick={() => handleDeletePost(post.id)}
                                            className="btn-danger btn-sm"
                                        >
                                            Delete Post
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                )}
            </main>

            {/* Role Update Modal */}
            {selectedUser && (
                <div className="modal-overlay">
                    <div className="modal">
                        <h3>Update User Role</h3>
                        <p>Updating role for: <strong>{selectedUser.fullName}</strong></p>
                        <div className="form-group">
                            <label>New Role:</label>
                            <select 
                                value={newRole} 
                                onChange={(e) => setNewRole(e.target.value)}
                            >
                                <option value="student">Student</option>
                                <option value="teacher">Teacher</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div className="modal-actions">
                            <button 
                                onClick={() => handleUpdateUserRole(selectedUser.id, newRole)}
                                className="btn-primary"
                            >
                                Update Role
                            </button>
                            <button 
                                onClick={() => setSelectedUser(null)}
                                className="btn-secondary"
                            >
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default AdminDashboard;
