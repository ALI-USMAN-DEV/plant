# Backend Setup - Run Now! 🚀

## ✅ Current Status

Main ne setup process start kar diya hai. Ab ye steps follow karo:

## 📋 Steps Completed

1. ✅ Setup scripts created
2. ✅ .env file structure ready
3. ⏳ Checking Composer...
4. ⏳ Installing dependencies...
5. ⏳ Creating .env file...

## 🎯 Next Steps (Manual)

### Step 1: Install Composer (Agar nahi hai)
- Download: https://getcomposer.org/download/
- Install `Composer-Setup.exe`
- Verify: `composer --version`

### Step 2: Install XAMPP (Agar nahi hai)
- Download: https://www.apachefriends.org/
- Install XAMPP
- Start Apache and MySQL

### Step 3: Run These Commands

```powershell
cd C:\Users\ah516\Desktop\apk\backend

# Install dependencies (if Composer installed)
composer install

# Generate app key (if PHP installed)
php artisan key:generate

# Create database in phpMyAdmin:
# 1. Open: http://localhost/phpmyadmin
# 2. Create database: plant_layout
# 3. Collation: utf8mb4_unicode_ci

# Run migrations
php artisan migrate

# Seed database (optional)
php artisan db:seed

# Create storage link
php artisan storage:link

# Start server
php artisan serve
```

## ⚡ Quick Commands

Agar Composer aur PHP installed hain:

```bash
cd backend
composer install
php artisan key:generate
php artisan migrate
php artisan db:seed
php artisan storage:link
php artisan serve
```

## ✅ Verification

Backend start hone ke baad:
- Open: http://localhost:8000
- Should see API response

## 🐛 If Issues

### Composer Not Found
- Install Composer first
- Add to PATH

### PHP Not Found
- Install XAMPP
- Or standalone PHP

### Database Error
- Check MySQL running
- Check .env credentials
- Create database in phpMyAdmin

---

**Ab Composer aur PHP install karo, phir commands run karo!** 🚀
