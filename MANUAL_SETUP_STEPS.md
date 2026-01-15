# Manual Setup Steps - Abhi Run Karo

## XAMPP Path Find Karo

1. XAMPP Control Panel open karo
2. Ya XAMPP folder kholo
3. PHP path note karo (usually: `C:\xampp\php\php.exe`)

## Composer Check Karo

PowerShell mein run karo:
```powershell
composer --version
```

Agar nahi mila, to install karo: https://getcomposer.org/download/

## Ab Ye Commands Run Karo

### Step 1: Backend Directory Mein Jao
```powershell
cd C:\Users\ah516\Desktop\apk\backend
```

### Step 2: Composer Install (Agar Composer PATH mein hai)
```powershell
composer install
```

**Ya agar Composer specific path mein hai:**
```powershell
& "C:\Users\YourName\AppData\Local\ComposerSetup\bin\composer.bat" install
```

### Step 3: PHP Path Se App Key Generate Karo
```powershell
# XAMPP PHP path use karo (apna path replace karo)
& "C:\xampp\php\php.exe" artisan key:generate
```

### Step 4: Database Create Karo
1. XAMPP Control Panel mein MySQL start karo
2. Browser mein: http://localhost/phpmyadmin
3. "New" click karo
4. Database name: `plant_layout`
5. Collation: `utf8mb4_unicode_ci`
6. "Create" click karo

### Step 5: Migrations Run Karo
```powershell
& "C:\xampp\php\php.exe" artisan migrate
```

### Step 6: Seed Database (Optional)
```powershell
& "C:\xampp\php\php.exe" artisan db:seed
```

### Step 7: Storage Link
```powershell
& "C:\xampp\php\php.exe" artisan storage:link
```

### Step 8: Server Start Karo
```powershell
& "C:\xampp\php\php.exe" artisan serve
```

## Quick Script (Apna Path Replace Karo)

PowerShell mein ye run karo (apne paths replace karo):

```powershell
cd C:\Users\ah516\Desktop\apk\backend

# Set your paths here
$phpPath = "C:\xampp\php\php.exe"  # Apna XAMPP path
$composerPath = "composer"  # Ya full path to composer.bat

# Install dependencies
& $composerPath install

# Generate key
& $phpPath artisan key:generate

# Migrations
& $phpPath artisan migrate

# Seed
& $phpPath artisan db:seed

# Storage link
& $phpPath artisan storage:link

# Start server
& $phpPath artisan serve
```

## Agar XAMPP Path Pata Hai

Mujhe batao XAMPP kahan install hai, main script update kar dunga!

---

**XAMPP path batao, main script ready kar dunga!** 🚀
