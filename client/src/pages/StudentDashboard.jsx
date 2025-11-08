import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import GardenPath from '../components/GardenPath.jsx';
import { gardenPathData } from '../data/curriculum.js';
import '../styles/StudentDashboard.css';

const StudentDashboard = () => {
  const navigate = useNavigate();
  const [progress] = useState({
    completedChapterIds: [1, 2],
    currentChapterId: 3,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(false);
  }, []);

  const handleChapterSelection = (chapter, status) => {
    if (status === 'is-locked') {
      alert("You haven't unlocked this chapter yet!");
      return;
    }
    navigate('/courses/python-basics/view', { state: { chapterId: chapter.id } });
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
          <p>
            Welcome back, student. Pick up where you left off and continue your journey.
          </p>
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
