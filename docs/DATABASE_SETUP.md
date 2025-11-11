# Database Management Setup

## Quick Start

### For the PowerShell Script (Advanced Users)

1. **Ensure PowerShell execution policy allows scripts:**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **Run the database reload script:**
   ```powershell
   # Interactive mode (asks for confirmation)
   .\reload_database.ps1
   
   # Force mode (no confirmation)
   .\reload_database.ps1 -Force
   
   # Custom connection string
   .\reload_database.ps1 -ConnectionString "Server=localhost;Database=MyDB;Trusted_Connection=True;"
   
   # Get help
   .\reload_database.ps1 -Help
   ```

### For Team Members (Simple Approach)

Just clone and run - the seeding is now automatic:

```bash
git clone https://github.com/Josh5620/WAPAssignment.git
cd WAPAssignment/server/ProjectAPI
dotnet restore
dotnet run
```

The application will automatically:
- ✅ Create the database if it doesn't exist
- ✅ Load all seed data on first run
- ✅ Skip seeding if data already exists

## What Each Solution Does

### � PowerShell Script (`reload_database.ps1`)
- **Purpose**: Reset and reload database with fresh data
- **Use Case**: When you want to completely reset your local database
- **Features**: 
  - Safely deletes all data in dependency order
  - Loads fresh seed data from SQL files
  - Shows progress and handles errors gracefully
  - Confirmation prompts (unless -Force is used)
  - Native Windows integration (no additional dependencies)

### 🚀 Automatic Seeding (`Program.cs`)
- **Purpose**: Ensure new team members get seed data automatically  
- **Use Case**: First-time setup and team collaboration
- **Features**:
  - Runs automatically when app starts
  - Only seeds if database is empty
  - Uses the same SQL seed files
  - Integrated with your existing application

## Current Issues Fixed

✅ **Variable Scope**: Python script handles GO statements properly
✅ **Manual Process**: Automatic seeding for team members  
✅ **Error Handling**: Both solutions include comprehensive error handling
✅ **Dependency Order**: Tables cleared in proper sequence
✅ **Team Collaboration**: Consistent database state for everyone

## Troubleshooting

If the Python script fails:
1. Make sure SQL Server is running
2. Check connection string in `appsettings.json`
3. Install pyodbc: `pip install pyodbc`
4. Run from project root directory

If automatic seeding fails:
1. Check the console logs when running `dotnet run`
2. Ensure seed files exist in `Seeds/SQL/` folder
3. Verify connection string in `appsettings.json`