import React from 'react';
import '../styles/Login.css';
import { useNavigate } from 'react-router-dom';

const Login = () => {

    const navigate = useNavigate();
    const handleLogout = () => {
        navigate('/');
    };
    return (
        <div className="login-container">
            <div className="login-card">
                <h2>Login Form</h2>
                <div className="form-group">
                    <input 
                        type="text" 
                        placeholder="Username"
                    />
                </div>
                <div className="form-group">
                    <input 
                        type="email" 
                        placeholder="Email"
                    />
                </div>
                <div className="form-group">
                    <input 
                        type="password" 
                        placeholder="Password"
                    />
                </div>
                <button onClick={handleLogout}>Logout</button>
            </div>
        </div>
    );
};

export default Login;
