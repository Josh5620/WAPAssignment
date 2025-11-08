import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import GardenPath from '../components/GardenPath.jsx';
import { gardenPathData } from '../data/curriculum.js';
import '../styles/StudentDashboard.css';
import { useAuth } from '../context/AuthContext.jsx';

const StudentDashboard = () => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [progress] = useState({
    completedChapterIds: [1, 2],
    currentChapterId: 3,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(false);
  }, []);

  const displayName = useMemo(() => {
    if (!user) return 'student';
    return (
      user.full_name ||
      user.fullName ||
      user.FullName ||
      user.name ||
      user.displayName ||
      'student'
    );
  }, [user]);

  const greeting = useMemo(() => {
    return `Hi ${displayName}, welcome back to your garden!`;
  }, [displayName]);

  const handleChapterSelection = (chapter, status) => {
    if (status === 'is-locked') {
      alert("You haven't unlocked this chapter yet!");
      return;
    }
    navigate(`/chapters/${chapter.id}`);
  };

  if (loading) {
    return <div>Loading your garden...</div>;
  }

  return (
    <>
      <Navbar />
      <main className="student-dashboard-page">
        <section className="student-dashboard-header">
          <h1>Your Garden</h1>
          <p>{greeting}</p>
        </section>

        <GardenPath
          chapters={gardenPathData}
          progress={progress}
          onChapterClick={handleChapterSelection}
        />
      </main>
    </>
  );
};

export default StudentDashboard;
