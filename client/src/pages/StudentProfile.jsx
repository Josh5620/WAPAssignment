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
  const [certificates, setCertificates] = useState([]);
  const [certificatesLoading, setCertificatesLoading] = useState(true);
  const [certificatesError, setCertificatesError] = useState(null);

  useEffect(() => {
    loadProfile();
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
      
      // Fetch fresh profile data from backend using unified auth endpoint
      const token = quickApi.getUserToken();
      const data = await api.auth.getProfile(token);

      // Then fetch student-specific data (leaderboard, progress, etc.)
      const studentData = await api.students.getStudentProfile(userId);
      let certificateData = [];
      try {
        setCertificatesLoading(true);
        const response = await api.students.getCertificates();
        certificateData = Array.isArray(response) ? response : [];
        setCertificatesError(null);
      } catch (certError) {
        console.error('Failed to load certificates:', certError);
        setCertificatesError('Unable to load certificates at this time.');
      } finally {
        setCertificatesLoading(false);
      }

      // Merge the data
      setProfile({
        ...data,
        ...studentData,
        id: data.userId
      });
      setCertificates(certificateData);

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
      
      // Update profile via unified auth endpoint
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
      const storedProfile = quickApi.getUserProfile();
      quickApi.storeUserData({
        ...storedProfile,
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

  const renderCertificates = () => {
    if (certificatesLoading) {
      return <div className="certificates-status">Loading certificates...</div>;
    }

    if (certificatesError) {
      return <div className="certificates-status is-error">{certificatesError}</div>;
    }

    if (!certificates.length) {
      return <div className="certificates-status is-empty">Complete a course to earn your first certificate!</div>;
    }

    return (
      <ul className="certificate-list">
        {certificates.map((certificate) => (
          <li key={certificate.certificateId} className="certificate-item">
            <div className="certificate-info">
              <h3>{certificate.courseTitle || 'Course Certificate'}</h3>
              <p>Issued on {new Date(certificate.issueDate).toLocaleDateString()}</p>
            </div>
            <div className="certificate-actions">
              <a
                href={certificate.certificateUrl || '#'}
                target="_blank"
                rel="noopener noreferrer"
                className="certificate-link"
              >
                View Certificate
              </a>
            </div>
          </li>
        ))}
      </ul>
    );
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
                  <>
                    <div className="info-item">
                      <span className="info-label">XP Points:</span>
                      <span className="info-value">{profile.leaderboard.xp} XP</span>
                    </div>
                    <div className="info-item">
                      <span className="info-label">Rank:</span>
                      <span className="info-value">#{profile.leaderboard.rank || 'Unranked'}</span>
                    </div>
                  </>
                )}
                <div className="info-item">
                  <span className="info-label">Member Since:</span>
                  <span className="info-value">
                    {profile.createdAt ? new Date(profile.createdAt).toLocaleDateString('en-US', { 
                      year: 'numeric', 
                      month: 'long', 
                      day: 'numeric' 
                    }) : 'Recently joined'}
                  </span>
                </div>
              </div>
            )}
          </div>

          <div className="profile-section">
            <h2>Quick Stats</h2>
            <div className="quick-stats">
              <div className="stat-box">
                <div className="stat-icon">📚</div>
                <div className="stat-info">
                  <div className="stat-value">{profile.completedChapters || 0}</div>
                  <div className="stat-label">Chapters Completed</div>
                </div>
              </div>
              <div className="stat-box">
                <div className="stat-icon">🔥</div>
                <div className="stat-info">
                  <div className="stat-value">{profile.currentStreak || 0}</div>
                  <div className="stat-label">Day Streak</div>
                </div>
              </div>
              <div className="stat-box">
                <div className="stat-icon">⏱️</div>
                <div className="stat-info">
                  <div className="stat-value">{profile.totalMinutes || 0}</div>
                  <div className="stat-label">Minutes Learned</div>
                </div>
              </div>
              <div className="stat-box">
                <div className="stat-icon">🏆</div>
                <div className="stat-info">
                  <div className="stat-value">{profile.achievementsCount || 0}</div>
                  <div className="stat-label">Achievements</div>
                </div>
              </div>
            </div>
          </div>

          <div className="profile-section">
            <h2>My Certificates</h2>
            {renderCertificates()}
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

