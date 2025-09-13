import { useEffect, useState } from "react";
import { listCourses, createCourse, updateCourse, removeCourse } from "../pagesBack/courseService";
import TestingNav from '../components/TestingNav';

export default function Courses() {
  const [items, setItems] = useState([]);
  const [form, setForm] = useState({ title: "", description: "" });
  const [err, setErr] = useState("");

  const load = async () => {
    try { setItems(await listCourses()); } catch (e) { setErr(e.message); }
  };

  useEffect(() => { load(); }, []);

  const onCreate = async (e) => {
    e.preventDefault();
    if (!form.title.trim()) return setErr("Title is required");
    try {
      const row = await createCourse({ title: form.title.trim(), description: form.description || null });
      setItems((p) => [row, ...p]);
      setForm({ title: "", description: "" });
    } catch (e) { setErr(e.message); }
  };

  const onBlurUpdate = async (id, field, value) => {
    try { await updateCourse(id, { [field]: value || null }); }
    catch (e) { setErr(e.message); load(); }
  };

  const onDelete = async (id) => {
    if (!confirm("Delete this course?")) return;
    try { await removeCourse(id); setItems((p) => p.filter((x) => x.id !== id)); }
    catch (e) { setErr(e.message); }
  };

  return (
    <div style={{ maxWidth: 720, margin: "2rem auto", padding: "1rem" }}>
      <TestingNav />
      <h1>Courses</h1>

      <form onSubmit={onCreate} style={{ margin: "1rem 0" }}>
        <input
          placeholder="Title (required)"
          value={form.title}
          onChange={(e) => setForm({ ...form, title: e.target.value })}
          required
        />
        <textarea
          placeholder="Description"
          value={form.description}
          onChange={(e) => setForm({ ...form, description: e.target.value })}
        />
        <div><button type="submit">Create</button></div>
      </form>

      {err && <p style={{ color: "crimson" }}>{err}</p>}

      <ul style={{ listStyle: "none", padding: 0 }}>
        {items.map((c) => (
          <li key={c.id} style={{ border: "1px solid #ddd", padding: "0.75rem", borderRadius: 8, marginBottom: "0.75rem" }}>
            <input
              value={c.title || ""}
              onChange={(e) => setItems((p) => p.map((x) => x.id === c.id ? { ...x, title: e.target.value } : x))}
              onBlur={(e) => onBlurUpdate(c.id, "title", e.target.value.trim())}
              style={{ width: "100%", fontWeight: 600, marginBottom: 6 }}
            />
            <textarea
              value={c.description || ""}
              onChange={(e) => setItems((p) => p.map((x) => x.id === c.id ? { ...x, description: e.target.value } : x))}
              onBlur={(e) => onBlurUpdate(c.id, "description", e.target.value.trim())}
              rows={3}
              style={{ width: "100%", marginBottom: 6 }}
            />
            <small style={{ color: "#666" }}>
              {c.created_at ? new Date(c.created_at).toLocaleString() : ""}
            </small>
            <div><button onClick={() => onDelete(c.id)} style={{ marginTop: 8 }}>Delete</button></div>
          </li>
        ))}
      </ul>
    </div>
  );
}
