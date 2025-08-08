import React, { useState } from 'react';
import '../styles/AdminLogin.css';
import ReturnHome from '../components/ReturnHome';

const AdminLogin = () => {
  const [adminId, setAdminId] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    // No functionality for now
    console.log('Admin login attempted with:', { adminId, password });
  };

  return (
    <div className="admin-login-container">
      <ReturnHome />
      <div className="admin-login-form">
        <h2 className="admin-login-title">Admin Login</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="adminId">Admin ID</label>
            <input
              type="text"
              id="adminId"
              value={adminId}
              onChange={(e) => setAdminId(e.target.value)}
              placeholder="Enter your admin ID"
              required
            />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Enter your password"
              required
            />
          </div>
          <button type="submit" className="admin-login-btn">
            Login as Admin
          </button>
        </form>
        <div className="admin-login-footer">
          <p>Secure admin access only</p>
        </div>
      </div>
    </div>
  );
};

export default AdminLogin;
