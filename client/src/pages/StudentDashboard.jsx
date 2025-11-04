import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import PathCard from '../components/PathCard';
import '../styles/StudentDashboard.css';

/*
 * This is the main "Python Garden" dashboard for a logged-in student.
 * It displays their progress on the "Garden Path".
 */

const gardenPathData = [
  {
    id: 1,
    icon: '🌱',
    level: 'Seedling Path',
    title: 'Chapter 1: Planting Your First Seed',
    topics: ['What is Python?', 'Running your first line of code.'],
    gridClass: 'chapter-1',
  },
  {
    id: 2,
    icon: '🌱',
    level: 'Seedling Path',
    title: 'Chapter 2: Variables',
    topics: ['Storing data', 'Strings, Numbers, Booleans.'],
    gridClass: 'chapter-2',
  },
  {
    id: 3,
    icon: '🌱',
    level: 'Seedling Path',
    title: 'Chapter 3: Data Types',
    topics: ['Lists, Dictionaries', 'Organizing your data.'],
    gridClass: 'chapter-3',
  },
  {
    id: 4,
    icon: '🌿',
    level: 'Sprout Path',
    title: 'Chapter 4: Conditionals',
    topics: ['If/Else logic', 'Making decisions.'],
    gridClass: 'chapter-4',
  },
  {
    id: 5,
    icon: '🌿',
    level: 'Sprout Path',
    title: 'Chapter 5: Loops',
    topics: ['For Loops', 'While Loops', 'Repeating tasks.'],
    gridClass: 'chapter-5',
  },
  {
    id: 6,
    icon: '🌿',
    level: 'Sprout Path',
    title: 'Chapter 6: Functions',
    topics: ['Creating reusable code', 'Parameters & Arguments.'],
    gridClass: 'chapter-6',
  },
  {
    id: 7,
    icon: '🌳',
    level: 'Canopy Path',
    title: 'Chapter 7: File Handling',
    topics: ['Reading from files', 'Writing to files.'],
    gridClass: 'chapter-7',
  },
  {
    id: 8,
    icon: '🌳',
    level: 'Canopy Path',
    title: 'Chapter 8: OOP Basics',
    topics: ['Classes & Objects', 'Understanding `self`.'],
    gridClass: 'chapter-8',
  },
  {
    id: 9,
    icon: '🌳',
    level: 'Canopy Path',
    title: 'Chapter 9: Modules',
    topics: ['Importing code', 'Using libraries like `math`.'],
    gridClass: 'chapter-9',
  },
  {
    id: 10,
    icon: '🌳',
    level: 'Canopy Path',
    title: 'Chapter 10: Final Project',
    topics: ['Build a complete garden app!'],
    gridClass: 'chapter-10',
  },
];

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

  const getChapterStatusClass = (chapterId) => {
    if (progress.completedChapterIds.includes(chapterId)) {
      return 'is-completed';
    }
    if (chapterId === progress.currentChapterId) {
      return 'is-current';
    }
    if (chapterId > progress.currentChapterId) {
      return 'is-locked';
    }
    return '';
  };

  const handleChapterClick = (chapterId) => {
    const status = getChapterStatusClass(chapterId);
    if (status === 'is-locked') {
      alert("You haven't unlocked this chapter yet!");
      return;
    }
    navigate(`/courses/python-basics/view`);
  };

  if (loading) {
    return <div>Loading your garden...</div>;
  }

  return (
    <>
      <Navbar />
      <TestingNav />
      <main className="student-dashboard-page">
        <section className="student-dashboard-header">
          <h1>Your Garden</h1>
          <p>
            Welcome back, student. Pick up where you left off and continue your
            journey.
          </p>
        </section>

        <div className="garden-path-grid">
          {gardenPathData.map((chapter) => {
            const statusClass = getChapterStatusClass(chapter.id);
            return (
              <div
                key={chapter.id}
                className={`${chapter.gridClass} path-card-wrapper ${statusClass}`}
                onClick={() => handleChapterClick(chapter.id)}
              >
                <PathCard
                  icon={chapter.icon}
                  level={chapter.level}
                  title={chapter.title}
                  topics={chapter.topics}
                />
              </div>
            );
          })}
        </div>
      </main>
    </>
  );
};

export default StudentDashboard;
