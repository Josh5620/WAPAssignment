# Admin User Setup Guide

## Creating an Admin User

Since admin login now uses username instead of email, you need to create an admin user in your Supabase database.

### Option 1: Direct Database Insert (Recommended)

1. Go to your Supabase dashboard
2. Navigate to the Table Editor
3. Open the `profiles` table
4. Insert a new row with these values:

```sql
INSERT INTO profiles (id, login_id, password_hash, full_name, role, created_at)
VALUES (
    gen_random_uuid(),
    'admin@codesage.com',
    '$2a$11$K2xF8mGhpY5zQ7wE9Nv5/.vFhBzFjY6QwXrLJ4Kj8dK.mHnPqRsWu',  -- This is 'admin123' hashed
    'admin',  -- This will be the username for admin login
    'admin',
    NOW()
);
```

### Option 2: Use the Registration Endpoint First

1. Use the regular registration endpoint to create an admin user
2. Set the role to 'admin' and full_name to 'admin' (or your preferred username)

Example using curl:
```bash
curl -X POST http://localhost:5245/api/auth/register \
-H "Content-Type: application/json" \
-d '{
  "email": "admin@codesage.com",
  "password": "admin123",
  "fullName": "admin",
  "role": "admin"
}'
```

## Admin Login Credentials

After creating the admin user:
- **Username**: `admin` (or whatever you set as full_name)
- **Password**: `admin123` (or whatever you set)

## How It Works

The admin login endpoint (`/api/auth/admin-login`) now:
1. Searches for users where `full_name` matches the entered username
2. Ensures the user has `role = 'admin'`
3. Verifies the password
4. Returns a JWT token if successful

## Security Note

For production:
- Use a strong password for admin accounts
- Consider implementing additional security measures like 2FA
- Change default admin credentials
- Use environment variables for sensitive data

## Testing the Admin Login

1. Start your backend server: `dotnet run`
2. Start your frontend: `npm run dev`
3. Navigate to `/admin` route
4. Enter username and password
5. Should redirect to admin dashboard if successful
