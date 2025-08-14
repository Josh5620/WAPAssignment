import React, { useState } from 'react';
import '../styles/ExplainTest.css';
import ReturnHome from '../components/ReturnHome';
import { submitTestExplanation } from '../pagesBack/explainTestService';

const ExplainTest = () => {
    const [formData, setFormData] = useState({
        testContent: '',
        userName: ''
    });
    const [error, setError] = useState('');
    const [success, setSuccess] = useState('');
    const [loading, setLoading] = useState(false);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value
        }));
    };

    

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setSuccess('');
        setLoading(true);

        // Basic validation
        if (!formData.testContent.trim() || !formData.userName.trim()) {
            setError('All fields are required');
            setLoading(false);
            return;
        }

        try {
            const result = await submitTestExplanation(formData);
            if (result.error) {
                setError(result.error);
            } else {
                setSuccess('Test explanation submitted successfully!');
                setFormData({
                    testContent: '',
                    userName: ''
                });
            }
        } catch (err) {
            setError(err.message || 'An unexpected error occurred');
        } finally {
            setLoading(false);
        }
    };



    return (
        <div className="explain-test-container">
            <div className="explain-test-card">
                <h2>Test Explanation Submission</h2>
                
                {error && <div className="error">{error}</div>}
                {success && <div className="success">{success}</div>}
                
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
                            disabled={loading}
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
                            disabled={loading}
                        />
                    </div>
                    
                    <button type="submit" disabled={loading}>
                        {loading ? 'Submitting...' : 'Submit Explanation'}
                    </button>
                </form>
                
                <ReturnHome />
            </div>
        </div>
    );
};

export default ExplainTest;
