# Find XAMPP and Composer, then setup backend

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Finding XAMPP and Composer..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find XAMPP PHP
$phpPath = $null
$possiblePaths = @(
    "C:\xampp\php\php.exe",
    "C:\Program Files\XAMPP\php\php.exe",
    "C:\Program Files (x86)\XAMPP\php\php.exe",
    "$env:ProgramFiles\XAMPP\php\php.exe",
    "$env:ProgramFiles(x86)\XAMPP\php\php.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $phpPath = $path
        Write-Host "✓ XAMPP PHP found: $path" -ForegroundColor Green
        break
    }
}

if (-not $phpPath) {
    Write-Host "✗ XAMPP PHP not found!" -ForegroundColor Red
    Write-Host "Please provide XAMPP installation path:" -ForegroundColor Yellow
    $customPath = Read-Host "Enter XAMPP path (e.g., C:\xampp)"
    if ($customPath) {
        $phpPath = Join-Path $customPath "php\php.exe"
        if (-not (Test-Path $phpPath)) {
            Write-Host "✗ PHP not found at: $phpPath" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "✗ Cannot proceed without PHP" -ForegroundColor Red
        exit 1
    }
}

# Find Composer
$composerPath = $null
$composerPaths = @(
    "composer",
    "$env:LOCALAPPDATA\ComposerSetup\bin\composer.bat",
    "$env:APPDATA\Composer\vendor\bin\composer.bat",
    "$env:ProgramFiles\Composer\composer.bat"
)

foreach ($path in $composerPaths) {
    if ($path -eq "composer") {
        if (Get-Command composer -ErrorAction SilentlyContinue) {
            $composerPath = "composer"
            Write-Host "✓ Composer found in PATH" -ForegroundColor Green
            break
        }
    } elseif (Test-Path $path) {
        $composerPath = $path
        Write-Host "✓ Composer found: $path" -ForegroundColor Green
        break
    }
}

if (-not $composerPath) {
    Write-Host "✗ Composer not found!" -ForegroundColor Red
    Write-Host "Please install Composer from: https://getcomposer.org/download/" -ForegroundColor Yellow
    Write-Host "After installation, restart this script." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Backend Setup..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Change to backend directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Step 1: Install Dependencies
Write-Host "[1/7] Installing Dependencies..." -ForegroundColor Yellow
& $composerPath install --no-interaction
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Composer install failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Dependencies installed!" -ForegroundColor Green
Write-Host ""

# Step 2: Check .env file
Write-Host "[2/7] Checking .env file..." -ForegroundColor Yellow
if (-not (Test-Path ".env")) {
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
        Write-Host "✓ .env file created from .env.example" -ForegroundColor Green
    } else {
        Write-Host "⚠ .env.example not found, creating basic .env..." -ForegroundColor Yellow
        @"
APP_NAME="Plant Layout API"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8000
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=plant_layout
DB_USERNAME=root
DB_PASSWORD=
"@ | Out-File -FilePath ".env" -Encoding utf8
        Write-Host "✓ .env file created!" -ForegroundColor Green
    }
} else {
    Write-Host "✓ .env file already exists" -ForegroundColor Green
}
Write-Host ""

# Step 3: Generate App Key
Write-Host "[3/7] Generating App Key..." -ForegroundColor Yellow
& $phpPath artisan key:generate --force
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ App key generated!" -ForegroundColor Green
} else {
    Write-Host "⚠ App key generation failed" -ForegroundColor Yellow
}
Write-Host ""

# Step 4: Database Setup
Write-Host "[4/7] Database Setup..." -ForegroundColor Yellow
Write-Host "Please create database in phpMyAdmin:" -ForegroundColor Cyan
Write-Host "  1. Open: http://localhost/phpmyadmin" -ForegroundColor White
Write-Host "  2. Create database: plant_layout" -ForegroundColor White
Write-Host "  3. Collation: utf8mb4_unicode_ci" -ForegroundColor White
Write-Host ""
$continue = Read-Host "Press Enter after creating database (or type 'skip' to continue)"

# Step 5: Run Migrations
Write-Host "[5/7] Running Migrations..." -ForegroundColor Yellow
& $phpPath artisan migrate --force
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Migrations completed!" -ForegroundColor Green
} else {
    Write-Host "✗ Migrations failed! Check database connection." -ForegroundColor Red
    Write-Host "Make sure:" -ForegroundColor Yellow
    Write-Host "  1. MySQL is running in XAMPP" -ForegroundColor White
    Write-Host "  2. Database 'plant_layout' exists" -ForegroundColor White
    Write-Host "  3. .env file has correct credentials" -ForegroundColor White
}
Write-Host ""

# Step 6: Seed Database
Write-Host "[6/7] Seeding Database (Optional)..." -ForegroundColor Yellow
$seedChoice = Read-Host "Do you want to seed database with sample data? (Y/N)"
if ($seedChoice -eq "Y" -or $seedChoice -eq "y") {
    & $phpPath artisan db:seed --force
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Database seeded!" -ForegroundColor Green
    } else {
        Write-Host "⚠ Database seeding failed" -ForegroundColor Yellow
    }
} else {
    Write-Host "Skipping database seed." -ForegroundColor Gray
}
Write-Host ""

# Step 7: Create Storage Link
Write-Host "[7/7] Creating Storage Link..." -ForegroundColor Yellow
& $phpPath artisan storage:link
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Storage link created!" -ForegroundColor Green
} else {
    Write-Host "⚠ Storage link creation failed" -ForegroundColor Yellow
}
Write-Host ""

# Complete
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Make sure MySQL is running in XAMPP" -ForegroundColor White
Write-Host "2. Create database 'plant_layout' in phpMyAdmin (if not done)" -ForegroundColor White
Write-Host "3. Start server: & '$phpPath' artisan serve" -ForegroundColor White
Write-Host "4. Backend will run at: http://localhost:8000" -ForegroundColor White
Write-Host ""
Write-Host "To start server, run:" -ForegroundColor Cyan
Write-Host "  cd backend" -ForegroundColor White
Write-Host "  & '$phpPath' artisan serve" -ForegroundColor White
Write-Host ""
