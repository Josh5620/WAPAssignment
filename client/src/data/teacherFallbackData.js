export const fallbackTeacherCourses = [
  {
    id: 'sample-fullstack-foundations',
    title: 'Sample Full-Stack Foundations',
    description:
      'Build an end-to-end understanding of modern web applications with guided examples that mirror the production platform.',
    level: 'Intermediate',
    tags: ['JavaScript', 'React', 'ASP.NET Core'],
    chapters: [
      {
        id: 'sample-fullstack-1',
        courseId: 'sample-fullstack-foundations',
        number: 1,
        title: 'Project Overview & Goals',
        summary: 'Discover how CodeSage structures projects, plans deliverables, and measures student success.',
        resources: [
          {
            id: 'sample-fullstack-1-r1',
            chapterId: 'sample-fullstack-1',
            type: 'text',
            content:
              '<p>This chapter introduces the overall goals for full-stack learning paths and how teachers can monitor progress.</p>',
          },
          {
            id: 'sample-fullstack-1-r2',
            chapterId: 'sample-fullstack-1',
            type: 'link',
            content: 'https://codesage.example.com/resources/teacher-onboarding',
          },
        ],
      },
      {
        id: 'sample-fullstack-2',
        courseId: 'sample-fullstack-foundations',
        number: 2,
        title: 'Frontend Experience Walkthrough',
        summary: 'Step through the learner-facing React app and highlight the tools available to course creators.',
        resources: [
          {
            id: 'sample-fullstack-2-r1',
            chapterId: 'sample-fullstack-2',
            type: 'text',
            content: '<p>Explore reusable UI modules, dynamic routing, and progress tracking from the student perspective.</p>',
          },
        ],
      },
      {
        id: 'sample-fullstack-3',
        courseId: 'sample-fullstack-foundations',
        number: 3,
        title: 'Back-End Integration',
        summary: 'Demonstrate how chapters and resources are persisted through the ASP.NET Core API.',
        resources: [
          {
            id: 'sample-fullstack-3-r1',
            chapterId: 'sample-fullstack-3',
            type: 'text',
            content:
              '<p>Review controller endpoints, authorization expectations, and typical responses the dashboard consumes.</p>',
          },
        ],
      },
    ],
  },
  {
    id: 'sample-react-refresh',
    title: 'Sample React Refresh',
    description:
      'A quick refresher course that highlights how teachers can iterate on and publish new course revisions.',
    level: 'Beginner',
    tags: ['React', 'Components'],
    chapters: [
      {
        id: 'sample-react-refresh-1',
        courseId: 'sample-react-refresh',
        number: 1,
        title: 'Refreshing Component Patterns',
        summary: 'Walk through component-driven development and preview updates instantly.',
        resources: [
          {
            id: 'sample-react-refresh-1-r1',
            chapterId: 'sample-react-refresh-1',
            type: 'text',
            content: '<p>Review hooks usage and how state updates flow through the teacher preview.</p>',
          },
        ],
      },
      {
        id: 'sample-react-refresh-2',
        courseId: 'sample-react-refresh',
        number: 2,
        title: 'Publishing Updates',
        summary: 'Understand approval workflows and impact analysis before students see changes.',
        resources: [
          {
            id: 'sample-react-refresh-2-r1',
            chapterId: 'sample-react-refresh-2',
            type: 'link',
            content: 'https://codesage.example.com/resources/publishing-checklist',
          },
        ],
      },
    ],
  },
];

const cloneChapter = ({ resources, ...chapter }) => ({ ...chapter });

const cloneCourse = (course) => ({
  ...course,
  chapterCount: course.chapterCount ?? course.chapters.length,
  chapters: course.chapters.map(cloneChapter),
});

export const getFallbackTeacherCourses = () => fallbackTeacherCourses.map(cloneCourse);

export const getFallbackTeacherCourseById = (courseId) => {
  if (!courseId) return null;
  const normalized = courseId.toString().toLowerCase();
  const match = fallbackTeacherCourses.find((course) => course.id.toString().toLowerCase() === normalized);
  return match ? cloneCourse(match) : null;
};

export const getFallbackChaptersForCourse = (courseId) => {
  const course = getFallbackTeacherCourseById(courseId);
  return course?.chapters?.map(({ resources, ...chapter }) => ({ ...chapter })) ?? [];
};

export const getFallbackResourcesForChapter = (chapterId) => {
  if (!chapterId) return [];
  const normalized = chapterId.toString().toLowerCase();
  for (const course of fallbackTeacherCourses) {
    for (const chapter of course.chapters) {
      if (chapter.id.toString().toLowerCase() === normalized) {
        return (chapter.resources ?? []).map((resource) => ({ ...resource }));
      }
    }
  }
  return [];
};
