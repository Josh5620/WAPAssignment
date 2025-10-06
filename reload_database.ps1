# Database Reload Script for Learning Management System
# PowerShell script to clear and reload database with seed data
#
# Usage:
#   .\reload_database.ps1                    # Interactive mode with confirmation
#   .\reload_database.ps1 -Force             # Skip confirmation prompts
#   .\reload_database.ps1 -ConnectionString "Server=..." # Custom connection string
#   .\reload_database.ps1 -Help              # Show help information

param(
    [switch]$Force,
    [string]$ConnectionString = "",
    [switch]$Help
)

# Show help information
if ($Help) {
    Write-Host @"
Learning Management System - Database Reloader (PowerShell)
============================================================

This script connects to your SQL Server database, safely clears existing data,
and reloads fresh seed data from your SQL files.

USAGE:
  .\reload_database.ps1                    # Interactive mode
  .\reload_database.ps1 -Force             # Skip confirmations
  .\reload_database.ps1 -ConnectionString "Server=localhost;Database=MyDB;Trusted_Connection=True;"

REQUIREMENTS:
  • SQL Server or LocalDB running
  • Valid connection string in appsettings.json (or provided via parameter)
  • Seed SQL files in Seeds/SQL/ directory

EXAMPLES:
  .\reload_database.ps1                    # Safe interactive mode
  .\reload_database.ps1 -Force             # Quick reset for development
  
The script will:
  [OK] Connect to your database
  [OK] Show current data counts
  [OK] Clear tables in dependency-safe order
  [OK] Load fresh data from seed_*.sql files
  [OK] Verify the results

"@
    exit 0
}

# Color-coded output functions
function Write-Success { param($Message) Write-Host "[OK] $Message" -ForegroundColor Green }
function Write-Error { param($Message) Write-Host "[ERROR] $Message" -ForegroundColor Red }
function Write-Warning { param($Message) Write-Host "[WARNING] $Message" -ForegroundColor Yellow }
function Write-Info { param($Message) Write-Host "[INFO] $Message" -ForegroundColor Cyan }
function Write-Progress { param($Message) Write-Host "[PROGRESS] $Message" -ForegroundColor Blue }

# Script header
Write-Host "Learning Management System - Database Reloader" -ForegroundColor Magenta
Write-Host "=" * 50 -ForegroundColor Magenta

# Tables to clear in dependency-safe order
$TablesToClear = @(
    "QuestionOptions",
    "Questions", 
    "Flashcards",
    "Resources",
    "Chapters",
    "Courses"
)

# Get connection string from appsettings.json or parameter
function Get-ConnectionString {
    if ($ConnectionString) {
        Write-Info "Using provided connection string"
        return $ConnectionString
    }
    
    # Try to find appsettings.json
    $SettingsFiles = @(
        "appsettings.json",
        "server\ProjectAPI\appsettings.json", 
        "ProjectAPI\appsettings.json"
    )
    
    foreach ($SettingsFile in $SettingsFiles) {
        if (Test-Path $SettingsFile) {
            try {
                $Config = Get-Content $SettingsFile | ConvertFrom-Json
                $ConnStr = $Config.ConnectionStrings.DefaultConnection
                if ($ConnStr) {
                    Write-Info "Using connection string from $SettingsFile"
                    return $ConnStr
                }
            }
            catch {
                Write-Warning "Could not read $SettingsFile`: $($_.Exception.Message)"
            }
        }
    }
    
    # Fallback to default
    $DefaultConn = "Server=(localdb)\MSSQLLocalDB;Database=ProjectAPIDb;Trusted_Connection=true;MultipleActiveResultSets=true"
    Write-Info "Using default LocalDB connection string"
    return $DefaultConn
}

# Connect to database with error handling
function Connect-Database {
    param($ConnectionString)
    
    try {
        Write-Progress "Connecting to SQL Server..."
        $Connection = New-Object System.Data.SqlClient.SqlConnection
        $Connection.ConnectionString = $ConnectionString
        $Connection.Open()
        Write-Success "Connected successfully!"
        return $Connection
    }
    catch {
        Write-Error "Database connection failed: $($_.Exception.Message)"
        Write-Host ""
        Write-Host "TROUBLESHOOTING TIPS:" -ForegroundColor Yellow
        Write-Host "   • Make sure SQL Server/LocalDB is running" -ForegroundColor Yellow
        Write-Host "   • Check if the database exists" -ForegroundColor Yellow
        Write-Host "   • Verify connection string in appsettings.json" -ForegroundColor Yellow
        Write-Host "   • Try running: sqllocaldb start MSSQLLocalDB" -ForegroundColor Yellow
        return $null
    }
}

