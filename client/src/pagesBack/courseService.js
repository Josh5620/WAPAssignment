const API_URL = "http://localhost:5245/api";

async function handle(res) {
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  const ct = res.headers.get("content-type") || "";
  return ct.includes("application/json") ? res.json() : null;
}

export const listCourses = () =>
  fetch(`${API_URL}/api/courses`).then(handle);

export const createCourse = (body) =>
  fetch(`${API_URL}/api/courses`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  }).then(handle);

export const updateCourse = (id, body) =>
  fetch(`${API_URL}/api/courses/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  }).then(handle);

export const removeCourse = (id) =>
  fetch(`${API_URL}/api/courses/${id}`, {
    method: "DELETE",
  }).then(handle);
