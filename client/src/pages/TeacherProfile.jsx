import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';
import Navbar from '../components/Navbar';
import '../styles/TeacherProfile.css';

const TeacherProfile = () => {
  const navigate = useNavigate();
  const [profile, setProfile] = useState(null);
  const [editing, setEditing] = useState(false);
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    bio: '',
    expertise: ''
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [stats, setStats] = useState({
    totalStudents: 0,
    totalCourses: 0,
    pendingFeedback: 0,
    forumPosts: 0
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
        fullName: data.fullName || 'Teacher',
        email: data.email || '',
        role: data.role || 'Teacher',
        bio: data.bio || '',
        expertise: data.expertise || ''
      });

      setFormData({
        fullName: data.fullName || '',
        email: data.email || '',
        bio: data.bio || '',
        expertise: data.expertise || ''
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
      // TODO: Create backend endpoints for teacher stats
      // For now, use placeholder data
      setStats({
        totalStudents: 0,
        totalCourses: 1,
        pendingFeedback: 0,
        forumPosts: 0
      });
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
        email: profile.email || '',
        bio: profile.bio || '',
        expertise: profile.expertise || ''
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
        <div className="teacher-profile-page">
          <div className="profile-loading">
            <div className="loading-spinner">👨‍🏫</div>
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
        <div className="teacher-profile-page">
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
      <div className="teacher-profile-page">
        <div className="profile-container">
          <div className="profile-header">
            <h1>My Profile</h1>
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
                <div className="form-group">
                  <label htmlFor="expertise">Expertise</label>
                  <input
                    type="text"
                    id="expertise"
                    name="expertise"
                    value={formData.expertise}
                    onChange={handleChange}
                    placeholder="e.g., Python Programming, Web Development"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="bio">Bio</label>
                  <textarea
                    id="bio"
                    name="bio"
                    value={formData.bio}
                    onChange={handleChange}
                    rows={4}
                    placeholder="Tell students about yourself and your teaching philosophy..."
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
                  <span className="info-label">Expertise:</span>
                  <span className="info-value">{profile.expertise || 'Not specified'}</span>
                </div>
                {profile.bio && (
                  <div className="info-item bio-item">
                    <span className="info-label">Bio:</span>
                    <span className="info-value bio-text">{profile.bio}</span>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Teaching Statistics */}
          <div className="profile-section">
            <h2>Teaching Statistics</h2>
            <div className="stats-grid">
              <div className="stat-card">
                <div className="stat-icon">👥</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalStudents}</div>
                  <div className="stat-label">Total Students</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">📚</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.totalCourses}</div>
                  <div className="stat-label">Courses Created</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">📝</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.pendingFeedback}</div>
                  <div className="stat-label">Pending Feedback</div>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">💬</div>
                <div className="stat-content">
                  <div className="stat-value">{stats.forumPosts}</div>
                  <div className="stat-label">Forum Posts</div>
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
                onClick={() => navigate('/teacher/courses')}
              >
                <span className="action-icon">📚</span>
                <span className="action-text">Manage Courses</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/teacher/feedback')}
              >
                <span className="action-icon">📝</span>
                <span className="action-text">Review Feedback</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/forum')}
              >
                <span className="action-icon">💬</span>
                <span className="action-text">Community Forum</span>
              </button>
              <button
                className="action-button"
                onClick={() => navigate('/teacher/dashboard')}
              >
                <span className="action-icon">📊</span>
                <span className="action-text">View Dashboard</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default TeacherProfile;
