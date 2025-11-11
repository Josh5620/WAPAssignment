import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';
import Navbar from '../components/Navbar';
import '../styles/AdminProfile.css';

const AdminProfile = () => {
  const navigate = useNavigate();
  const [profile, setProfile] = useState(null);
  const [editing, setEditing] = useState(false);
  const [formData, setFormData] = useState({
    fullName: '',
    email: ''
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [stats, setStats] = useState({
    totalUsers: 0,
    totalStudents: 0,
    totalTeachers: 0,
    totalCourses: 0,
    pendingApprovals: 0,
    totalAnnouncements: 0
  });

  useEffect(() => {
    loadProfile();
    loadStats();
  }, []);

  const loadProfile = async () => {
    try {
      setLoading(true);
      const userProfile = quickApi.getUserProfile();
      
      // Extract user ID - handle both nested (user.id/user.userId) and flat (id/userId) structures
      const userId = userProfile?.user?.id || userProfile?.user?.userId || userProfile?.id || userProfile?.userId;
      
      if (!userProfile || !userId) {
        console.log('No valid user profile found, redirecting to login');
        navigate('/login');
        return;
      }

      console.log('Loading profile for userId:', userId);
      
      // Fetch fresh profile data from backend
      const token = quickApi.getUserToken();
      const data = await api.auth.getProfile(token);
      
      setProfile({
        id: data.userId,
        fullName: data.fullName || 'Admin',
        email: data.email || '',
        role: data.role || 'Admin',
        createdAt: data.createdAt
      });

      setFormData({
        fullName: data.fullName || '',
        email: data.email || ''
      });

      setError(null);
    } catch (err) {
      console.error('Failed to load profile:', err);
      setError('Failed to load profile. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const loadStats = async () => {
    try {
      const token = quickApi.getUserToken();
      const dashboardData = await api.admin.getDashboard(token);
      
      if (dashboardData.success) {
        const data = dashboardData.data;
        setStats({
          totalUsers: data.statistics?.totalProfiles || 0,
          totalStudents: data.statistics?.totalStudents || 0,
          totalTeachers: data.statistics?.totalTeachers || 0,
          totalCourses: data.statistics?.totalCourses || 0,
          pendingApprovals: data.statistics?.pendingCourses || 0,
          totalAnnouncements: data.recentAnnouncements?.length || 0
        });
      }
    } catch (err) {
      console.error('Failed to load stats:', err);
    }
  };

  const handleEdit = () => {
    setEditing(true);
    setSuccess(null);
  };

  const handleCancel = () => {
    setEditing(false);
    if (profile) {
      setFormData({
        fullName: profile.fullName || '',
        email: profile.email || ''
      });
    }
    setSuccess(null);
    setError(null);
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSave = async () => {
    if (!formData.fullName.trim()) {
      setError('Full name is required.');
      return;
    }

    if (!formData.email.trim()) {
      setError('Email is required.');
      return;
    }

    try {
      setSaving(true);
      setError(null);
      
      // Update profile via backend API
      const token = quickApi.getUserToken();
      const updatedProfile = await api.auth.updateProfile(token, {
        fullName: formData.fullName,
        email: formData.email
      });
      
      setProfile({
        ...profile,
        fullName: updatedProfile.fullName,
        email: updatedProfile.email
      });
      
      setEditing(false);
      setSuccess('Profile updated successfully!');
      
      // Update localStorage
      const userProfile = quickApi.getUserProfile();
      quickApi.storeUserData({
        ...userProfile,
        fullName: updatedProfile.fullName,
        email: updatedProfile.email
      });

      setTimeout(() => setSuccess(null), 3000);
    } catch (err) {
      console.error('Failed to update profile:', err);
      setError(err.message || 'Failed to update profile. Please try again.');
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <>
        <Navbar />
        <div className="admin-profile-page">
          <div className="profile-loading">
            <div className="loading-spinner">👨‍💼</div>
            <p>Loading your profile...</p>
          </div>
        </div>
      </>
    );
  }

  if (!profile) {
    return (
      <>
        <Navbar />
        <div className="admin-profile-page">
          <div className="profile-error">
            <p>Failed to load profile.</p>
            <button onClick={loadProfile}>Try Again</button>
          </div>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <div className="admin-profile-page">
        <div className="profile-container">
          <div className="profile-header">
            <h1>Admin Profile</h1>
            {!editing && (
              <button className="edit-profile-button" onClick={handleEdit}>
                Edit Profile
              </button>
            )}
          </div>

          {error && (
            <div className="error-message">
              <p>{error}</p>
            </div>
          )}

          {success && (
            <div className="success-message">
              <p>{success}</p>
            </div>
          )}

          {/* Profile Information */}
          <div className="profile-section">
            <h2>Profile Information</h2>
            {editing ? (
              <div className="profile-form">
                <div className="form-group">
                  <label htmlFor="fullName">Full Name</label>
                  <input
                    type="text"
                    id="fullName"
                    name="fullName"
                    value={formData.fullName}
                    onChange={handleChange}
                    required
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="email">Email</label>
                  <input
                    type="email"
                    id="email"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                    required
                  />
                </div>
                <div className="form-actions">
                  <button
                    className="save-button"
                    onClick={handleSave}
                    disabled={saving}
                  >
                    {saving ? 'Saving...' : 'Save Changes'}
                  </button>
                  <button
                    className="cancel-button"
                    onClick={handleCancel}
                    disabled={saving}
                  >
                    Cancel
                  </button>
                </div>
              </div>
            ) : (
              <div className="profile-info">
                <div className="info-item">
                  <span className="info-label">Full Name:</span>
                  <span className="info-value">{profile.fullName}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Email:</span>
                  <span className="info-value">{profile.email}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Role:</span>
                  <span className="info-value">{profile.role}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Admin Since:</span>
                  <span className="info-value">
                    {profile.createdAt ? new Date(profile.createdAt).toLocaleDateString('en-US', { 
                      year: 'numeric', 
                      month: 'long', 
                      day: 'numeric' 
                    }) : 'Unknown'}
                  </span>
                </div>
              </div>
            )}
          </div>

          {/* System Statistics */}
          <div className="profile-section">
            <h2>System Overview</h2>
            <div className="stats-grid">
              <div className="stat-card">
                <div className="stat-icon">👥</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalUsers}</div>
                  <div className="stat-label">Total Users</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">🎓</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalStudents}</div>
                  <div className="stat-label">Students</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">👨‍🏫</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalTeachers}</div>
                  <div className="stat-label">Teachers</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">📚</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalCourses}</div>
                  <div className="stat-label">Courses</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">⏳</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.pendingApprovals}</div>
                  <div className="stat-label">Pending Approvals</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">📢</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalAnnouncements}</div>
                  <div className="stat-label">Announcements</div>
                </div>
              </div>
            </div>
          </div>

          {/* Quick Actions */}
          <div className="profile-section">
            <h2>Quick Actions</h2>
            <div className="quick-actions">
              <button
                className="action-button"
                onClick={() => navigate('/admin/dashboard')}
              >
                <span className="action-icon">📊</span>
                <span className="action-text">Dashboard</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/admin/dashboard')}
              >
                <span className="action-icon">👥</span>
                <span className="action-text">Manage Users</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/admin/dashboard')}
              >
                <span className="action-icon">📚</span>
                <span className="action-text">Manage Courses</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/admin/dashboard')}
              >
                <span className="action-icon">✅</span>
                <span className="action-text">Pending Approvals</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/admin/dashboard')}
              >
                <span className="action-icon">📢</span>
                <span className="action-text">Announcements</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/forum')}
              >
                <span className="action-icon">💬</span>
                <span className="action-text">Forum</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default AdminProfile;
