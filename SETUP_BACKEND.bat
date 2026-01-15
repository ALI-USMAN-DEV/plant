@echo off
echo ========================================
echo Backend Setup Script
echo ========================================
echo.

cd /d %~dp0

echo [1/9] Checking Composer...
where composer >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Composer not found!
    echo Please install Composer from: https://getcomposer.org/download/
    echo.
    pause
    exit /b 1
)
echo Composer found!
echo.

echo [2/9] Installing Dependencies...
composer install
if %errorlevel% neq 0 (
    echo ERROR: Composer install failed!
    pause
    exit /b 1
)
echo Dependencies installed!
echo.

echo [3/9] Creating .env file...
if not exist .env (
    if exist .env.example (
        copy .env.example .env
        echo .env file created from .env.example
        echo.
        echo IMPORTANT: Please edit .env file and set:
        echo   - DB_DATABASE=plant_layout
        echo   - DB_USERNAME=root
        echo   - DB_PASSWORD=your_mysql_password
        echo.
        pause
    ) else (
        echo WARNING: .env.example not found!
        echo Please create .env file manually.
        pause
    )
) else (
    echo .env file already exists
)
echo.

echo [4/9] Generating App Key...
where php >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: PHP not found!
    echo Please install PHP or use XAMPP
    echo Then run: php artisan key:generate
    pause
) else (
    php artisan key:generate
    echo App key generated!
)
echo.

echo [5/9] Database Setup...
echo Please create database manually:
echo   1. Open phpMyAdmin: http://localhost/phpmyadmin
echo   2. Create database: plant_layout
echo   3. Collation: utf8mb4_unicode_ci
echo   4. Then press any key to continue...
pause
echo.

echo [6/9] Running Migrations...
where php >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: PHP not found!
    echo Please run manually: php artisan migrate
    pause
) else (
    php artisan migrate
    echo Migrations completed!
)
echo.

echo [7/9] Seeding Database (Optional)...
echo Do you want to seed database with sample data? (Y/N)
set /p seed_choice=
if /i "%seed_choice%"=="Y" (
    php artisan db:seed
    echo Database seeded!
) else (
    echo Skipping database seed.
)
echo.

echo [8/9] Creating Storage Link...
where php >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: PHP not found!
    echo Please run manually: php artisan storage:link
    pause
) else (
    php artisan storage:link
    echo Storage link created!
)
echo.

echo [9/9] Setup Complete!
echo.
echo ========================================
echo Next Steps:
echo ========================================
echo 1. Edit .env file with database credentials
echo 2. Create database: plant_layout
echo 3. Start server: php artisan serve
echo 4. Backend will run at: http://localhost:8000
echo.
echo ========================================
pause
