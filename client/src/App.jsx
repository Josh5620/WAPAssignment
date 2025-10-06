import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./pages/Login";
import HomePage from "./pages/HomePage";
import Register from "./pages/Register";
import AdminLogin from "./pages/AdminLogin";
import AdminDashboard from "./pages/AdminDashboard";
import UserDashboard from "./pages/UserDashboard";
import TeacherDashboard from "./pages/TeacherDashboard";
import ChatBotPopup from "./components/ChatBotPopup";
import TestingNav from "./components/TestingNav";
import ExplainTest from "./pages/ExplainTest";
import About from "./pages/About"; 
import CoursesPage from "./pages/CoursesPage";
import FAQ from "./pages/FAQ";
import ApiTest from './components/ApiTest';
import React from 'react';

function App() {
    console.log("App mounted ✅");
  return (
    <>
      <div
        style={{
          position: 'fixed',
          top: 0,
          left: 0,
          width: '100vw',
          height: '20px', 
          zIndex: 101,
          background: 'transparent',
        }}
        onMouseEnter={() => window.dispatchEvent(new Event('showNavbar'))}
      />
      <Router>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/login" element={<Login />} />
          <Route path="/admin" element={<AdminLogin />} />
          <Route path="/admin-dashboard" element={<AdminDashboard />} />
          <Route path="/user-dashboard" element={<UserDashboard />} />
          <Route path="/teacher-dashboard" element={<TeacherDashboard />} />
          <Route path="/register" element={<Register />} />
          <Route path="/explainTest" element={<ExplainTest />} />
          <Route path="/courses" element={<CoursesPage />} />
          <Route path="/home" element={<HomePage />} />
          <Route path="/about" element={<About />} />
          <Route path="/faq" element={<FAQ />} />
          <Route path="/api-test" element={<ApiTest />} />
          
        </Routes>
      </Router>

      
      <ChatBotPopup />
      
    </>
  );
}

export default App;
