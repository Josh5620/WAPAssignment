import React from 'react';
import '../styles/Home.css';
import { useNavigate } from 'react-router-dom';

const Home = () => {
    const navigate = useNavigate();

    const handleLogin = () => {
        // Placeholder for logout logic
        navigate('/login');
    };

    return (
        <div className="home-container">
            <h1>Welcome to the Home Page</h1>
            <button onClick={handleLogin}>Login</button>
        </div>
    );
}

export default Home;