import React from 'react';
import Navbar from '../components/Navbar';
import GardenPath from '../components/GardenPath.jsx';
import PrimaryButton from '../components/PrimaryButton';
import { gardenPathData } from '../data/curriculum.js';
import '../styles/VisitorPage.css';

const VisitorPage = () => {
  return (
    <>
      <Navbar />
      <main className="learn-page">
        <section className="learn-header">
          <h1>The Python Path</h1>
          <p>
            Follow the serpent through the garden. Each chapter unlocks a new layer of understanding.
          </p>
        </section>

        <section className="curriculum-map">
          <h2>Your Journey</h2>
          <GardenPath chapters={gardenPathData.slice(0, 8)} progress={null} />
        </section>

        <section className="how-we-teach">
          <h2>How We Teach</h2>
          <div className="teach-methods-grid">
            <div className="method-card">
              <h3>Story First</h3>
              <p>
                Lessons are written as chapters. You’re not just reading syntax — you’re following a journey.
              </p>
            </div>
            <div className="method-card">
              <h3>Experiment As You Go</h3>
              <p>
                Run real Python instantly in the page. Break things safely. (Coming Soon!)
              </p>
            </div>
            <div className="method-card">
              <h3>Grow Visible Progress</h3>
              <p>
                Watch your garden path grow as you master each concept, just like this map.
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

export default VisitorPage;
