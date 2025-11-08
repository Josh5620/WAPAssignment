import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { adminService } from '../services/apiService';
import '../styles/AdminDashboard.css';
import { useAuth } from '../context/AuthContext.jsx';

const AdminDashboard = () => {
    const { user: authUser } = useAuth();
    const [dashboardData, setDashboardData] = useState(null);
    const [users, setUsers] = useState([]);
    const [forumPosts, setForumPosts] = useState([]);
    const [courses, setCourses] = useState([]);
    const [announcements, setAnnouncements] = useState([]);
    const [reports, setReports] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [success, setSuccess] = useState('');
    const [activeTab, setActiveTab] = useState('overview');
    const [selectedUser, setSelectedUser] = useState(null);
    const [newRole, setNewRole] = useState('');
    const [showAnnouncementModal, setShowAnnouncementModal] = useState(false);
    const [newAnnouncement, setNewAnnouncement] = useState({ title: '', content: '', priority: 'medium' });
    const navigate = useNavigate();

    useEffect(() => {
        const user = JSON.parse(localStorage.getItem('user_profile') || '{}');
        console.log('Admin dashboard - checking user:', user);
        console.log('User role:', user.role);
        console.log('User properties:', Object.keys(user));
        
        // Check for admin role (case-insensitive)
        const isAdmin = user.role && user.role.toLowerCase() === 'admin';
        
        if (!isAdmin) {
            console.log('User is not admin, redirecting to home. Role found:', user.role);
            navigate('/');
            return;
        }
        console.log('User is admin, loading dashboard data');
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
            console.log('Loading users...');
            const response = await adminService.getAllUsers();
            console.log('Users API response:', response);
            if (response.success) {
                // Extract just the data array from the response
                const usersData = response.data || [];
                console.log('Setting users:', usersData);
                console.log('Users data is array:', Array.isArray(usersData));
                console.log('Users count:', usersData.length);
                setUsers(Array.isArray(usersData) ? usersData : []);
            } else {
                console.error('API error:', response.message);
                setError(response.message);
                setUsers([]); // Ensure users is always an array
            }
        } catch (err) {
            console.error('Failed to load users:', err);
            setError('Failed to load users');
            setUsers([]); // Ensure users is always an array
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

    const loadCourses = async () => {
        try {
            const response = await adminService.getAllCourses();
            if (response.success) {
                setCourses(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load courses');
        }
    };

    const loadAnnouncements = async () => {
        try {
            const response = await adminService.getAllAnnouncements();
            if (response.success) {
                setAnnouncements(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load announcements');
        }
    };

    const loadReports = async () => {
        try {
            const response = await adminService.getReports();
            if (response.success) {
                setReports(response.data);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to load reports');
        }
    };

    const handleTabChange = (tab) => {
        console.log('Tab changed to:', tab);
        console.log('Current users length:', users.length);
        setActiveTab(tab);
        setError('');
        setSuccess('');
        
        if (tab === 'users' && users.length === 0) {
            console.log('Loading users because tab is users and users.length is 0');
            loadUsers();
        } else if (tab === 'posts' && forumPosts.length === 0) {
            loadForumPosts();
        } else if (tab === 'content' && courses.length === 0) {
            loadCourses();
        } else if (tab === 'announcements' && announcements.length === 0) {
            loadAnnouncements();
        } else if (tab === 'reports' && !reports) {
            loadReports();
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
                    setSuccess('Forum post deleted successfully');
                } else {
                    setError(response.message);
                }
            } catch (err) {
                setError('Failed to delete forum post');
            }
        }
    };

    const handleCreateAnnouncement = async () => {
        if (!newAnnouncement.title || !newAnnouncement.content) {
            setError('Please fill in all announcement fields');
            return;
        }

        try {
            const response = await adminService.createAnnouncement(newAnnouncement);
            if (response.success) {
                setAnnouncements([response.data, ...announcements]);
                setNewAnnouncement({ title: '', content: '', priority: 'medium' });
                setShowAnnouncementModal(false);
                setSuccess('Announcement created successfully');
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to create announcement');
        }
    };

    const handleDeleteAnnouncement = async (announcementId) => {
        if (window.confirm('Are you sure you want to delete this announcement?')) {
            try {
                const response = await adminService.deleteAnnouncement(announcementId);
                if (response.success) {
                    setAnnouncements(announcements.filter(ann => ann.id !== announcementId));
                    setSuccess('Announcement deleted successfully');
                } else {
                    setError(response.message);
                }
            } catch (err) {
                setError('Failed to delete announcement');
            }
        }
    };

    const handleToggleCoursePublished = async (courseId, currentStatus) => {
        try {
            const response = await adminService.updateCourseStatus(courseId, !currentStatus);
            if (response.success) {
                setCourses(courses.map(course => 
                    course.id === courseId ? { ...course, published: !currentStatus } : course
                ));
                setSuccess(`Course ${!currentStatus ? 'published' : 'unpublished'} successfully`);
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to update course status');
        }
    };

    const handleGenerateReport = async () => {
        try {
            setLoading(true);
            const response = await adminService.generateReport();
            if (response.success) {
                setReports(response.data);
                setSuccess('Report generated successfully');
            } else {
                setError(response.message);
            }
        } catch (err) {
            setError('Failed to generate report');
        } finally {
            setLoading(false);
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

    const displayName = useMemo(() => {
        if (!authUser) return 'Admin';
        return (
            authUser.full_name ||
            authUser.fullName ||
            authUser.FullName ||
            authUser.name ||
            authUser.displayName ||
            'Admin'
        );
    }, [authUser]);

    const welcomeMessage = useMemo(
        () => `Hi ${displayName}, welcome back to mission control.`,
        [displayName],
    );

    return (
        <div className="admin-dashboard">
            <header className="admin-header">
                <div>
                    <h1>{welcomeMessage}</h1>
                    <p className="admin-subheading">Admin Dashboard</p>
                </div>
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

            {success && (
                <div className="success-message">
                    {success}
                    <button onClick={() => setSuccess('')} className="success-close">×</button>
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
                    Manage Users
                </button>
                <button 
                    className={`nav-tab ${activeTab === 'content' ? 'active' : ''}`}
                    onClick={() => handleTabChange('content')}
                >
                    Manage Content
                </button>
                <button 
                    className={`nav-tab ${activeTab === 'announcements' ? 'active' : ''}`}
                    onClick={() => handleTabChange('announcements')}
                >
                    Announcements
                </button>
                <button 
                    className={`nav-tab ${activeTab === 'posts' ? 'active' : ''}`}
                    onClick={() => handleTabChange('posts')}
                >
                    Review Feedback
                </button>
                <button 
                    className={`nav-tab ${activeTab === 'reports' ? 'active' : ''}`}
                    onClick={() => handleTabChange('reports')}
                >
                    Generate Reports
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
                                    {Array.isArray(users) && users.map(user => (
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
                                    {(!Array.isArray(users) || users.length === 0) && (
                                        <tr>
                                            <td colSpan="5" style={{ textAlign: 'center', padding: '20px', color: '#666' }}>
                                                {Array.isArray(users) ? 'No users found' : 'Loading users...'}
                                            </td>
                                        </tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {activeTab === 'content' && (
                    <div className="content-tab">
                        <div className="tab-header">
                            <h2>Manage Content</h2>
                            <button className="btn-primary">
                                + Add New Course
                            </button>
                        </div>
                        <div className="content-grid">
                            {courses.map(course => (
                                <div key={course.id} className="content-card">
                                    <div className="content-header">
                                        <h4>{course.title}</h4>
                                        <span className={`status-badge ${course.published ? 'published' : 'draft'}`}>
                                            {course.published ? 'Published' : 'Draft'}
                                        </span>
                                    </div>
                                    <p className="content-description">{course.description}</p>
                                    <div className="content-stats">
                                        <span>Chapters: {course.chapterCount || 0}</span>
                                        <span>Students: {course.enrollmentCount || 0}</span>
                                    </div>
                                    <div className="content-actions">
                                        <button className="btn-secondary btn-sm">
                                            Edit Course
                                        </button>
                                        <button 
                                            onClick={() => handleToggleCoursePublished(course.id, course.published)}
                                            className={`btn-sm ${course.published ? 'btn-warning' : 'btn-success'}`}
                                        >
                                            {course.published ? 'Unpublish' : 'Publish'}
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                )}

                {activeTab === 'announcements' && (
                    <div className="announcements-tab">
                        <div className="tab-header">
                            <h2>Announcements</h2>
                            <button 
                                onClick={() => setShowAnnouncementModal(true)}
                                className="btn-primary"
                            >
                                + Create Announcement
                            </button>
                        </div>
                        <div className="announcements-list">
                            {announcements.map(announcement => (
                                <div key={announcement.id} className="announcement-item">
                                    <div className="announcement-header">
                                        <h4>{announcement.title}</h4>
                                        <span className={`priority-badge ${announcement.priority}`}>
                                            {announcement.priority}
                                        </span>
                                        <span className="announcement-date">
                                            {new Date(announcement.createdAt).toLocaleDateString()}
                                        </span>
                                    </div>
                                    <p className="announcement-content">{announcement.content}</p>
                                    <div className="announcement-actions">
                                        <button className="btn-secondary btn-sm">
                                            Edit
                                        </button>
                                        <button 
                                            onClick={() => handleDeleteAnnouncement(announcement.id)}
                                            className="btn-danger btn-sm"
                                        >
                                            Delete
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                )}

                {activeTab === 'posts' && (
                    <div className="posts-tab">
                        <h2>Review Feedback</h2>
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
                                        <button className="btn-secondary btn-sm">
                                            Reply
                                        </button>
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

                {activeTab === 'reports' && (
                    <div className="reports-tab">
                        <div className="tab-header">
                            <h2>Generate Reports</h2>
                            <button 
                                onClick={handleGenerateReport}
                                className="btn-primary"
                                disabled={loading}
                            >
                                {loading ? 'Generating...' : 'Generate New Report'}
                            </button>
                        </div>
                        {reports && (
                            <div className="reports-content">
                                <div className="report-summary">
                                    <h3>Platform Statistics</h3>
                                    <div className="report-stats">
                                        <div className="report-stat">
                                            <strong>Total Users:</strong> {reports.totalUsers}
                                        </div>
                                        <div className="report-stat">
                                            <strong>Active Students:</strong> {reports.activeStudents}
                                        </div>
                                        <div className="report-stat">
                                            <strong>Total Courses:</strong> {reports.totalCourses}
                                        </div>
                                        <div className="report-stat">
                                            <strong>Completion Rate:</strong> {reports.completionRate}%
                                        </div>
                                    </div>
                                </div>
                                <div className="report-actions">
                                    <button className="btn-secondary">
                                        Download PDF
                                    </button>
                                    <button className="btn-secondary">
                                        Export CSV
                                    </button>
                                </div>
                            </div>
                        )}
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

            {/* Announcement Creation Modal */}
            {showAnnouncementModal && (
                <div className="modal-overlay">
                    <div className="modal">
                        <h3>Create New Announcement</h3>
                        <div className="form-group">
                            <label>Title:</label>
                            <input 
                                type="text"
                                value={newAnnouncement.title}
                                onChange={(e) => setNewAnnouncement({
                                    ...newAnnouncement, 
                                    title: e.target.value
                                })}
                                placeholder="Announcement title..."
                            />
                        </div>
                        <div className="form-group">
                            <label>Content:</label>
                            <textarea 
                                value={newAnnouncement.content}
                                onChange={(e) => setNewAnnouncement({
                                    ...newAnnouncement, 
                                    content: e.target.value
                                })}
                                placeholder="Announcement content..."
                                rows="4"
                            />
                        </div>
                        <div className="form-group">
                            <label>Priority:</label>
                            <select 
                                value={newAnnouncement.priority}
                                onChange={(e) => setNewAnnouncement({
                                    ...newAnnouncement, 
                                    priority: e.target.value
                                })}
                            >
                                <option value="low">Low</option>
                                <option value="medium">Medium</option>
                                <option value="high">High</option>
                            </select>
                        </div>
                        <div className="modal-actions">
                            <button 
                                onClick={handleCreateAnnouncement}
                                className="btn-primary"
                            >
                                Create Announcement
                            </button>
                            <button 
                                onClick={() => {
                                    setShowAnnouncementModal(false);
                                    setNewAnnouncement({ title: '', content: '', priority: 'medium' });
                                }}
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
