# Teacher Features Implementation Notes

> **Scope:** Internal documentation for developers working on the CodeSage teacher experience. This file is ignored by Git so that contributors can extend it with personal notes without polluting commits.

## Teacher Dashboard (`client/src/pages/TeacherDashboard.jsx`)
- **Course loading**
  - `teacherCourseService.listMyCourses()` fetches the authenticated teacher's catalogue.
  - When the API responds successfully, the raw server payload is used.
  - If the request fails with a server-side error (HTTP 5xx) or a network fault, the service now returns curated fallback courses from `client/src/data/teacherFallbackData.js`. This keeps the UI populated and exercises all dashboard paths even when the backend is unavailable.
- **Course creation**
  - `teacherCourseService.createCourse(payload)` posts a new draft using the authenticated token.
  - After creation, the dashboard reloads the catalogue and redirects to the new (or best-effort) course management page.
- **Course deletion**
  - `teacherCourseService.deleteCourse(courseId)` issues a `DELETE /Courses/{id}` call after the user confirms.
- **Navigation shortcuts**
  - “Manage” opens the teacher management surface (`/teacher/courses/:courseId`).
  - “Preview” opens the public course viewer so teachers can see the learner-facing view.

## Course Management (`client/src/pages/ManageCourse.jsx`)
- **Course detail**
  - Uses `teacherCourseService.getCourse(courseId)` to populate metadata.
  - On 5xx/network errors, the service returns the fallback version of the requested course (if available) so the page can still render titles, descriptions, and chapter counts.
- **Chapter operations**
  - `chapterManagementService.list(courseId)` retrieves chapters. Fallback chapters mirror the sample catalogue so teachers can practise ordering, editing, and deletion offline.
  - `chapterManagementService.create/update/delete` proxy to the API. These still surface errors to the UI if the backend is unreachable because they mutate data.
- **Resource operations**
  - `resourceManagementService.list(chapterId)` populates the resource table. Fallback HTML/link samples are delivered when the server cannot respond.
  - `resourceManagementService.create/update/delete` call the API directly.
- **Resource editing UX**
  - Simplified prompts enable rapid iteration when the backend responds successfully.

## Shared Services (`client/src/services/apiService.js`)
- Centralizes authenticated fetch logic through `requestWithAuth` (adds bearer tokens, handles JSON parsing, clears auth on 401s).
- The helper `isServerError(error)` standardises detection of server/network failures so only those scenarios trigger fallback data.
- The exported `teacherCourseService`, `chapterManagementService`, and `resourceManagementService` now bridge to `client/src/data/teacherFallbackData.js` for read-only operations when the API is down.

## Fallback Data (`client/src/data/teacherFallbackData.js`)
- Contains two representative courses:
  1. **Sample Full-Stack Foundations** – demonstrates full platform flow with three chapters and multiple resource types.
  2. **Sample React Refresh** – a lighter course used to showcase iteration workflows.
- Helper selectors (`getFallbackTeacherCourses`, `getFallbackTeacherCourseById`, `getFallbackChaptersForCourse`, `getFallbackResourcesForChapter`) clone data before returning it so callers never mutate the base templates.
- Designed to cover the UI states that teachers should validate: catalogue listing, chapter sequencing, and resource rendering.

## Testing Recommendations
- Exercise the dashboard with and without the API available to confirm fallback behaviour.
- Use the sample data to walk through chapter/resource management flows without needing the server locally.
- When the backend returns, verify that live data supersedes the fallback list automatically.
