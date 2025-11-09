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
      if (!userProfile || !userProfile.id) {
        navigate('/login');
        return;
      }

      // For now, use basic profile data
      // TODO: Create backend endpoint for teacher profile
      setProfile({
        id: userProfile.id,
        fullName: userProfile.full_name || 'Teacher',
        email: userProfile.email || '',
        role: userProfile.role || 'Teacher',
        bio: userProfile.bio || '',
        expertise: userProfile.expertise || 'Python Programming'
      });

      setFormData({
        fullName: userProfile.full_name || '',
        email: userProfile.email || '',
        bio: userProfile.bio || '',
        expertise: userProfile.expertise || 'Python Programming'
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
      
      // TODO: Create backend endpoint for updating teacher profile
      // For now, update localStorage
      const userProfile = quickApi.getUserProfile();
      const updatedProfile = {
        ...profile,
        fullName: formData.fullName,
        email: formData.email,
        bio: formData.bio,
        expertise: formData.expertise
      };
      
      setProfile(updatedProfile);
      setEditing(false);
      setSuccess('Profile updated successfully!');
      
      // Update localStorage
      quickApi.storeUserData({
        ...userProfile,
        full_name: formData.fullName,
        email: formData.email,
        bio: formData.bio,
        expertise: formData.expertise
      });

      setTimeout(() => setSuccess(null), 3000);
    } catch (err) {
      console.error('Failed to update profile:', err);
      setError('Failed to update profile. Please try again.');
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
