# CodeSage - Learning Management System

A comprehensive learning management system built with React and ASP.NET Core.

## Quick Start

### 1. Setup Database
```bash
cd server/ProjectAPI
dotnet ef database update
```

### 2. Start Backend
```bash
cd server/ProjectAPI
dotnet run
```

### 3. Start Frontend
```bash
cd client
npm install
npm run dev
```

### 4. Seed Test Data
After both servers are running, seed the database by sending a POST request to:
```
POST http://localhost:5046/api/TestData/seed
```

Or use PowerShell:
```powershell
Invoke-WebRequest -Uri "http://localhost:5046/api/TestData/seed" -Method POST
```

## Test Accounts

After seeding:
- **Admin**: `admin@codesage.com` / `Admin123!`
- **Teacher**: `teacher@codesage.com` / `Teacher123!`
- **Student**: `student@codesage.com` / `Student123!`

## Documentation

See [SETUP_GUIDE.md](./docs/SETUP_GUIDE.md) for detailed setup instructions.

## Tech Stack

- **Frontend**: React 18, Vite, React Router
- **Backend**: ASP.NET Core 9.0, Entity Framework Core
- **Database**: SQL Server / PostgreSQL
- **Authentication**: JWT Bearer tokens

## Project Structure

- `/client` - React frontend application
- `/server/ProjectAPI` - ASP.NET Core Web API
- `/docs` - Project documentation

## Features

- ✅ Role-based authentication (Admin, Teacher, Student)
- ✅ Course management and enrollment
- ✅ Interactive learning content (videos, quizzes, flashcards)
- ✅ Progress tracking and leaderboards
- ✅ Community forum
- ✅ Admin dashboard for system management
- ✅ Teacher dashboard for course creation
- ✅ Student dashboard with personalized learning path

---

**Version**: 1.0.0  
**Last Updated**: November 11, 2025