# Get row count for a table
function Get-TableRowCount {
    param($Connection, $TableName)
    
    try {
        $Command = $Connection.CreateCommand()
        $Command.CommandText = "SELECT COUNT(*) FROM [$TableName]"
        $Result = $Command.ExecuteScalar()
        return [int]$Result
    }
    catch {
        return 0  # Table might not exist yet
    }
}

# Clear all data from tables
function Clear-AllData {
    param($Connection)
    
    try {
        # Show current data counts
        Write-Host ""
        Write-Host "CURRENT DATA COUNTS:" -ForegroundColor Cyan
        $TotalRows = 0
        $DataCounts = @{}
        
        foreach ($Table in $TablesToClear) {
            $Count = Get-TableRowCount -Connection $Connection -TableName $Table
            $TotalRows += $Count
            $DataCounts[$Table] = $Count
            Write-Host "   $Table`: $($Count.ToString('N0')) rows"
        }
        
        if ($TotalRows -eq 0) {
            Write-Success "Database is already empty!"
            return $true
        }
        
        # Confirmation prompt (unless -Force is used)
        if (-not $Force) {
            Write-Host ""
            Write-Warning "About to delete $($TotalRows.ToString('N0')) rows from $($TablesToClear.Count) tables!"
            $Response = Read-Host "Continue? (y/N)"
            if ($Response -notin @('y', 'yes', 'Y', 'YES')) {
                Write-Error "Operation cancelled by user."
                return $false
            }
        }
        
        # Start transaction
        Write-Host ""
        Write-Progress "Starting database transaction..."
        $Transaction = $Connection.BeginTransaction()
        
        try {
            # Disable foreign key constraints temporarily
            Write-Progress "Disabling foreign key constraints..."
            $Command = $Connection.CreateCommand()
            $Command.Transaction = $Transaction
            $Command.CommandText = "EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'"
            $Command.ExecuteNonQuery() | Out-Null
            
            # Clear each table
            Write-Progress "Clearing tables..."
            foreach ($Table in $TablesToClear) {
                Write-Host "   Clearing $Table..." -NoNewline
                
                $Command.CommandText = "DELETE FROM [$Table]"
                $RowsAffected = $Command.ExecuteNonQuery()
                
                Write-Host " [OK] ($($RowsAffected.ToString('N0')) rows deleted)" -ForegroundColor Green
            }
            
            # Re-enable foreign key constraints
            Write-Progress "Re-enabling foreign key constraints..."
            $Command.CommandText = "EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'"
            $Command.ExecuteNonQuery() | Out-Null
            
            # Commit the transaction
            $Transaction.Commit()
            Write-Success "All data cleared successfully!"
            return $true
        }
        catch {
            $Transaction.Rollback()
            throw
        }
    }
    catch {
        Write-Error "Error clearing data: $($_.Exception.Message)"
        return $false
    }
}

# Find seed SQL files
function Find-SeedFiles {
    $SeedDirs = @(
        "Seeds\SQL",
        "server\ProjectAPI\Seeds\SQL",
        "ProjectAPI\Seeds\SQL"
    )
    
    $SeedDir = $null
    foreach ($Dir in $SeedDirs) {
        if (Test-Path $Dir) {
            $SeedDir = $Dir
            break
        }
    }
    
    if (-not $SeedDir) {
        Write-Error "Could not find Seeds\SQL directory!"
        Write-Host "HINT: Make sure you're running this script from the project root." -ForegroundColor Yellow
        return @()
    }
    
    $SeedFiles = Get-ChildItem -Path $SeedDir -Filter "seed_*.sql" | Sort-Object Name
    
    Write-Host ""
    Write-Host "FOUND $($SeedFiles.Count) SEED FILES:" -ForegroundColor Cyan
    foreach ($File in $SeedFiles) {
        $SizeKB = [math]::Round($File.Length / 1024, 1)
        Write-Host "   • $($File.Name) ($SizeKB KB)"
    }
    
    return $SeedFiles
}

