import React, { useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import GuestCoursePreview from '../components/GuestCoursePreview';

const GuestCoursePreviewPage = () => {
  const navigate = useNavigate();
  const { courseId } = useParams();
  const isLoggedIn = getUser() !== null;

  // If user is logged in, redirect to full course viewer
  useEffect(() => {
    if (isLoggedIn && courseId) {
      navigate(`/courses/${courseId}/view`, { replace: true });
    }
  }, [isLoggedIn, courseId, navigate]);

  if (isLoggedIn) {
    return null; // Will redirect
  }

  return (
    <>
      <Navbar />
      <TestingNav />
      <GuestCoursePreview />
    </>
  );
};

export default GuestCoursePreviewPage;

