# Frontend Status ✅

## Flutter App Running!

The Flutter application is now starting up.

### Configuration

**API URL:** `http://10.0.2.2:8000/api` (Android Emulator)
- Agar physical device use kar rahe ho, to `api_constants.dart` mein apni computer ka IP set karo

### App Features

✅ **Authentication**
- Login/Register screens
- Token-based authentication

✅ **Navigation**
- Projects → Units → Scenarios
- Sidebar navigation

✅ **Map Features**
- Leaflet Maps integration
- Layout image upload
- Equipment item placement
- Escape route drawing
- Risk zone creation
- Layer visibility controls

✅ **Other Tabs**
- Text editor
- Document upload
- Editable tables

### Default Login

- **Email:** admin@example.com
- **Password:** password

### If App Doesn't Start

1. **Check Device:**
   ```bash
   flutter devices
   ```

2. **Run on Specific Device:**
   ```bash
   flutter run -d <device-id>
   ```

3. **For Android Emulator:**
   - Android Studio se emulator start karo
   - Phir `flutter run` karo

4. **For Physical Device:**
   - USB debugging enable karo
   - Device connect karo
   - `flutter run` karo

### API URL Configuration

Agar physical device use kar rahe ho:

1. Apni computer ka IP find karo:
   ```bash
   ipconfig
   # IPv4 Address dekho (e.g., 192.168.1.100)
   ```

2. `frontend/lib/core/constants/api_constants.dart` edit karo:
   ```dart
   static const String baseUrl = 'http://192.168.1.100:8000/api';
   ```

3. App restart karo

---

**Frontend is ready!** 🚀
