import React from 'react';
import '../styles/ExplanationPopup.css';

const ExplanationPopup = ({ isOpen, explanation, onClose }) => {
    if (!isOpen) return null;

    // Extract and format explanation text
    const getExplanationText = () => {
        try {
            const text = typeof explanation === 'object' ? explanation.reply : explanation;
            return text || 'No explanation provided';
        } catch {
            return 'Error displaying explanation';
        }
    };

    const handleOverlayClick = (e) => {
        if (e.target === e.currentTarget) onClose();
    };

    return (
        <div className="popup-overlay" onClick={handleOverlayClick}>
            <div className="popup-content">
                <div className="popup-header">
                    <h3>Code Explanation</h3>
                    <button className="close-button" onClick={onClose}>×</button>
                </div>
                <div className="popup-body">
                    <div className="explanation-text">
                        {getExplanationText().split('\n').map((line, index) => (
                            <p key={index}>{line}</p>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ExplanationPopup;
