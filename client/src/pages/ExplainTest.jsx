import React, { useState } from 'react';
import '../styles/ExplainTest.css';
import ReturnHome from '../components/ReturnHome';
import TestingNav from '../components/TestingNav';
import ExplanationPopup from '../components/ExplanationPopup';
import { submitTestExplanation } from '../pagesBack/explainTestService';

const ExplainTest = () => {
    const [formData, setFormData] = useState({ testContent: '', userName: '' });
    const [status, setStatus] = useState({ error: '', success: '', loading: false });
    const [popup, setPopup] = useState({ show: false, explanation: '' });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const resetStatus = () => setStatus({ error: '', success: '', loading: false });

    

    const handleSubmit = async (e) => {
        e.preventDefault();
        resetStatus();
        
        // Validation
        if (!formData.testContent.trim() || !formData.userName.trim()) {
            setStatus({ error: 'All fields are required', success: '', loading: false });
            return;
        }

        setStatus({ error: '', success: '', loading: true });

        try {
            const result = await submitTestExplanation(formData);
            
            setStatus({ error: '', success: 'Test explanation submitted successfully!', loading: false });
            setPopup({ show: true, explanation: result });
            setFormData({ testContent: '', userName: '' });
            
        } catch (err) {
            setStatus({ error: err.message || 'An unexpected error occurred', success: '', loading: false });
        }
    };
    return (
        <div className="explain-test-container">
            <TestingNav />
            <div className="explain-test-card">
                <h2>Test Explanation Submission</h2>
                
                {status.error && <div className="error">{status.error}</div>}
                {status.success && <div className="success">{status.success}</div>}
                
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label htmlFor="userName">User Name</label>
                        <input 
                            type="text" 
                            id="userName"
                            name="userName"
                            placeholder="Enter your name"
                            value={formData.userName}
                            onChange={handleChange}
                            disabled={status.loading}
                        />
                    </div>
                    
                    <div className="form-group">
                        <label htmlFor="testContent">Test Content</label>
                        <textarea 
                            id="testContent"
                            name="testContent"
                            placeholder="Enter your test content or explanation here..."
                            rows="10"
                            value={formData.testContent}
                            onChange={handleChange}
                            disabled={status.loading}
                        />
                    </div>
                    
                    <button type="submit" disabled={status.loading}>
                        {status.loading ? 'Submitting...' : 'Submit Explanation'}
                    </button>
                </form>
                
                <ReturnHome />
            </div>
            
            <ExplanationPopup 
                isOpen={popup.show}
                explanation={popup.explanation}
                onClose={() => setPopup({ show: false, explanation: '' })}
            />
        </div>
    );
};

export default ExplainTest;
