import PathCard from './PathCard';

const GardenPath = ({ chapters, progress, onChapterClick }) => {
  const completedChapters = progress?.completedChapterIds ?? [];
  const currentChapterId = progress?.currentChapterId ?? null;

  const getChapterStatusClass = (chapterId) => {
    if (!progress) {
      return '';
    }
    if (completedChapters.includes(chapterId)) {
      return 'is-completed';
    }
    if (chapterId === currentChapterId) {
      return 'is-current';
    }
    if (currentChapterId && chapterId > currentChapterId) {
      return 'is-locked';
    }
    return '';
  };

  return (
    <div className="garden-path-grid">
      {chapters.map((chapter) => {
        const statusClass = getChapterStatusClass(chapter.id);
        const handleClick = () => {
          if (onChapterClick) {
            onChapterClick(chapter, statusClass);
          }
        };

        return (
          <div
            key={chapter.id}
            className={[chapter.gridClass, 'path-card-wrapper', statusClass].filter(Boolean).join(' ')}
            onClick={handleClick}
            role={onChapterClick ? 'button' : undefined}
            tabIndex={onChapterClick ? 0 : undefined}
            onKeyDown={(event) => {
              if (!onChapterClick) return;
              if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                onChapterClick(chapter, statusClass);
              }
            }}
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
  );
};

export default GardenPath;
