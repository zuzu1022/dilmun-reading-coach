# Dilmun Reading Coach - Quick Setup Script
Write-Host "=== Dilmun Reading Coach Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if .NET is installed
Write-Host "Checking .NET installation..." -ForegroundColor Yellow
$dotnetVersion = dotnet --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ .NET found: $dotnetVersion" -ForegroundColor Green
} else {
    Write-Host "✗ .NET not found. Please install .NET 8.0 SDK" -ForegroundColor Red
    Write-Host "Download from: https://dotnet.microsoft.com/download" -ForegroundColor Yellow
    exit 1
}

# Check if EF tools are installed
Write-Host "Checking Entity Framework tools..." -ForegroundColor Yellow
$efTools = dotnet ef --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ EF Tools found: $efTools" -ForegroundColor Green
} else {
    Write-Host "Installing EF Tools..." -ForegroundColor Yellow
    dotnet tool install --global dotnet-ef
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Failed to install EF Tools" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ EF Tools installed" -ForegroundColor Green
}

# Check SQL Server connection
Write-Host "Checking SQL Server connection..." -ForegroundColor Yellow
try {
    $sqlCheck = sqlcmd -S localhost -E -Q "SELECT @@VERSION" -W -h -1 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ SQL Server is accessible" -ForegroundColor Green
    } else {
        Write-Host "⚠ SQL Server might not be running or accessible" -ForegroundColor Yellow
        Write-Host "  Trying LocalDB..." -ForegroundColor Yellow
        $localDbCheck = sqlcmd -S "(localdb)\MSSQLLocalDB" -E -Q "SELECT @@VERSION" -W -h -1 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ LocalDB is accessible" -ForegroundColor Green
            Write-Host "⚠ You may need to update connection string to use (localdb)\MSSQLLocalDB" -ForegroundColor Yellow
        } else {
            Write-Host "✗ Cannot connect to SQL Server" -ForegroundColor Red
            Write-Host "  Please install SQL Server Express or LocalDB" -ForegroundColor Yellow
            Write-Host "  Download: https://www.microsoft.com/en-us/sql-server/sql-server-downloads" -ForegroundColor Yellow
        }
    }
} catch {
    Write-Host "⚠ Could not check SQL Server (sqlcmd not found)" -ForegroundColor Yellow
    Write-Host "  Make sure SQL Server is installed and running" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Running Database Migrations ===" -ForegroundColor Cyan
Set-Location "src\DilmunReadingCoach.Web"
dotnet ef database update

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Database setup complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "=== Next Steps ===" -ForegroundColor Cyan
    Write-Host "1. Run the application: dotnet run" -ForegroundColor White
    Write-Host "2. Open browser to: https://localhost:5001" -ForegroundColor White
    Write-Host "3. Login with:" -ForegroundColor White
    Write-Host "   Username: coordinator" -ForegroundColor Yellow
    Write-Host "   Password: Coordinator123!" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "✗ Database migration failed" -ForegroundColor Red
    Write-Host "  Check the error above and ensure SQL Server is running" -ForegroundColor Yellow
}

Set-Location ..\..
Write-Host ""

