import React from 'react';
import '../styles/Home.css';
import StartChoice from '../components/StartChoice';

const Home = () => {

    return (
        <div className="home-container">
            <h1>Welcome to the Home Page</h1>
            <StartChoice startLoc="/teacherLogin" text="Go to Teacher Login" />
            <StartChoice startLoc="/studentLogin" text="Go to Student Login" />
            <StartChoice startLoc="/admin" text="Go to Admin Login" />
            <StartChoice startLoc="/register" text="register" />
            
        </div>
    );
}

export default Home;