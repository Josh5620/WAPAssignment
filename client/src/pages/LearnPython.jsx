import React from 'react';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import PathCard from '../components/PathCard';
import PrimaryButton from '../components/PrimaryButton';
import '../styles/LearnPython.css';

/*
 * The /learn page for "Python Garden".
 * Shows the curriculum map based on the user's sketch.
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
    title: 'Chapter 8: First Project',
    topics: ['Building a simple application.'],
    gridClass: 'chapter-8',
  },
];

const LearnPython = () => {
  return (
    <>
      <Navbar />
      <TestingNav />
      <main className="learn-page">
        <section className="learn-header">
          <h1>The Python Path</h1>
          <p>
            Follow the serpent through the garden. Each chapter unlocks a new
            layer of understanding.
          </p>
        </section>

        <section className="curriculum-map">
          <h2>Your Journey</h2>
          <div className="garden-path-grid">
            {gardenPathData.map((chapter) => (
              <div key={chapter.id} className={chapter.gridClass}>
                <PathCard
                  icon={chapter.icon}
                  level={chapter.level}
                  title={chapter.title}
                  topics={chapter.topics}
                />
              </div>
            ))}
          </div>
        </section>

        <section className="how-we-teach">
          <h2>How We Teach</h2>
          <div className="teach-methods-grid">
            <div className="method-card">
              <h3>Story First</h3>
              <p>
                Lessons are written as chapters. You’re not just reading syntax
                — you’re following a journey.
              </p>
            </div>
            <div className="method-card">
              <h3>Experiment As You Go</h3>
              <p>
                Run real Python instantly in the page. Break things safely.
                (Coming Soon!)
              </p>
            </div>
            <div className="method-card">
              <h3>Grow Visible Progress</h3>
              <p>
                Watch your garden path grow as you master each concept,
                just like this map.
              </p>
            </div>
          </div>
        </section>

        <section className="learn-cta">
          <PrimaryButton to="/register">Start Seedling Path</PrimaryButton>
        </section>
      </main>
    </>
  );
};

export default LearnPython;
