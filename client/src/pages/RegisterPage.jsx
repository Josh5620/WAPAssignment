import React from 'react';
import '../styles/Register.css';
import ReturnHome from '../components/ReturnHome';

const RegisterPage = () => {

    return (
        <div className="register-container">
            <div className="register-card">
                <h2>Register Form</h2>
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
}
export default RegisterPage;
