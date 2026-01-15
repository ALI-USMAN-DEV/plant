# Backend Setup Script (PowerShell)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Backend Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Step 1: Check Composer
Write-Host "[1/9] Checking Composer..." -ForegroundColor Yellow
if (Get-Command composer -ErrorAction SilentlyContinue) {
    Write-Host "✓ Composer found!" -ForegroundColor Green
} else {
    Write-Host "✗ ERROR: Composer not found!" -ForegroundColor Red
    Write-Host "Please install Composer from: https://getcomposer.org/download/" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Step 2: Install Dependencies
Write-Host "[2/9] Installing Dependencies..." -ForegroundColor Yellow
Write-Host "Running: composer install" -ForegroundColor Cyan
composer install
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ ERROR: Composer install failed!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✓ Dependencies installed!" -ForegroundColor Green
Write-Host ""

# Step 3: Create .env file
Write-Host "[3/9] Creating .env file..." -ForegroundColor Yellow
if (-not (Test-Path ".env")) {
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
        Write-Host "✓ .env file created from .env.example" -ForegroundColor Green
        Write-Host ""
        Write-Host "IMPORTANT: Please edit .env file and set:" -ForegroundColor Yellow
        Write-Host "  - DB_DATABASE=plant_layout" -ForegroundColor White
        Write-Host "  - DB_USERNAME=root" -ForegroundColor White
        Write-Host "  - DB_PASSWORD=your_mysql_password" -ForegroundColor White
        Write-Host ""
        Read-Host "Press Enter to continue"
    } else {
        Write-Host "⚠ WARNING: .env.example not found!" -ForegroundColor Yellow
        Write-Host "Please create .env file manually." -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
    }
} else {
    Write-Host "✓ .env file already exists" -ForegroundColor Green
}
Write-Host ""

# Step 4: Generate App Key
Write-Host "[4/9] Generating App Key..." -ForegroundColor Yellow
if (Get-Command php -ErrorAction SilentlyContinue) {
    php artisan key:generate
    Write-Host "✓ App key generated!" -ForegroundColor Green
} else {
    Write-Host "⚠ WARNING: PHP not found!" -ForegroundColor Yellow
    Write-Host "Please install PHP or use XAMPP" -ForegroundColor Yellow
    Write-Host "Then run: php artisan key:generate" -ForegroundColor Yellow
    Read-Host "Press Enter to continue"
}
Write-Host ""

# Step 5: Database Setup
Write-Host "[5/9] Database Setup..." -ForegroundColor Yellow
Write-Host "Please create database manually:" -ForegroundColor Cyan
Write-Host "  1. Open phpMyAdmin: http://localhost/phpmyadmin" -ForegroundColor White
Write-Host "  2. Create database: plant_layout" -ForegroundColor White
Write-Host "  3. Collation: utf8mb4_unicode_ci" -ForegroundColor White
Write-Host ""
Read-Host "Press Enter after creating database"

# Step 6: Run Migrations
Write-Host "[6/9] Running Migrations..." -ForegroundColor Yellow
if (Get-Command php -ErrorAction SilentlyContinue) {
    php artisan migrate
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Migrations completed!" -ForegroundColor Green
    } else {
        Write-Host "✗ Migrations failed! Check database connection." -ForegroundColor Red
    }
} else {
    Write-Host "⚠ WARNING: PHP not found!" -ForegroundColor Yellow
    Write-Host "Please run manually: php artisan migrate" -ForegroundColor Yellow
}
Write-Host ""

# Step 7: Seed Database
Write-Host "[7/9] Seeding Database (Optional)..." -ForegroundColor Yellow
$seedChoice = Read-Host "Do you want to seed database with sample data? (Y/N)"
if ($seedChoice -eq "Y" -or $seedChoice -eq "y") {
    if (Get-Command php -ErrorAction SilentlyContinue) {
        php artisan db:seed
        Write-Host "✓ Database seeded!" -ForegroundColor Green
    } else {
        Write-Host "⚠ Please run manually: php artisan db:seed" -ForegroundColor Yellow
    }
} else {
    Write-Host "Skipping database seed." -ForegroundColor Gray
}
Write-Host ""

# Step 8: Create Storage Link
Write-Host "[8/9] Creating Storage Link..." -ForegroundColor Yellow
if (Get-Command php -ErrorAction SilentlyContinue) {
    php artisan storage:link
    Write-Host "✓ Storage link created!" -ForegroundColor Green
} else {
    Write-Host "⚠ Please run manually: php artisan storage:link" -ForegroundColor Yellow
}
Write-Host ""

# Step 9: Complete
Write-Host "[9/9] Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. Edit .env file with database credentials" -ForegroundColor White
Write-Host "2. Create database: plant_layout (if not done)" -ForegroundColor White
Write-Host "3. Start server: php artisan serve" -ForegroundColor White
Write-Host "4. Backend will run at: http://localhost:8000" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Read-Host "Press Enter to exit"
