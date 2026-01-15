# Backend Quick Setup - Step by Step

## 🚀 Fastest Way (Automated Script)

### Windows PowerShell:
```powershell
cd backend
.\SETUP_BACKEND.ps1
```

### Windows CMD:
```cmd
cd backend
SETUP_BACKEND.bat
```

## 📋 Manual Setup (Agar Script Kaam Na Kare)

### Step 1: Install Composer (Agar nahi hai)

**Download:** https://getcomposer.org/download/

**Windows:**
- `Composer-Setup.exe` download karo
- Install karo
- Verify: `composer --version`

### Step 2: Install Dependencies

```bash
cd backend
composer install
```

**Agar composer nahi hai:**
- Pehle composer install karo (Step 1)

### Step 3: Create .env File

```bash
# Copy from example
copy .env.example .env

# Ya manually create karo
```

**Edit `.env` file:**
```env
DB_DATABASE=plant_layout
DB_USERNAME=root
DB_PASSWORD=your_mysql_password
```

### Step 4: Generate App Key

```bash
php artisan key:generate
```

### Step 5: Create Database

**Option A: phpMyAdmin**
1. Open: http://localhost/phpmyadmin
2. "New" click karo
3. Database name: `plant_layout`
4. Collation: `utf8mb4_unicode_ci`
5. "Create" click karo

**Option B: MySQL Command Line**
```bash
mysql -u root -p
```
```sql
CREATE DATABASE plant_layout CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
```

### Step 6: Run Migrations

```bash
php artisan migrate
```

### Step 7: Seed Database (Optional)

```bash
php artisan db:seed
```

Creates:
- Admin: `admin@example.com` / `password`
- User: `user@example.com` / `password`
- Sample data

### Step 8: Create Storage Link

```bash
php artisan storage:link
```

### Step 9: Start Server

```bash
php artisan serve
```

**Backend ab `http://localhost:8000` par chalega!**

## ✅ Verify

Browser mein: `http://localhost:8000`

Agar response mil jaye to sab theek hai!

## 🐛 Common Issues

### "composer: command not found"
- Composer install karo
- PATH check karo

### "PHP not found"
- PHP install karo
- XAMPP use karo

### "Database connection refused"
- MySQL running hai check karo
- `.env` credentials check karo

### "Migration failed"
```bash
php artisan migrate:fresh
php artisan db:seed
```

## 📋 Checklist

- [ ] Composer installed
- [ ] `composer install` done
- [ ] `.env` file created
- [ ] `APP_KEY` generated
- [ ] Database `plant_layout` created
- [ ] Migrations run
- [ ] Database seeded (optional)
- [ ] Storage link created
- [ ] Server started

## 🎯 Next

Backend start hone ke baad:
1. Frontend configure karo
2. App run karo
3. Test karo!

---

**Setup complete hone ke baad batao!** 🚀
