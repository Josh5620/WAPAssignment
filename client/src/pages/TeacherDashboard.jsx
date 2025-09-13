import React from 'react';
import '../styles/TeacherDashboard.css';
import TestingNav from '../components/TestingNav';
import ReturnHome from '../components/ReturnHome';

const TeacherDashboard = () => {
  return (
    <div className="teacher-dashboard">
      <TestingNav />
      <ReturnHome />
      
      <div className="dashboard-container">
        <header className="dashboard-header">
          <h1>Teacher Dashboard</h1>
          <p>Manage your courses, students, and teaching materials.</p>
        </header>

        <div className="dashboard-grid">
          <div className="dashboard-card">
            <h3>My Classes</h3>
            <p>View and manage your teaching classes</p>
            <button className="dashboard-btn">Manage Classes</button>
          </div>

          <div className="dashboard-card">
            <h3>Student Progress</h3>
            <p>Track student performance and progress</p>
            <button className="dashboard-btn">View Progress</button>
          </div>

          <div className="dashboard-card">
            <h3>Course Materials</h3>
            <p>Upload and organize teaching materials</p>
            <button className="dashboard-btn">Manage Materials</button>
          </div>

          <div className="dashboard-card">
            <h3>Assignments</h3>
            <p>Create and grade assignments</p>
            <button className="dashboard-btn">Manage Assignments</button>
          </div>

          <div className="dashboard-card">
            <h3>Class Schedule</h3>
            <p>View your teaching schedule and calendar</p>
            <button className="dashboard-btn">View Schedule</button>
          </div>

          <div className="dashboard-card">
            <h3>Gradebook</h3>
            <p>Manage grades and assessments</p>
            <button className="dashboard-btn">Open Gradebook</button>
          </div>

          <div className="dashboard-card">
            <h3>Communication</h3>
            <p>Message students and parents</p>
            <button className="dashboard-btn">Send Messages</button>
          </div>

          <div className="dashboard-card">
            <h3>Reports</h3>
            <p>Generate teaching reports and analytics</p>
            <button className="dashboard-btn">Generate Reports</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TeacherDashboard;