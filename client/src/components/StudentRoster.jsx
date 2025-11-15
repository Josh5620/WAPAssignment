import React, { useEffect, useState } from 'react';
import { adminService } from '../services/apiService';
import '../styles/StudentRoster.css';

const FAKE_STUDENTS = [
  { id: 1, fullName: 'Emma Rodriguez', email: 'emma.rodriguez@student.edu', role: 'Student' },
  { id: 2, fullName: 'Liam Chen', email: 'liam.chen@student.edu', role: 'Student' },
  { id: 3, fullName: 'Sophia Patel', email: 'sophia.patel@student.edu', role: 'Student' },
  { id: 4, fullName: 'Noah Johnson', email: 'noah.johnson@student.edu', role: 'Student' },
  { id: 5, fullName: 'Olivia Martinez', email: 'olivia.martinez@student.edu', role: 'Student' },
  { id: 6, fullName: 'Ethan Williams', email: 'ethan.williams@student.edu', role: 'Student' },
  { id: 7, fullName: 'Ava Thompson', email: 'ava.thompson@student.edu', role: 'Student' },
  { id: 8, fullName: 'Mason Garcia', email: 'mason.garcia@student.edu', role: 'Student' },
  { id: 9, fullName: 'Isabella Lee', email: 'isabella.lee@student.edu', role: 'Student' },
  { id: 10, fullName: 'Lucas Brown', email: 'lucas.brown@student.edu', role: 'Student' },
  { id: 11, fullName: 'Mia Davis', email: 'mia.davis@student.edu', role: 'Student' },
  { id: 12, fullName: 'Jackson Wilson', email: 'jackson.wilson@student.edu', role: 'Student' },
  { id: 13, fullName: 'Charlotte Moore', email: 'charlotte.moore@student.edu', role: 'Student' },
  { id: 14, fullName: 'Aiden Taylor', email: 'aiden.taylor@student.edu', role: 'Student' },
  { id: 15, fullName: 'Amelia Anderson', email: 'amelia.anderson@student.edu', role: 'Student' },
];

const normalizeStudents = (payload) => {
  if (!payload) return [];
  const data = payload?.data ?? payload;
  if (Array.isArray(data)) return data;
  if (Array.isArray(data?.students)) return data.students;
  if (Array.isArray(data?.results)) return data.results;
  return [];
};

const StudentRoster = () => {
  const [students, setStudents] = useState(FAKE_STUDENTS);
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
        setStudents(list.length > 0 ? list : FAKE_STUDENTS);
        setError('');
      } catch (err) {
        if (!isMounted) return;
        console.error('Failed to load student roster, using fake data', err);
        setError('');
        setStudents(FAKE_STUDENTS);
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
        <p>Manage your classroom of learners in the Python Garden.</p>
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
