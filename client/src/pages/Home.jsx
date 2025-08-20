import React from 'react';
import '../styles/Home.css';
import StartChoice from '../components/StartChoice';

const Home = () => {

    return (
        <div className="home-container">
            <h1 className="home-title">Welcome to the Home Page</h1>
            <div className="buttons-container">
                <StartChoice startLoc="/teacherLogin" text="Go to Teacher Login" />
                <StartChoice startLoc="/studentLogin" text="Go to Student Login" />
                <StartChoice startLoc="/admin" text="Go to Admin Login" />
                <StartChoice startLoc="/register" text="register" />
            </div>
        </div>
    );
}

export default Home;