import React from 'react';
import '../styles/Login.css';
import ReturnHome from '../components/ReturnHome';


const Login = () => {


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
                <ReturnHome />
            </div>
        </div>
    );
};

export default Login;
