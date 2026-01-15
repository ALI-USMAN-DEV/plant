# Backend Setup - Complete Guide

## 🎯 3 Simple Steps

### Step 1: Run Setup Script
```powershell
# PowerShell mein
cd backend
.\SETUP_BACKEND.ps1
```

Ya:
```cmd
# CMD mein
cd backend
SETUP_BACKEND.bat
```

### Step 2: Edit .env File
`.env` file open karo aur database password set karo:
```env
DB_PASSWORD=your_mysql_password
```

### Step 3: Create Database
phpMyAdmin mein:
- Database name: `plant_layout`
- Collation: `utf8mb4_unicode_ci`

## ✅ That's It!

Phir server start karo:
```bash
php artisan serve
```

## 📋 Detailed Steps

### Prerequisites
- PHP 8.1+
- Composer
- MySQL
- XAMPP/WAMP (Windows)

### Quick Commands

```bash
# 1. Install dependencies
composer install

# 2. Create .env
copy .env.example .env

# 3. Generate key
php artisan key:generate

# 4. Create database (MySQL mein)
CREATE DATABASE plant_layout;

# 5. Run migrations
php artisan migrate

# 6. Seed (optional)
php artisan db:seed

# 7. Storage link
php artisan storage:link

# 8. Start server
php artisan serve
```

## 🐛 Troubleshooting

### Composer Not Found
- Install from: https://getcomposer.org/

### PHP Not Found
- Install PHP 8.1+
- Or use XAMPP

### Database Error
- MySQL running hai check karo
- Credentials `.env` mein sahi hain check karo

### Migration Failed
```bash
php artisan migrate:fresh
php artisan db:seed
```

## 📞 Help

Agar koi issue aaye to:
1. Error message check karo
2. `.env` file verify karo
3. Database connection test karo
4. Logs check karo: `storage/logs/laravel.log`

---

**Setup complete hone ke baad server start karo!** 🚀
