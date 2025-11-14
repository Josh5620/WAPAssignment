import React, { useEffect, useState } from 'react';
import { adminService } from '../services/apiService';
import '../styles/StudentRoster.css';

const normalizeStudents = (payload) => {
  if (!payload) return [];
  const data = payload?.data ?? payload;
  if (Array.isArray(data)) return data;
  if (Array.isArray(data?.students)) return data.students;
  if (Array.isArray(data?.results)) return data.results;
  return [];
};

const StudentRoster = () => {
  const [students, setStudents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    let isMounted = true;

    const fetchStudents = async () => {
      setLoading(true);
      try {
        if (typeof adminService.getAllUsers !== 'function') {
          throw new Error('adminService.getAllUsers is not available in this environment.');
        }
        const response = await adminService.getAllUsers();
        if (response?.success === false) {
          throw new Error(response?.message || 'Unable to load students right now.');
        }
        if (!isMounted) return;
        const list = normalizeStudents(response);
        setStudents(list);
        setError('');
      } catch (err) {
        if (!isMounted) return;
        console.error('Failed to load student roster', err);
        setError(err.message || 'Unable to load students right now.');
        setStudents([]);
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    };

    fetchStudents();

    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <div className="roster-card">
      <header className="roster-header">
        <h2>Student Roster</h2>
        <p>These students are fetched from the live admin service.</p>
      </header>

      {error && <div className="roster-status roster-status--error">{error}</div>}
      {loading ? (
        <div className="roster-status">Loading students...</div>
      ) : (
        <div className="roster-table-wrapper">
          <table className="roster-table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
              </tr>
            </thead>
            <tbody>
              {students.length === 0 ? (
                <tr>
                  <td colSpan="3" className="roster-empty">No students found in the admin service.</td>
                </tr>
              ) : (
                students.map((student) => {
                  const fullName =
                    student.fullName ||
                    student.full_name ||
                    student.name ||
                    `${student.firstName ?? ''} ${student.lastName ?? ''}`.trim() ||
                    'Unnamed Student';

                  const email = student.email || student.Email || 'No email provided';

                  return (
                    <tr key={student.id || student.Id || student.userId || email}>
                      <td data-label="Name">{fullName}</td>
                      <td data-label="Email">{email}</td>
                      <td data-label="Role">{student.role || '—'}</td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default StudentRoster;
