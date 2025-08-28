import React from 'react';
import { useNavigate } from 'react-router-dom';
import "../styles/ReturnHome.css";

const ReturnHome = () => {
    const navigate = useNavigate();

    const handleReturnHome = () => {
        navigate('/');
    };

    return (
        <button 
            onClick={handleReturnHome} 
            className="return-home-arrow"
            title="Back to Home"
        >
            ←
        </button>
    );
};

export default ReturnHome;