# Execute a single seed file
function Execute-SeedFile {
    param($Connection, $FilePath)
    
    try {
        Write-Progress "Loading $($FilePath.Name)..."
        
        # Read the SQL file
        $SqlContent = Get-Content -Path $FilePath.FullName -Raw -Encoding UTF8
        
        if ([string]::IsNullOrWhiteSpace($SqlContent)) {
            Write-Warning "$($FilePath.Name) is empty!"
            return $true
        }
        
        # Split by GO statements and execute each batch
        $Batches = $SqlContent -split '\r?\nGO\r?\n', 0, 'IgnoreCase'
        $SuccessfulBatches = 0
        
        $Command = $Connection.CreateCommand()
        $Command.CommandTimeout = 300  # 5 minutes timeout for large batches
        
        for ($i = 0; $i -lt $Batches.Count; $i++) {
            $Batch = $Batches[$i].Trim()
            if ([string]::IsNullOrWhiteSpace($Batch)) {
                continue
            }
            
            try {
                $Command.CommandText = $Batch
                $Command.ExecuteNonQuery() | Out-Null
                $SuccessfulBatches++
                
                # Show progress for large files
                if ($Batches.Count -gt 5) {
                    Write-Host "   Batch $($i + 1)/$($Batches.Count) [OK]" -ForegroundColor Green
                }
            }
            catch {
                Write-Error "Error in batch $($i + 1): $($_.Exception.Message)"
                Write-Host "   BATCH PREVIEW: $($Batch.Substring(0, [math]::Min(100, $Batch.Length)))..." -ForegroundColor Yellow
                return $false
            }
        }
        
        Write-Success "$($FilePath.Name) loaded successfully! ($SuccessfulBatches batches)"
        return $true
    }
    catch {
        Write-Error "Error executing $($FilePath.Name): $($_.Exception.Message)"
        return $false
    }
}

# Load all seed data
function Load-AllSeedData {
    param($Connection)
    
    $SeedFiles = Find-SeedFiles
    
    if ($SeedFiles.Count -eq 0) {
        Write-Error "No seed files found!"
        return $false
    }
    
    $SuccessCount = 0
    $StartTime = Get-Date
    
    Write-Host ""
    Write-Host "LOADING $($SeedFiles.Count) SEED FILES..." -ForegroundColor Green
    
    foreach ($SeedFile in $SeedFiles) {
        if (Execute-SeedFile -Connection $Connection -FilePath $SeedFile) {
            $SuccessCount++
        }
        else {
            Write-Error "Failed to load $($SeedFile.Name)"
            return $false
        }
    }
    
    $ElapsedTime = (Get-Date) - $StartTime
    Write-Host ""
    Write-Host "ALL SEED DATA LOADED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "   FILES PROCESSED: $SuccessCount/$($SeedFiles.Count)"
    Write-Host "   TOTAL TIME: $($ElapsedTime.TotalSeconds.ToString('F2')) seconds"
    return $true
}

# Verify data was loaded correctly
function Verify-DataLoaded {
    param($Connection)
    
    Write-Host ""
    Write-Host "VERIFYING DATA LOAD..." -ForegroundColor Cyan
    
    # Check tables in reverse order (data should exist in parent tables)
    $ReversedTables = @($TablesToClear)
    [array]::Reverse($ReversedTables)
    
    foreach ($Table in $ReversedTables) {
        $Count = Get-TableRowCount -Connection $Connection -TableName $Table
        $Status = if ($Count -gt 0) { "[OK]" } else { "[EMPTY]" }
        Write-Host "   $Table`: $($Count.ToString('N0')) rows $Status"
    }
}

# Main script execution
try {
    # Get connection string
    $ConnString = Get-ConnectionString
    
    # Connect to database
    $Connection = Connect-Database -ConnectionString $ConnString
    if (-not $Connection) {
        exit 1
    }
    
    try {
        # Clear existing data
        if (-not (Clear-AllData -Connection $Connection)) {
            exit 1
        }
        
        # Load seed data
        if (-not (Load-AllSeedData -Connection $Connection)) {
            exit 1
        }
        
        # Verify the results
        Verify-DataLoaded -Connection $Connection
        
        Write-Host ""
        Write-Host "DATABASE RELOAD COMPLETED SUCCESSFULLY!" -ForegroundColor Green
        Write-Host "Your application is ready to use with fresh seed data." -ForegroundColor Cyan
    }
    finally {
        $Connection.Close()
        Write-Info "Database connection closed."
    }
}
catch {
    Write-Error "Unexpected error: $($_.Exception.Message)"
    Write-Host "Stack trace:" -ForegroundColor Yellow
    Write-Host $_.Exception.StackTrace -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Script completed. Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")