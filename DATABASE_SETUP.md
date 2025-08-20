# Database Setup Script for WAPAssignment

## Prerequisites
1. **Supabase Account**: Make sure you have access to your Supabase project
2. **Connection String**: Update the connection strings in appsettings.json files

## Step 1: Update Connection Strings

Replace the placeholder connection strings in these files:
- `server/ProjectAPI/appsettings.json`
- `server/ProjectAPI/appsettings.Development.json`

Replace:
```
"User Id=postgres.YOUR_PROJECT_ID;Password=YOUR_PASSWORD;Server=YOUR_PROJECT_ID.supabase.co;Port=5432;Database=postgres;Pooling=true;"
```

With your actual Supabase connection details:
```
"User Id=postgres.abcdefghijk;Password=your_actual_password;Server=abcdefghijk.supabase.co;Port=5432;Database=postgres;Pooling=true;"
```

## Step 2: Verify Database Tables

Your Supabase database should have these tables:

### profiles table
- id (uuid, primary key)
- login_id (text) - stores email
- password_hash (text) - stores hashed password
- full_name (text)
- role (text) - 'student', 'teacher', or 'admin'
- created_at (timestamptz)

### forum_posts table
- id (int8, primary key)
- author_id (uuid, foreign key to profiles.id)
- title (text)
- content (text)
- created_at (timestamptz)

### resources table
- id (int8, primary key)
- title (text)
- description (text)
- type (text)
- url (text, nullable)
- file_path (text, nullable)
- is_approved (boolean, default false)
- created_by (uuid, foreign key to profiles.id)
- created_at (timestamptz)

## Step 3: Install Server Dependencies

Open PowerShell and navigate to the server directory:
```powershell
cd "c:\Users\Dylan\OneDrive - Asia Pacific University\Desktop\WAPAssignment\server\ProjectAPI"
dotnet restore
```

## Step 4: Install Client Dependencies

Navigate to the client directory:
```powershell
cd "c:\Users\Dylan\OneDrive - Asia Pacific University\Desktop\WAPAssignment\client"
npm install
```

## Step 5: Test Database Connection

Run the server to test the database connection:
```powershell
cd "c:\Users\Dylan\OneDrive - Asia Pacific University\Desktop\WAPAssignment\server\ProjectAPI"
dotnet run
```

The server should start without errors. Check the console for any connection issues.

## Step 6: Create Test Users (Optional)

You can create test users directly in Supabase or use the registration endpoint.

### Example Admin User (manually insert into Supabase):
```sql
INSERT INTO profiles (id, login_id, password_hash, full_name, role, created_at)
VALUES (
    gen_random_uuid(),
    'admin@codesage.com',
    '$2a$11$example_hashed_password_here',
    'System Administrator',
    'admin',
    NOW()
);
```

Note: Use the registration endpoint to properly hash passwords, or use an online BCrypt generator.

## Step 7: Start Both Servers

### Terminal 1 - Backend (.NET):
```powershell
cd "c:\Users\Dylan\OneDrive - Asia Pacific University\Desktop\WAPAssignment\server\ProjectAPI"
dotnet run
```

### Terminal 2 - Frontend (React):
```powershell
cd "c:\Users\Dylan\OneDrive - Asia Pacific University\Desktop\WAPAssignment\client"
npm run dev
```

## Step 8: Test the Application

1. Open browser to `http://localhost:5173`
2. Try registering a new user
3. Test login functionality
4. Verify JWT token is stored in localStorage
5. Test API endpoints in Swagger at `http://localhost:5245/swagger`

## API Endpoints

### Authentication
- POST `/api/auth/login` - User login
- POST `/api/auth/register` - User registration
- POST `/api/auth/logout` - User logout

### Forum
- GET `/api/forum` - Get all forum posts
- GET `/api/forum/{id}` - Get specific post
- POST `/api/forum` - Create new post (requires auth)
- PUT `/api/forum/{id}` - Update post (requires auth)
- DELETE `/api/forum/{id}` - Delete post (requires auth)

### Chat
- POST `/api/chat/send` - Send message to AI chatbot

## Troubleshooting

### Common Issues:

1. **Connection String Error**: Verify your Supabase credentials
2. **CORS Error**: Make sure React dev server is running on port 5173
3. **JWT Error**: Check that the JWT secret key is properly configured
4. **Package Restore Issues**: Run `dotnet clean` then `dotnet restore`

### Security Notes:
- Change JWT secret keys before deployment
- Use environment variables for sensitive data
- Enable HTTPS in production
- Implement rate limiting for API endpoints

## Database Schema Validation

The Entity Framework models are configured to work with your existing Supabase schema using:
- `[Table("table_name")]` attributes to map to existing tables
- `[Column("column_name")]` attributes to map to existing columns
- Foreign key relationships between tables
- Proper data types (Guid for UUIDs, DateTime for timestamps)

The system is now ready for use with your existing Supabase database!
