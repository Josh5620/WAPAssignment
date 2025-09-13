import React from 'react';
import '../styles/UserDashboard.css';
import TestingNav from '../components/TestingNav';
import ReturnHome from '../components/ReturnHome';

const UserDashboard = () => {
  return (
    <div className="user-dashboard">
      <TestingNav />
      <ReturnHome />
      
      <div className="dashboard-container">
        <header className="dashboard-header">
          <h1>User Dashboard</h1>
          <p>Welcome back! Manage your learning progress and account settings.</p>
        </header>

        <div className="dashboard-grid">
          <div className="dashboard-card">
            <h3>My Courses</h3>
            <p>Track your enrolled courses and progress</p>
            <button className="dashboard-btn">View Courses</button>
          </div>

          <div className="dashboard-card">
            <h3>Recent Activity</h3>
            <p>See your latest learning activities</p>
            <button className="dashboard-btn">View Activity</button>
          </div>

          <div className="dashboard-card">
            <h3>Achievements</h3>
            <p>Check your badges and certificates</p>
            <button className="dashboard-btn">View Achievements</button>
          </div>

          <div className="dashboard-card">
            <h3>Profile Settings</h3>
            <p>Update your profile and preferences</p>
            <button className="dashboard-btn">Edit Profile</button>
          </div>

          <div className="dashboard-card">
            <h3>Learning Stats</h3>
            <p>View your learning statistics and trends</p>
            <button className="dashboard-btn">View Stats</button>
          </div>

          <div className="dashboard-card">
            <h3>Support</h3>
            <p>Get help and contact support</p>
            <button className="dashboard-btn">Get Help</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UserDashboard;