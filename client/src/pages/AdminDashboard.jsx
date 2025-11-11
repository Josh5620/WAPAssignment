import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import { useAuth } from '../context/AuthContext.jsx';
import { adminService } from '../services/apiService';
import '../styles/AdminDashboard.css';

const AdminDashboard = () => {
    const { user: authUser } = useAuth();
    const [users, setUsers] = useState([]);
    const [courses, setCourses] = useState([]);
    const [announcements, setAnnouncements] = useState([]);
    const [feedback, setFeedback] = useState([]);
    const [reports, setReports] = useState([]);
    const [pendingCourses, setPendingCourses] = useState([]);
    const [dashboardStats, setDashboardStats] = useState({});
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [success, setSuccess] = useState('');
    const [activeTab, setActiveTab] = useState('users');
    // State for role editing
    const [editingUserId, setEditingUserId] = useState(null);
    const [selectedRole, setSelectedRole] = useState('');
    // State for announcement creation
    const [showAnnouncementForm, setShowAnnouncementForm] = useState(false);
    const [announcementTitle, setAnnouncementTitle] = useState('');
    const [announcementContent, setAnnouncementContent] = useState('');
    
    // Course management state
    const [showCourseForm, setShowCourseForm] = useState(false);
    const [editingCourseId, setEditingCourseId] = useState(null);
    const [courseTitle, setCourseTitle] = useState('');
    const [courseDescription, setCourseDescription] = useState('');
    const [coursePublished, setCoursePublished] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        // Check if user is admin
        const user = JSON.parse(localStorage.getItem('user_profile') || '{}');
        const isAdmin = user.role && user.role.toLowerCase() === 'admin';
        
        if (!isAdmin) {
            navigate('/');
            return;
        }
        
        loadInitialData();
    }, [navigate]);

    const loadInitialData = async () => {
        try {
            setLoading(true);
            
            // Load all admin data in parallel using allSettled to handle failures gracefully
            const [
                usersResult,
                coursesResult,
                dashboardResult,
                announcementsResult,
                feedbackResult,
                reportsResult,
                pendingCoursesResult
            ] = await Promise.allSettled([
                adminService.getAllUsers(),
                adminService.getAllCourses(),
                adminService.getDashboardData(),
                adminService.getAllAnnouncements(),
                adminService.getHelpRequests(),
                adminService.getReports(),
                adminService.getPendingApprovalCourses()
            ]);

            // Handle users
            if (usersResult.status === 'fulfilled' && usersResult.value.success) {
                setUsers(usersResult.value.data || []);
            } else {
                console.warn('Users not available:', usersResult.reason);
                setUsers([]);
            }

            // Handle courses
            if (coursesResult.status === 'fulfilled' && coursesResult.value.success) {
                console.log('📚 Courses data received:', coursesResult.value.data);
                setCourses(coursesResult.value.data || []);
            } else {
                console.warn('Courses not available:', coursesResult.reason);
                setCourses([]);
            }

            // Handle dashboard stats
            if (dashboardResult.status === 'fulfilled' && dashboardResult.value.success) {
                setDashboardStats(dashboardResult.value.data.statistics || {});
            } else {
                console.warn('Dashboard stats not available:', dashboardResult.reason);
                setDashboardStats({});
            }

            // Handle announcements
            if (announcementsResult.status === 'fulfilled' && announcementsResult.value.success) {
                setAnnouncements(announcementsResult.value.data || []);
            } else {
                console.warn('Announcements not available:', announcementsResult.reason);
                setAnnouncements([]);
            }

            // Handle feedback
            if (feedbackResult.status === 'fulfilled' && feedbackResult.value.success) {
                setFeedback(feedbackResult.value.data || []);
            } else {
                console.warn('Feedback not available:', feedbackResult.reason);
                setFeedback([]);
            }

            // Handle reports
            if (reportsResult.status === 'fulfilled' && reportsResult.value.success) {
                setReports(reportsResult.value.data || []);
            } else {
                console.warn('Reports not available:', reportsResult.reason);
                setReports([]);
            }

            // Handle pending courses
            if (pendingCoursesResult.status === 'fulfilled' && pendingCoursesResult.value.success) {
                setPendingCourses(pendingCoursesResult.value.data || []);
            } else {
                console.warn('Pending courses not available:', pendingCoursesResult.reason);
                setPendingCourses([]);
            }

            setError('');
        } catch (err) {
            console.error('Failed to load dashboard data:', err);
            setError('Failed to load dashboard data');
        } finally {
            setLoading(false);
        }
    };

    const handleUserRoleUpdate = async (userId, newRole) => {
        try {
            const result = await adminService.updateUserRole(userId, newRole);
            if (result.success) {
                setSuccess('User role updated successfully');
                // Refresh users list
                const usersResult = await adminService.getAllUsers();
                if (usersResult.success) {
                    setUsers(usersResult.data || []);
                }
            } else {
                setError(result.message || 'Failed to update user role');
            }
        } catch (err) {
            console.error('Failed to update user role:', err);
            setError('Failed to update user role');
        }
        // Reset editing state
        setEditingUserId(null);
        setSelectedRole('');
    };

    const startRoleEdit = (userId, currentRole) => {
        setEditingUserId(userId);
        setSelectedRole(currentRole);
    };

    const cancelRoleEdit = () => {
        setEditingUserId(null);
        setSelectedRole('');
    };

    const confirmRoleEdit = () => {
        if (selectedRole && editingUserId) {
            handleUserRoleUpdate(editingUserId, selectedRole);
        }
    };

    const handleUserDelete = async (userId) => {
        if (!window.confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
            return;
        }
        
        try {
            const result = await adminService.deleteUser(userId);
            if (result.success) {
                setSuccess('User deleted successfully');
                // Refresh users list
                const usersResult = await adminService.getAllUsers();
                if (usersResult.success) {
                    setUsers(usersResult.data || []);
                }
            } else {
                setError(result.message || 'Failed to delete user');
            }
        } catch (err) {
            console.error('Failed to delete user:', err);
            setError('Failed to delete user');
        }
    };

    const handleCreateAnnouncement = async (title, content) => {
        try {
            const result = await adminService.createAnnouncement({
                title: title,
                content: content,
                publishedDate: new Date().toISOString()
            });
            
            if (result.success) {
                setSuccess('Announcement created successfully');
                // Refresh announcements list
                const announcementsResult = await adminService.getAllAnnouncements();
                if (announcementsResult.success) {
                    setAnnouncements(announcementsResult.value.data || []);
                }
            } else {
                setError(result.message || 'Failed to create announcement');
            }
        } catch (err) {
            console.error('Failed to create announcement:', err);
            setError('Failed to create announcement');
        }
        // Reset form state
        setShowAnnouncementForm(false);
        setAnnouncementTitle('');
        setAnnouncementContent('');
    };

    const handleAnnouncementSubmit = (e) => {
        e.preventDefault();
        if (announcementTitle.trim() && announcementContent.trim()) {
            handleCreateAnnouncement(announcementTitle.trim(), announcementContent.trim());
        } else {
            setError('Please fill in both title and content for the announcement');
        }
    };

    const cancelAnnouncementForm = () => {
        setShowAnnouncementForm(false);
        setAnnouncementTitle('');
        setAnnouncementContent('');
    };

    // === COURSE MANAGEMENT FUNCTIONS ===
    const handleCreateCourse = async () => {
        try {
            const result = await adminService.createCourse({
                title: courseTitle,
                description: courseDescription,
                published: coursePublished
            });
            
            if (result.success) {
                setSuccess('Course created successfully');
                // Refresh courses list
                const coursesResult = await adminService.getAllCourses();
                if (coursesResult.success) {
                    setCourses(coursesResult.data || []);
                }
                // Reset form
                setShowCourseForm(false);
                resetCourseForm();
            } else {
                setError(result.message || 'Failed to create course');
            }
        } catch (err) {
            console.error('Failed to create course:', err);
            setError('Failed to create course');
        }
    };

    const handleUpdateCourse = async (courseId) => {
        try {
            const result = await adminService.updateCourse(courseId, {
                title: courseTitle,
                description: courseDescription,
                published: coursePublished
            });
            
            if (result.success) {
                setSuccess('Course updated successfully');
                // Refresh courses list
                const coursesResult = await adminService.getAllCourses();
                if (coursesResult.success) {
                    setCourses(coursesResult.data || []);
                }
                // Reset form
                setEditingCourseId(null);
                setShowCourseForm(false);
                resetCourseForm();
            } else {
                setError(result.message || 'Failed to update course');
            }
        } catch (err) {
            console.error('Failed to update course:', err);
            setError('Failed to update course');
        }
    };

    const handleDeleteCourse = async (courseId) => {
        if (window.confirm('Are you sure you want to delete this course? This action cannot be undone.')) {
            try {
                const result = await adminService.deleteCourse(courseId);
                if (result.success) {
                    setSuccess('Course deleted successfully');
                    // Refresh courses list
                    const coursesResult = await adminService.getAllCourses();
                    if (coursesResult.success) {
                        setCourses(coursesResult.data || []);
                    }
                } else {
                    setError(result.message || 'Failed to delete course');
                }
            } catch (err) {
                console.error('Failed to delete course:', err);
                setError('Failed to delete course');
            }
        }
    };

    const handleCourseStatusToggle = async (courseId, currentStatus) => {
        try {
            const result = await adminService.updateCourseStatus(courseId, !currentStatus);
            if (result.success) {
                setSuccess(`Course ${!currentStatus ? 'published' : 'unpublished'} successfully`);
                // Refresh courses list
                const coursesResult = await adminService.getAllCourses();
                if (coursesResult.success) {
                    setCourses(coursesResult.data || []);
                }
            } else {
                setError(result.message || 'Failed to update course status');
            }
        } catch (err) {
            console.error('Failed to update course status:', err);
            setError('Failed to update course status');
        }
    };

    const handleEditCourse = (course) => {
        setEditingCourseId(course.courseId);
        setCourseTitle(course.title);
        setCourseDescription(course.description);
        setCoursePublished(course.published);
        setShowCourseForm(true);
    };

    const handleCourseSubmit = (e) => {
        e.preventDefault();
        if (courseTitle.trim() && courseDescription.trim()) {
            if (editingCourseId) {
                handleUpdateCourse(editingCourseId);
            } else {
                handleCreateCourse();
            }
        } else {
            setError('Please fill in both title and description for the course');
        }
    };

    const resetCourseForm = () => {
        setCourseTitle('');
        setCourseDescription('');
        setCoursePublished(false);
        setEditingCourseId(null);
    };

    const cancelCourseForm = () => {
        setShowCourseForm(false);
        resetCourseForm();
    };

    // === COURSE APPROVAL FUNCTIONS ===
    const handleApproveCourse = async (courseId, approved, rejectionReason = '') => {
        try {
            const result = await adminService.approveCourse(courseId, approved, rejectionReason);
            if (result.success) {
                setSuccess(`Course ${approved ? 'approved' : 'rejected'} successfully`);
                // Refresh pending courses and all courses
                const [pendingResult, coursesResult] = await Promise.all([
                    adminService.getPendingApprovalCourses(),
                    adminService.getAllCourses()
                ]);
                
                if (pendingResult.success) {
                    setPendingCourses(pendingResult.data || []);
                }
                if (coursesResult.success) {
                    setCourses(coursesResult.data || []);
                }
            } else {
                setError(result.message || `Failed to ${approved ? 'approve' : 'reject'} course`);
            }
        } catch (err) {
            console.error('Failed to process course approval:', err);
            setError(`Failed to ${approved ? 'approve' : 'reject'} course`);
        }
    };

    const showApprovalDialog = (course, isApproval) => {
        if (isApproval) {
            if (window.confirm(`Are you sure you want to approve the course "${course.title}"?`)) {
                handleApproveCourse(course.courseId, true);
            }
        } else {
            const reason = prompt(`Please provide a reason for rejecting "${course.title}":`);
            if (reason && reason.trim()) {
                handleApproveCourse(course.courseId, false, reason.trim());
            }
        }
    };

    const handleGenerateReport = async () => {
        try {
            const result = await adminService.generateReport();
            if (result.success) {
                setSuccess('Report generated successfully');
                // Refresh reports list
                const reportsResult = await adminService.getReports();
                if (reportsResult.success) {
                    setReports(reportsResult.data || []);
                }
            } else {
                setError(result.message || 'Failed to generate report');
            }
        } catch (err) {
            console.error('Failed to generate report:', err);
            setError('Failed to generate report');
        }
    };

    const displayName = authUser?.fullName || authUser?.full_name || 'Administrator';

    if (loading) {
        return (
            <div className="admin-dashboard">
                <div className="loading">Loading dashboard...</div>
            </div>
        );
    }

    return (
        <>
            <Navbar />
            <div className="admin-dashboard">
                <div className="dashboard-header">
                    <div className="welcome-section">
                        <h1>Hi {displayName}, Welcome back to your Administration Panel.</h1>
                        <div className="stats-section">
                            <h2>SYSTEM OVERVIEW</h2>
                            <p>You have {dashboardStats.totalUsers || users.length} users and {dashboardStats.totalCourses || courses.length} courses to manage.</p>
                            <button className="create-btn" onClick={handleGenerateReport}>
                                GENERATE SYSTEM REPORT
                            </button>
                        </div>
                    </div>
                </div>

            {error && (
                <div className="error-message">
                    {error}
                    <button onClick={() => setError('')} className="close-btn">×</button>
                </div>
            )}

            {success && (
                <div className="success-message">
                    {success}
                    <button onClick={() => setSuccess('')} className="close-btn">×</button>
                </div>
            )}

            <div className="tab-navigation">
                <button 
                    className={`tab-btn ${activeTab === 'users' ? 'active' : ''}`}
                    onClick={() => setActiveTab('users')}
                >
                    MANAGE USERS
                </button>
                <button 
                    className={`tab-btn ${activeTab === 'courses' ? 'active' : ''}`}
                    onClick={() => setActiveTab('courses')}
                >
                    MANAGE CONTENT
                </button>
                <button 
                    className={`tab-btn ${activeTab === 'pending-approval' ? 'active' : ''} ${pendingCourses.length > 0 ? 'has-notifications' : ''}`}
                    onClick={() => setActiveTab('pending-approval')}
                >
                    PENDING APPROVALS
                    {pendingCourses.length > 0 && (
                        <span className="notification-badge">{pendingCourses.length}</span>
                    )}
                </button>
                <button 
                    className={`tab-btn ${activeTab === 'announcements' ? 'active' : ''}`}
                    onClick={() => setActiveTab('announcements')}
                >
                    ANNOUNCEMENTS
                </button>
                <button 
                    className={`tab-btn ${activeTab === 'feedback' ? 'active' : ''}`}
                    onClick={() => setActiveTab('feedback')}
                >
                    REVIEW FEEDBACK
                </button>
                <button 
                    className={`tab-btn ${activeTab === 'reports' ? 'active' : ''}`}
                    onClick={() => setActiveTab('reports')}
                >
                    GENERATE REPORTS
                </button>
                <button 
                    className={`tab-btn ${activeTab === 'system' ? 'active' : ''}`}
                    onClick={() => setActiveTab('system')}
                >
                    SYSTEM MONITORING
                </button>
            </div>

            <div className="content-area">
                {activeTab === 'users' && (
                    <div className="users-section">
                        <div className="table-header">
                            <div className="header-col">NAME</div>
                            <div className="header-col">EMAIL</div>
                            <div className="header-col">ROLE</div>
                            <div className="header-col">ACTIONS</div>
                        </div>
                        
                        <div className="table-content">
                            {users.map((user) => (
                                <div key={user.id} className="table-row">
                                    <div className="table-col">
                                        <div className="user-name">{user.fullName || user.email}</div>
                                        <div className="user-subtitle">
                                            {user.role === 'admin' ? 'System Administrator' : 
                                             user.role === 'teacher' ? 'Course Instructor' : 
                                             'Student Learning'}
                                        </div>
                                    </div>
                                    <div className="table-col">{user.email}</div>
                                    <div className="table-col">
                                        {editingUserId === user.id ? (
                                            <div className="role-edit-container">
                                                <select 
                                                    value={selectedRole} 
                                                    onChange={(e) => setSelectedRole(e.target.value)}
                                                    className="role-select"
                                                >
                                                    <option value="student">Student</option>
                                                    <option value="teacher">Teacher</option>
                                                    <option value="admin">Admin</option>
                                                </select>
                                                <div className="role-edit-buttons">
                                                    <button 
                                                        className="role-btn confirm"
                                                        onClick={confirmRoleEdit}
                                                    >
                                                        ✓
                                                    </button>
                                                    <button 
                                                        className="role-btn cancel"
                                                        onClick={cancelRoleEdit}
                                                    >
                                                        ✕
                                                    </button>
                                                </div>
                                            </div>
                                        ) : (
                                            <span className={`role-badge ${user.role}`}>
                                                {user.role?.toUpperCase() || 'STUDENT'}
                                            </span>
                                        )}
                                    </div>
                                    <div className="table-col actions">
                                        <button 
                                            className="action-btn edit"
                                            onClick={() => startRoleEdit(user.id, user.role)}
                                            disabled={editingUserId === user.id}
                                        >
                                            EDIT ROLE
                                        </button>
                                        <button className="action-btn preview">PREVIEW</button>
                                        <button className="action-btn progress">VIEW PROGRESS</button>
                                        <button 
                                            className="action-btn delete"
                                            onClick={() => handleUserDelete(user.id)}
                                        >
                                            DELETE
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                )}

                {activeTab === 'courses' && (
                    <div className="courses-section">
                        <div className="section-header">
                            <h3>Course Management</h3>
                            <button 
                                className="create-btn"
                                onClick={() => {
                                    resetCourseForm();
                                    setShowCourseForm(true);
                                }}
                            >
                                CREATE COURSE
                            </button>
                        </div>

                        {showCourseForm && (
                            <div className="course-form-container">
                                <form onSubmit={handleCourseSubmit} className="course-form">
                                    <h4>{editingCourseId ? 'Edit Course' : 'Create New Course'}</h4>
                                    <div className="form-group">
                                        <label htmlFor="courseTitle">Title:</label>
                                        <input
                                            type="text"
                                            id="courseTitle"
                                            value={courseTitle}
                                            onChange={(e) => setCourseTitle(e.target.value)}
                                            placeholder="Enter course title"
                                            className="form-input"
                                            required
                                        />
                                    </div>
                                    <div className="form-group">
                                        <label htmlFor="courseDescription">Description:</label>
                                        <textarea
                                            id="courseDescription"
                                            value={courseDescription}
                                            onChange={(e) => setCourseDescription(e.target.value)}
                                            placeholder="Enter course description"
                                            className="form-textarea"
                                            rows="4"
                                            required
                                        />
                                    </div>
                                    <div className="form-group checkbox-group">
                                        <label className="checkbox-label">
                                            <input
                                                type="checkbox"
                                                checked={coursePublished}
                                                onChange={(e) => setCoursePublished(e.target.checked)}
                                                className="form-checkbox"
                                            />
                                            Publish immediately
                                        </label>
                                    </div>
                                    <div className="form-actions">
                                        <button type="submit" className="submit-btn">
                                            {editingCourseId ? 'UPDATE COURSE' : 'CREATE COURSE'}
                                        </button>
                                        <button 
                                            type="button" 
                                            onClick={cancelCourseForm}
                                            className="cancel-btn"
                                        >
                                            CANCEL
                                        </button>
                                    </div>
                                </form>
                            </div>
                        )}

                        <div className="table-header">
                            <div className="header-col">COURSE</div>
                            <div className="header-col">STATUS</div>
                            <div className="header-col">CHAPTERS</div>
                            <div className="header-col">ENROLLMENTS</div>
                            <div className="header-col">ACTIONS</div>
                        </div>
                        
                        <div className="table-content">
                            {courses.map((course) => (
                                <div key={course.courseId} className="table-row">
                                    <div className="table-col">
                                        <div className="course-title">{course.title}</div>
                                        <div className="course-subtitle">{course.description}</div>
                                    </div>
                                    <div className="table-col">
                                        <button
                                            className={`status-toggle ${course.published ? 'published' : 'draft'}`}
                                            onClick={() => handleCourseStatusToggle(course.courseId, course.published)}
                                        >
                                            {course.published ? 'PUBLISHED' : 'DRAFT'}
                                        </button>
                                    </div>
                                    <div className="table-col">{course.chapterCount || 0}</div>
                                    <div className="table-col">{course.enrollmentCount || 0}</div>
                                    <div className="table-col actions">
                                        <button 
                                            className="action-btn edit"
                                            onClick={() => handleEditCourse(course)}
                                        >
                                            EDIT
                                        </button>
                                        <button 
                                            className="action-btn delete"
                                            onClick={() => handleDeleteCourse(course.courseId)}
                                        >
                                            DELETE
                                        </button>
                                    </div>
                                </div>
                            ))}
                            {courses.length === 0 && (
                                <div className="empty-state">
                                    <p>No courses found. Create your first course to get started.</p>
                                </div>
                            )}
                        </div>
                    </div>
                )}

                {activeTab === 'pending-approval' && (
                    <div className="pending-approval-section">
                        <div className="section-header">
                            <h3>Course Approval Requests</h3>
                            <div className="approval-stats">
                                <span className="pending-count">
                                    {pendingCourses.length} courses awaiting approval
                                </span>
                            </div>
                        </div>

                        {pendingCourses.length === 0 ? (
                            <div className="empty-state">
                                <p>No courses pending approval at this time.</p>
                            </div>
                        ) : (
                            <div className="approval-list">
                                {pendingCourses.map((course) => (
                                    <div key={course.courseId} className="approval-card">
                                        <div className="course-info">
                                            <h4 className="course-title">{course.title}</h4>
                                            <p className="course-description">{course.description}</p>
                                            <div className="course-meta">
                                                <span className="created-by">Created by: {course.createdBy || 'Unknown'}</span>
                                                <span className="submitted-date">
                                                    Submitted: {course.submittedForApproval ? new Date(course.submittedForApproval).toLocaleDateString() : 'Unknown'}
                                                </span>
                                                <span className="chapter-count">{course.chapterCount || 0} chapters</span>
                                            </div>
                                        </div>
                                        <div className="approval-actions">
                                            <button 
                                                className="approve-btn"
                                                onClick={() => showApprovalDialog(course, true)}
                                            >
                                                APPROVE
                                            </button>
                                            <button 
                                                className="reject-btn"
                                                onClick={() => showApprovalDialog(course, false)}
                                            >
                                                REJECT
                                            </button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        )}
                    </div>
                )}

                {activeTab === 'announcements' && (
                    <div className="announcements-section">
                        <div className="section-header">
                            <h3>Announcements Management</h3>
                            <button 
                                className="create-btn"
                                onClick={() => setShowAnnouncementForm(true)}
                            >
                                CREATE ANNOUNCEMENT
                            </button>
                        </div>

                        {showAnnouncementForm && (
                            <div className="announcement-form-container">
                                <form onSubmit={handleAnnouncementSubmit} className="announcement-form">
                                    <h4>Create New Announcement</h4>
                                    <div className="form-group">
                                        <label htmlFor="announcementTitle">Title:</label>
                                        <input
                                            type="text"
                                            id="announcementTitle"
                                            value={announcementTitle}
                                            onChange={(e) => setAnnouncementTitle(e.target.value)}
                                            placeholder="Enter announcement title"
                                            className="form-input"
                                            required
                                        />
                                    </div>
                                    <div className="form-group">
                                        <label htmlFor="announcementContent">Content:</label>
                                        <textarea
                                            id="announcementContent"
                                            value={announcementContent}
                                            onChange={(e) => setAnnouncementContent(e.target.value)}
                                            placeholder="Enter announcement content"
                                            className="form-textarea"
                                            rows="4"
                                            required
                                        />
                                    </div>
                                    <div className="form-actions">
                                        <button type="submit" className="form-btn submit">
                                            CREATE ANNOUNCEMENT
                                        </button>
                                        <button 
                                            type="button" 
                                            className="form-btn cancel"
                                            onClick={cancelAnnouncementForm}
                                        >
                                            CANCEL
                                        </button>
                                    </div>
                                </form>
                            </div>
                        )}
                        
                        <div className="announcements-list">
                            {announcements.length > 0 ? (
                                announcements.map((announcement) => (
                                    <div key={announcement.id} className="announcement-card">
                                        <div className="announcement-header">
                                            <h4>{announcement.title}</h4>
                                            <span className="announcement-date">
                                                {new Date(announcement.publishedDate).toLocaleDateString()}
                                            </span>
                                        </div>
                                        <p className="announcement-content">{announcement.content}</p>
                                        <div className="announcement-actions">
                                            <button className="action-btn edit">EDIT</button>
                                            <button className="action-btn delete">DELETE</button>
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div className="empty-state">
                                    <p>No announcements yet. Create your first announcement to inform users about important updates.</p>
                                </div>
                            )}
                        </div>
                    </div>
                )}

                {activeTab === 'feedback' && (
                    <div className="feedback-section">
                        <div className="section-header">
                            <h3>User Feedback & Help Requests</h3>
                        </div>
                        
                        <div className="feedback-list">
                            {feedback.length > 0 ? (
                                feedback.map((item) => (
                                    <div key={item.id} className="feedback-card">
                                        <div className="feedback-header">
                                            <h4>Feedback from {item.userName || 'Anonymous'}</h4>
                                            <span className="feedback-date">
                                                {new Date(item.submittedDate).toLocaleDateString()}
                                            </span>
                                        </div>
                                        <p className="feedback-content">{item.content}</p>
                                        <div className="feedback-actions">
                                            <button className="action-btn preview">REPLY</button>
                                            <button className="action-btn edit">MARK RESOLVED</button>
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div className="empty-state">
                                    <p>No feedback submissions yet. User feedback will appear here when submitted.</p>
                                </div>
                            )}
                        </div>
                    </div>
                )}

                {activeTab === 'reports' && (
                    <div className="reports-section">
                        <div className="section-header">
                            <h3>System Reports</h3>
                            <button 
                                className="create-btn"
                                onClick={handleGenerateReport}
                            >
                                GENERATE NEW REPORT
                            </button>
                        </div>
                        
                        <div className="reports-stats">
                            <div className="stat-card">
                                <h4>User Statistics</h4>
                                <div className="stat-details">
                                    <p>Total Users: {dashboardStats.totalUsers || 0}</p>
                                    <p>Students: {dashboardStats.totalStudents || 0}</p>
                                    <p>Teachers: {dashboardStats.totalTeachers || 0}</p>
                                    <p>Admins: {dashboardStats.totalAdmins || 0}</p>
                                </div>
                            </div>
                            
                            <div className="stat-card">
                                <h4>Content Statistics</h4>
                                <div className="stat-details">
                                    <p>Total Courses: {dashboardStats.totalCourses || 0}</p>
                                    <p>Total Chapters: {dashboardStats.totalChapters || 0}</p>
                                    <p>Resources: {dashboardStats.totalResources || 0}</p>
                                </div>
                            </div>
                            
                            <div className="stat-card">
                                <h4>Community Statistics</h4>
                                <div className="stat-details">
                                    <p>Forum Posts: {dashboardStats.totalForumPosts || 0}</p>
                                    <p>Active Users: {dashboardStats.activeUsers || 'N/A'}</p>
                                    <p>User Engagement: {dashboardStats.engagementRate || 'N/A'}</p>
                                </div>
                            </div>
                        </div>
                        
                        <div className="reports-list">
                            {reports.length > 0 ? (
                                reports.map((report) => (
                                    <div key={report.id} className="report-card">
                                        <div className="report-header">
                                            <h4>{report.title}</h4>
                                            <span className="report-date">
                                                {new Date(report.generatedDate).toLocaleDateString()}
                                            </span>
                                        </div>
                                        <p className="report-summary">{report.summary}</p>
                                        <div className="report-actions">
                                            <button className="action-btn preview">VIEW</button>
                                            <button className="action-btn edit">DOWNLOAD</button>
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div className="empty-state">
                                    <p>No reports generated yet. Click "Generate New Report" to create your first system report.</p>
                                </div>
                            )}
                        </div>
                    </div>
                )}

                {activeTab === 'system' && (
                    <div className="system-section">
                        <div className="system-stats">
                            <h3>System Statistics</h3>
                            <div className="stats-grid">
                                <div className="stat-item">
                                    <strong>Total Users:</strong> {dashboardStats.totalUsers || users.length}
                                </div>
                                <div className="stat-item">
                                    <strong>Active Courses:</strong> {dashboardStats.totalCourses || courses.length}
                                </div>
                                <div className="stat-item">
                                    <strong>System Status:</strong> Online
                                </div>
                                <div className="stat-item">
                                    <strong>Database Status:</strong> Connected
                                </div>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </div>
        </>
    )
};
export default AdminDashboard;
