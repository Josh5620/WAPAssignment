# CodeSage Test Accounts

## Quick Reference
Here are all the test accounts available in your CodeSage application:

## 👨‍💼 Administrator Accounts
| Email | Password | Full Name | Role |
|-------|----------|-----------|------|
| `admin@codesage.com` | `admin123` | Admin User | admin |
| `sarah.admin@codesage.com` | `password123` | Sarah Administrator | admin |

## 👨‍🏫 Teacher Accounts
| Email | Password | Full Name | Role |
|-------|----------|-----------|------|
| `teacher@codesage.com` | `teacher123` | Dr. Michael Johnson | teacher |
| `emily.chen@codesage.com` | `password123` | Prof. Emily Chen | teacher |
| `david.teacher@codesage.com` | `teacher456` | David Rodriguez | teacher |

## 👨‍🎓 Student Accounts
| Email | Password | Full Name | Role |
|-------|----------|-----------|------|
| `student@codesage.com` | `student123` | John Student | student |
| `alice.student@codesage.com` | `password123` | Alice Williams | student |
| `bob.smith@codesage.com` | `student456` | Bob Smith | student |
| `emma.t@codesage.com` | `emma123` | Emma Thompson | student |
| `carlos.m@codesage.com` | `carlos789` | Carlos Martinez | student |
| `sophia.lee@codesage.com` | `sophia321` | Sophia Lee | student |
| `james.w@codesage.com` | `james654` | James Wilson | student |

## 🔧 How to Load These Accounts

### Option 1: Use API Test Page
1. Go to `http://localhost:5173/api-test`
2. Click **"Seed Test Data"** button
3. All accounts will be created automatically

### Option 2: Use Swagger UI
1. Go to `http://localhost:5245/swagger`
2. Find **TestData** section
3. Use **POST /api/TestData/seed** endpoint

### Option 3: Direct API Call
```bash
curl -X POST "http://localhost:5245/api/TestData/seed" -H "Content-Type: application/json"
```

## 🎯 Testing Different User Roles

### Test as Administrator
- Login with: `admin@codesage.com` / `admin123`
- Should redirect to admin dashboard
- Can manage users and courses

### Test as Teacher
- Login with: `teacher@codesage.com` / `teacher123`
- Should redirect to teacher dashboard
- Can create and manage course content

### Test as Student
- Login with: `student@codesage.com` / `student123`
- Should redirect to student dashboard
- Can enroll in courses and access learning materials

## 📊 Account Statistics
- **Total Accounts**: 12
- **Administrators**: 2
- **Teachers**: 3
- **Students**: 7
- **Password Security**: All passwords use BCrypt hashing
- **Creation Dates**: Staggered over the past 30 days for realistic data

## 🔐 Security Features
- All passwords are securely hashed using BCrypt
- Role-based access control implemented
- Email-based authentication
- Session management with JWT-compatible tokens

## 💡 Tips for Testing
1. **Different Passwords**: Accounts use various passwords to test different login scenarios
2. **Role Testing**: Try logging in with different roles to test role-based features
3. **User Management**: Use admin accounts to test user management features
4. **Course Creation**: Use teacher accounts to test course creation and management

---

**Note**: These are test accounts for development purposes. In production, implement proper user registration and password policies.