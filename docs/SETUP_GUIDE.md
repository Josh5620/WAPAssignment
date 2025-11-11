# Project Setup Guide

## For New Team Members

### Prerequisites
- .NET 9.0 SDK
- Node.js (v18 or higher)
- PostgreSQL (or SQL Server)
- Git

### Initial Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/Josh5620/WAPAssignment.git
cd WAPAssignment
```

#### 2. Backend Setup

**Navigate to the backend directory:**
```bash
cd server/ProjectAPI
```

**Update the connection string in `appsettings.json`:**
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "YOUR_DATABASE_CONNECTION_STRING"
  }
}
```

**Run migrations to create the database schema:**
```bash
dotnet ef database update
```

**Start the backend server:**
```bash
dotnet run
```

The backend will be available at: `https://localhost:7046` or `http://localhost:5046`

#### 3. Frontend Setup

**Navigate to the frontend directory:**
```bash
cd client
```

**Install dependencies:**
```bash
npm install
```

**Start the frontend development server:**
```bash
npm run dev
```

The frontend will be available at: `http://localhost:5173` (or 5174 if 5173 is in use)

#### 4. Seed Test Data

**Option A: Using the API endpoint (Recommended)**

Once both servers are running, you can seed test data by:

1. Opening your browser to `http://localhost:5173`
2. Navigate to `/test` or use the API Test page
3. Click the "Seed Database" button

**Option B: Using a REST client (Postman, Thunder Client, etc.)**

Send a POST request to:
```
POST http://localhost:5046/api/TestData/seed
```

**Option C: Using PowerShell/Terminal**

```powershell
Invoke-WebRequest -Uri "http://localhost:5046/api/TestData/seed" -Method POST
```

Or using curl:
```bash
curl -X POST http://localhost:5046/api/TestData/seed
```

### Test Accounts

After seeding, you can log in with these accounts:

**Admin Account:**
- Email: `admin@codesage.com`
- Password: `Admin123!`

**Teacher Account:**
- Email: `teacher@codesage.com`
- Password: `Teacher123!`

**Student Account:**
- Email: `student@codesage.com`
- Password: `Student123!`

### Common Issues

#### Database Connection Issues
- Verify your connection string is correct
- Ensure your database server is running
- Check firewall settings

#### Port Already in Use
- Frontend: The dev server will automatically try the next available port
- Backend: Stop any existing `ProjectAPI.exe` processes:
  ```powershell
  Get-Process -Name "ProjectAPI" | Stop-Process -Force
  ```

#### Migration Issues
- If migrations fail, ensure your database is accessible
- You may need to delete the database and recreate it:
  ```bash
  dotnet ef database drop
  dotnet ef database update
  ```

### Project Structure

```
WAPAssignment/
├── client/                 # React frontend
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── pages/         # Page components
│   │   ├── services/      # API services
│   │   ├── styles/        # CSS files
│   │   └── contexts/      # React contexts
│   └── package.json
│
├── server/                # ASP.NET Core backend
│   └── ProjectAPI/
│       ├── Controllers/   # API endpoints
│       ├── Models/        # Database models
│       ├── Data/          # DbContext
│       ├── Migrations/    # EF Core migrations
│       └── appsettings.json
│
└── docs/                  # Documentation
```

### API Documentation

Main API endpoints:

- **Auth**: `/api/auth/` - Login, Register, Profile
- **Admin**: `/api/admin/` - Admin dashboard and management
- **Students**: `/api/students/` - Student features
- **Teachers**: `/api/teachers/` - Teacher features
- **Guests**: `/api/guests/` - Public access features
- **Test Data**: `/api/TestData/seed` - Seed test data

### Development Workflow

1. **Backend changes**: Restart the `dotnet run` command
2. **Frontend changes**: Vite hot-reloads automatically
3. **Database schema changes**: 
   - Create migration: `dotnet ef migrations add YourMigrationName`
   - Apply migration: `dotnet ef database update`

### Need Help?

- Check existing issues on GitHub
- Review the API documentation in `/docs`
- Check console logs for error details

---

**Last Updated**: November 11, 2025
