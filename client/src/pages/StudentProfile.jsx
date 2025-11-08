import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';
import Navbar from '../components/Navbar';
import StudentLeaderboard from '../components/StudentLeaderboard';
import StudentProgress from '../components/StudentProgress';
import '../styles/StudentProfile.css';

const StudentProfile = () => {
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

  useEffect(() => {
    loadProfile();
  }, []);

  const loadProfile = async () => {
    try {
      setLoading(true);
      const userProfile = quickApi.getUserProfile();
      if (!userProfile || !userProfile.id) {
        navigate('/login');
        return;
      }

      const data = await api.students.getStudentProfile(userProfile.id);
      setProfile(data);
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
      const userProfile = quickApi.getUserProfile();
      const updatedProfile = await api.students.updateStudentProfile(userProfile.id, formData);
      setProfile(updatedProfile);
      setEditing(false);
      setSuccess('Profile updated successfully!');
      
      // Update localStorage
      const storedProfile = quickApi.getUserProfile();
      quickApi.storeUserData({
        ...storedProfile,
        full_name: updatedProfile.fullName,
        email: updatedProfile.email
      });
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
        <div className="profile-loading">Loading profile...</div>
      </>
    );
  }

  if (!profile) {
    return (
      <>
        <Navbar />
        <div className="profile-error">
          <p>Failed to load profile.</p>
          <button onClick={() => navigate('/login')}>Go to Login</button>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <div className="student-profile-page">
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
                {profile.leaderboard && (
                  <div className="info-item">
                    <span className="info-label">XP Points:</span>
                    <span className="info-value">{profile.leaderboard.xp}</span>
                  </div>
                )}
              </div>
            )}
          </div>

          <div className="profile-section">
            <h2>Leaderboard</h2>
            <StudentLeaderboard />
          </div>

          <div className="profile-section">
            <h2>Learning Progress</h2>
            <StudentProgress />
          </div>
        </div>
      </div>
    </>
  );
};

export default StudentProfile;

