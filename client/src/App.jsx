import React from 'react';
import { BrowserRouter as Router, Navigate, Route, Routes } from 'react-router-dom';
import { ThemeProvider } from './contexts/ThemeContext';
import Login from './pages/Login';
import HomePage from './pages/HomePage';
import Register from './pages/Register';
import AdminLogin from './pages/AdminLogin';
import AdminDashboard from './pages/AdminDashboard';
import StudentDashboard from './pages/StudentDashboard';
import StudentProfile from './pages/StudentProfile';
import TeacherDashboard from './pages/TeacherDashboard';
import ManageCourse from './pages/ManageCourse';
import TeacherCourseProgress from './pages/TeacherCourseProgress';
import CourseViewerPage from './pages/CourseViewerPage';
import ChatBotPopup from './components/ChatBotPopup';
import ExplainTest from './pages/ExplainTest';
import About from './pages/About';
import ChapterPage from './pages/ChapterPage.jsx';
import CoursesPage from './pages/CoursesPage';
import GuestCoursesPage from './pages/GuestCoursesPage';
import FAQ from './pages/FAQ';
import VisitorPage from './pages/VisitorPage';
import GuestCoursePreviewPage from './pages/GuestCoursePreviewPage';
import ApiTest from './components/ApiTest';
import ProtectedRoute from './components/ProtectedRoute.jsx';
import TestingNav from './components/TestingNav';

function App() {
  console.log('App mounted ✅');
  return (
    <ThemeProvider>
      <Router>
        <TestingNav />
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/home" element={<HomePage />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/admin" element={<AdminLogin />} />
          <Route
            path="/admin-dashboard"
            element={(
              <ProtectedRoute allowedRoles={['admin']}>
                <AdminDashboard />
              </ProtectedRoute>
            )}
          />
          <Route
            path="/student-dashboard"
            element={(
              <ProtectedRoute>
                <StudentDashboard />
              </ProtectedRoute>
            )}
          />
          <Route
            path="/student-profile"
            element={(
              <ProtectedRoute>
                <StudentProfile />
              </ProtectedRoute>
            )}
          />
          <Route
            path="/teacher-dashboard"
            element={(
              <ProtectedRoute allowedRoles={['teacher']}>
                <TeacherDashboard />
              </ProtectedRoute>
            )}
          />
          <Route path="/explainTest" element={<ExplainTest />} />
          <Route path="/courses" element={<CoursesPage />} />
          <Route path="/about" element={<About />} />
          <Route path="/faq" element={<FAQ />} />
          <Route path="/guest/courses" element={<GuestCoursesPage />} />
          <Route path="/guest/courses/:courseId/preview" element={<GuestCoursePreviewPage />} />
          <Route path="/python" element={<VisitorPage />} />
          <Route path="/api-test" element={<ApiTest />} />
          <Route
            path="/teacher/courses/:courseId"
            element={(
              <ProtectedRoute allowedRoles={['teacher']}>
                <ManageCourse />
              </ProtectedRoute>
            )}
          />
          <Route
            path="/teacher/course-progress/:courseId"
            element={(
              <ProtectedRoute allowedRoles={['teacher']}>
                <TeacherCourseProgress />
              </ProtectedRoute>
            )}
          />
          <Route
            path="/courses/:courseId/view"
            element={(
              <ProtectedRoute allowedRoles={['student', 'teacher']}>
                <CourseViewerPage />
              </ProtectedRoute>
            )}
          />
          <Route
            path="/chapters/:chapterId"
            element={(
              <ProtectedRoute allowedRoles={['student', 'teacher', 'admin']}>
                <ChapterPage />
              </ProtectedRoute>
            )}
          />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Router>
      <ChatBotPopup />
    </ThemeProvider>
  );
}

export default App;
