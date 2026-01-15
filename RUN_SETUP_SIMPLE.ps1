# Simple Backend Setup Script

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Backend Setup - Auto Detection" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find XAMPP PHP
$phpPath = $null
$paths = @("C:\xampp\php\php.exe", "C:\Program Files\XAMPP\php\php.exe", "C:\Program Files (x86)\XAMPP\php\php.exe")

foreach ($path in $paths) {
    if (Test-Path $path) {
        $phpPath = $path
        Write-Host "Found PHP: $path" -ForegroundColor Green
        break
    }
}

if (-not $phpPath) {
    Write-Host "XAMPP PHP not found in common locations!" -ForegroundColor Red
    Write-Host "Please edit this script and set PHP path manually" -ForegroundColor Yellow
    Write-Host "Or add XAMPP PHP to PATH" -ForegroundColor Yellow
    exit 1
}

# Find Composer
$composerPath = "composer"
if (-not (Get-Command composer -ErrorAction SilentlyContinue)) {
    $composerPaths = @(
        "$env:LOCALAPPDATA\ComposerSetup\bin\composer.bat",
        "$env:APPDATA\Composer\vendor\bin\composer.bat"
    )
    foreach ($path in $composerPaths) {
        if (Test-Path $path) {
            $composerPath = $path
            Write-Host "Found Composer: $path" -ForegroundColor Green
            break
        }
    }
    if ($composerPath -eq "composer") {
        Write-Host "Composer not found! Please install Composer first." -ForegroundColor Red
        Write-Host "Download from: https://getcomposer.org/download/" -ForegroundColor Yellow
        exit 1
    }
} else {
    Write-Host "Found Composer in PATH" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting setup..." -ForegroundColor Cyan
Write-Host ""

# Change to backend directory
Set-Location $PSScriptRoot

# Step 1: Install Dependencies
Write-Host "[1/7] Installing Dependencies..." -ForegroundColor Yellow
& $composerPath install --no-interaction
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Composer install failed!" -ForegroundColor Red
    exit 1
}
Write-Host "Dependencies installed!" -ForegroundColor Green
Write-Host ""

# Step 2: Check .env
Write-Host "[2/7] Checking .env file..." -ForegroundColor Yellow
if (-not (Test-Path ".env")) {
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
        Write-Host ".env file created!" -ForegroundColor Green
    } else {
        Write-Host "Creating basic .env file..." -ForegroundColor Yellow
        $envContent = @"
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
"@
        $envContent | Out-File -FilePath ".env" -Encoding utf8
        Write-Host ".env file created!" -ForegroundColor Green
    }
} else {
    Write-Host ".env file exists" -ForegroundColor Green
}
Write-Host ""

# Step 3: Generate App Key
Write-Host "[3/7] Generating App Key..." -ForegroundColor Yellow
& $phpPath artisan key:generate --force
Write-Host "App key generated!" -ForegroundColor Green
Write-Host ""

# Step 4: Database Info
Write-Host "[4/7] Database Setup Required" -ForegroundColor Yellow
Write-Host "Please create database in phpMyAdmin:" -ForegroundColor Cyan
Write-Host "  1. Open: http://localhost/phpmyadmin" -ForegroundColor White
Write-Host "  2. Create database: plant_layout" -ForegroundColor White
Write-Host "  3. Collation: utf8mb4_unicode_ci" -ForegroundColor White
Write-Host ""

# Step 5: Run Migrations
Write-Host "[5/7] Running Migrations..." -ForegroundColor Yellow
& $phpPath artisan migrate --force
if ($LASTEXITCODE -eq 0) {
    Write-Host "Migrations completed!" -ForegroundColor Green
} else {
    Write-Host "Migrations failed! Check database connection." -ForegroundColor Red
}
Write-Host ""

# Step 6: Seed Database
Write-Host "[6/7] Seeding Database..." -ForegroundColor Yellow
& $phpPath artisan db:seed --force
if ($LASTEXITCODE -eq 0) {
    Write-Host "Database seeded!" -ForegroundColor Green
} else {
    Write-Host "Database seeding failed" -ForegroundColor Yellow
}
Write-Host ""

# Step 7: Storage Link
Write-Host "[7/7] Creating Storage Link..." -ForegroundColor Yellow
& $phpPath artisan storage:link
Write-Host "Storage link created!" -ForegroundColor Green
Write-Host ""

# Complete
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To start server, run:" -ForegroundColor Yellow
Write-Host "  & '$phpPath' artisan serve" -ForegroundColor White
Write-Host ""
Write-Host "Backend will run at: http://localhost:8000" -ForegroundColor Cyan
Write-Host ""
