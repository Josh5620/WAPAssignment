import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { ThemeProvider } from './contexts/ThemeContext';
import Login from "./pages/Login";
import HomePage from "./pages/HomePage";
import Register from "./pages/Register";
import AdminLogin from "./pages/AdminLogin";
import AdminDashboard from "./pages/AdminDashboard";
import StudentDashboard from "./pages/StudentDashboard";
import StudentProfile from "./pages/StudentProfile";
import TeacherDashboard from "./pages/TeacherDashboard";
import ManageCourse from "./pages/ManageCourse";
import TeacherCourseProgress from "./pages/TeacherCourseProgress";
import CourseViewerPage from "./pages/CourseViewerPage";
import ChatBotPopup from "./components/ChatBotPopup";
import ThemeSelector from "./components/ThemeSelector";
import ExplainTest from "./pages/ExplainTest";
import About from "./pages/About";
import GuestAbout from "./pages/GuestAbout";
import CoursesPage from "./pages/CoursesPage";
import GuestCoursesPage from "./pages/GuestCoursesPage";
import FAQ from "./pages/FAQ";
import GuestFAQ from "./pages/GuestFAQ";
import VisitorPage from "./pages/VisitorPage";
import GuestCoursePreviewPage from "./pages/GuestCoursePreviewPage";
import ApiTest from './components/ApiTest';
import { isTeacher } from './utils/auth';

const RequireTeacher = ({ children }) => {
  if (!isTeacher()) {
    return <Navigate to="/login" replace />;
  }
  return children;
};

function App() {
  console.log("App mounted ✅");
  return (
    <ThemeProvider>
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
      <div
        style={{
          position: 'fixed',
          bottom: '20px',
          right: '20px',
          zIndex: 2000,
        }}
      >
        <ThemeSelector />
      </div>
      <Router>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/login" element={<Login />} />
          <Route path="/admin" element={<AdminLogin />} />
          <Route path="/admin-dashboard" element={<AdminDashboard />} />
          <Route path="/student-dashboard" element={<StudentDashboard />} />
          <Route path="/student-profile" element={<StudentProfile />} />
          <Route
            path="/teacher-dashboard"
            element={(
              <RequireTeacher>
                <TeacherDashboard />
              </RequireTeacher>
            )}
          />
          <Route path="/register" element={<Register />} />
          <Route path="/explainTest" element={<ExplainTest />} />
          <Route path="/courses" element={<CoursesPage />} />
          <Route path="/home" element={<HomePage />} />
          <Route path="/about" element={<About />} />
          <Route path="/guest/about" element={<GuestAbout />} />
          <Route path="/faq" element={<FAQ />} />
          <Route path="/guest/faq" element={<GuestFAQ />} />
          <Route path="/guest/courses" element={<GuestCoursesPage />} />
          <Route path="/guest/courses/:courseId/preview" element={<GuestCoursePreviewPage />} />
          <Route path="/python" element={<VisitorPage />} />
          <Route path="/api-test" element={<ApiTest />} />
          <Route
            path="/teacher/courses/:courseId"
            element={(
              <RequireTeacher>
                <ManageCourse />
              </RequireTeacher>
            )}
          />
          <Route
            path="/teacher/course-progress/:courseId"
            element={(
              <RequireTeacher>
                <TeacherCourseProgress />
              </RequireTeacher>
            )}
          />
          <Route
            path="/courses/:courseId/view"
            element={(

                <CourseViewerPage />
            )}
          />
        </Routes>
      </Router>

      <ChatBotPopup />
    </ThemeProvider>
  );
}

export default App;
