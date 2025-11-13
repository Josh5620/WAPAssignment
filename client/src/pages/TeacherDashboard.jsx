import React, { useMemo, useState } from 'react';
import Navbar from '../components/Navbar';
import StudentRoster from '../components/StudentRoster';
import TeacherForumManager from '../components/TeacherForumManager';
import TeacherFeedbackQueue from '../components/TeacherFeedbackQueue';
import '../styles/TeacherDashboard.css';

const TAB_CONFIG = {
  roster: {
    label: 'Student Roster',
    tagline: 'View the real-time roster pulled from the admin portal.',
  },
  forum: {
    label: 'Student Forum',
    tagline: 'Simulated forum threads to practice guiding discussions.',
  },
  help: {
    label: 'Help Queue',
    tagline: 'Work through a simulated help queue to keep momentum thriving.',
  },
};

const TeacherDashboard = () => {
  const [activeTab, setActiveTab] = useState('roster');

  const activeTagline = useMemo(() => TAB_CONFIG[activeTab]?.tagline ?? '', [activeTab]);

  const renderActivePanel = () => {
    switch (activeTab) {
      case 'forum':
        return <TeacherForumManager />;
      case 'help':
        return <TeacherFeedbackQueue />;
      case 'roster':
      default:
        return <StudentRoster />;
    }
  };

  return (
    <>
      <Navbar />
      <main className="teacher-dashboard" aria-labelledby="teacher-dashboard-heading">
        <header className="dashboard-header">
          <div className="dashboard-heading-group">
            <h1 id="teacher-dashboard-heading">Teacher Garden Hub</h1>
            <p className="dashboard-subtitle">
              Cultivate your classroom ecosystem with real rosters and simulated practice tools.
            </p>
          </div>
          <p className="dashboard-tagline">{activeTagline}</p>
        </header>

        <nav className="td-tabs" role="tablist" aria-label="Teacher dashboard views">
          {Object.entries(TAB_CONFIG).map(([id, { label }]) => (
            <button
              key={id}
              type="button"
              role="tab"
              aria-selected={activeTab === id}
              className={`td-tab ${activeTab === id ? 'td-tab--active' : ''}`}
              onClick={() => setActiveTab(id)}
            >
              {label}
            </button>
          ))}
        </nav>

        <section className="td-panel" role="tabpanel">
          {renderActivePanel()}
        </section>
      </main>
    </>
  );
};

export default TeacherDashboard;
