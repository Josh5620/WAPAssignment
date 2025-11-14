import React from 'react';
import { useNavigate } from 'react-router-dom';
import "../styles/ReturnHome.css";

const ReturnHome = () => {
    const navigate = useNavigate();

    const handleReturnHome = () => {
        navigate('/courses');
    };

    return (
        <button 
            onClick={handleReturnHome} 
            className="return-home-arrow"
            title="Back to Courses"
        >
            Back
        </button>
    );
};

export default ReturnHome;