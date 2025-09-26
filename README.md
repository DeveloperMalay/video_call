# 📱 Flutter Video Call App

A comprehensive Flutter video calling application with Firebase WebRTC signaling, real-time messaging, and cross-platform support for Android and iOS.

## ✨ Features

- 🎥 **Real-time Video Calling** - High-quality peer-to-peer video calls using WebRTC
- 🔥 **Firebase Integration** - Firestore for signaling and real-time data synchronization
- 📱 **Cross-platform** - Works on both Android and iOS
- 🎛️ **Call Controls** - Mute/unmute audio, enable/disable video, switch camera, end call
- 👥 **User Management** - User authentication with persistent login
- 🔗 **Room-based Calls** - Create or join calls using unique room IDs
- 🎨 **Modern UI** - Clean, intuitive interface with Material Design 3
- 🌐 **Network Handling** - Automatic reconnection and network state management
- 📊 **State Management** - BLoC pattern for predictable state management
- 🔧 **Dependency Injection** - Clean architecture with GetIt and Injectable

## Architecture

The app follows **Clean Architecture** principles with three main layers:

### 1. Data Layer (`/lib/data`)
- **Models**: Data transfer objects with JSON serialization
- **Repositories**: Implementation of repository interfaces
- **Data Sources**: Remote (API) and Local (Hive) data sources

### 2. Domain Layer (`/lib/domain`)
- **Entities**: Core business objects
- **Repositories**: Abstract repository interfaces
- **Use Cases**: Business logic implementation

### 3. Presentation Layer (`/lib/presentation`)
- **Cubits**: State management using flutter_bloc
- **Pages**: UI screens/pages
- **Widgets**: Reusable UI components

### 4. Core (`/lib/core`)
- **Config**: App configuration and routing
- **Constants**: Application constants
- **Error**: Error handling and exceptions
- **Network**: Network connectivity utilities

## 🛠️ Tech Stack

### Core Technologies
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Firebase Firestore** - NoSQL database for signaling
- **WebRTC** - Real-time communication

### State Management
- **flutter_bloc** - Business Logic Component pattern
- **cubit** - Simplified BLoC for state management

### Dependency Injection
- **get_it** - Service locator
- **injectable** - Code generation for DI

### Networking & Storage
- **dio** - HTTP client
- **shared_preferences** - Local storage
- **hive** - Fast NoSQL database

### UI & Navigation
- **go_router** - Declarative routing
- **bot_toast** - Elegant toast notifications
- **flutter_svg** - SVG support
- **cached_network_image** - Image caching

### Development Tools
- **flutter_lints** - Official linting rules
- **build_runner** - Code generation
- **freezed** - Code generation for data classes
- **flutter_dotenv** - Environment variable management

## 📋 Prerequisites

Before running the app, ensure you have:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0.0 or higher)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Firebase CLI](https://firebase.google.com/docs/cli) (optional but recommended)
- Android SDK (API level 23+ for Android)
- Xcode 12.0+ (for iOS development)
- iOS 13.0+ target

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/video_call_app.git
cd video_call_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Option 1: Using Environment Variables (Recommended)

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Update `.env` with your Firebase configuration values:
   ```env
   FIREBASE_PROJECT_ID=your-project-id
   FIREBASE_MESSAGING_SENDER_ID=your-sender-id
   # ... other Firebase config values
   ```

#### Option 2: Using Firebase CLI

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Configure Flutter for Firebase:
   ```bash
   flutterfire configure
   ```

### 4. Set up Firestore Database

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project or select existing one
3. Navigate to **Firestore Database**
4. Click **"Create database"**
5. Choose **"Start in test mode"** for development
6. Select your preferred location

#### Firestore Security Rules (Development)

For testing purposes, use these rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

**⚠️ Important:** Update security rules for production deployment.

### 5. Configure Platform-Specific Settings

#### Android Configuration

1. Place your `google-services.json` in `android/app/`
2. Ensure minimum SDK version in `android/app/build.gradle`:
   ```gradle
   minSdkVersion 23
   targetSdkVersion 36
   ```

#### iOS Configuration

1. Place your `GoogleService-Info.plist` in `ios/Runner/`
2. Update iOS deployment target in `ios/Podfile`:
   ```ruby
   platform :ios, '13.0'
   ```

### 6. Permissions Setup

The app handles the following permissions automatically:

- **Camera** - For video calling
- **Microphone** - For audio during calls
- **Internet** - For network connectivity

Permissions are requested at runtime when needed.

### 7. Generate Code

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 🏃‍♂️ Running the App

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run in debug mode with hot reload
flutter run --debug

# Run on specific device
flutter run -d <device_id>
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 📱 How to Use

### 1. **Login**
   - Enter any email and password (demo authentication)
   - Credentials are stored locally using SharedPreferences

### 2. **Start a Video Call**
   - Tap the video call icon from the Users page
   - Enter your name and room ID
   - Click **"Create Call"** to start a new call
   - Or click **"Join Call"** to join an existing call

### 3. **Call Controls**
   - **🎤 Mute/Unmute** - Toggle audio on/off
   - **📹 Video** - Toggle video on/off
   - **🔄 Switch Camera** - Switch between front/rear camera
   - **📞 End Call** - Terminate the call and return to previous screen

### 4. **Sharing Call ID**
   - When creating a call, a unique Call ID is generated
   - Share this ID with others to join the call
   - Tap the info icon to view/copy the Call ID

## 🔧 Configuration

### Environment Variables

The app uses environment variables for Firebase configuration. Create a `.env` file with:

```env
# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_MESSAGING_SENDER_ID=your-sender-id
FIREBASE_STORAGE_BUCKET=your-project-id.firebasestorage.app
FIREBASE_AUTH_DOMAIN=your-project-id.firebaseapp.com

# Platform-specific API keys and App IDs
FIREBASE_ANDROID_API_KEY=your-android-api-key
FIREBASE_ANDROID_APP_ID=your-android-app-id
FIREBASE_IOS_API_KEY=your-ios-api-key
FIREBASE_IOS_APP_ID=your-ios-app-id
FIREBASE_IOS_BUNDLE_ID=your-ios-bundle-id
```

### Firebase Firestore Structure

The app uses the following Firestore structure:

```
calls/
├── {callId}/
│   ├── offer: {type, sdp}
│   ├── answer: {type, sdp}
│   ├── callerCandidates/
│   │   └── {candidateId}: {candidate, sdpMid, sdpMLineIndex}
│   └── calleeCandidates/
│       └── {candidateId}: {candidate, sdpMid, sdpMLineIndex}
```

## 🐛 Troubleshooting

### Common Issues

1. **Firebase Configuration Error**
   ```
   [core/duplicate-app] A Firebase App named "[DEFAULT]" already exists
   ```
   **Solution:** This is handled automatically in the code. Restart the app if persists.

2. **Firestore Unavailable Error**
   ```
   [cloud_firestore/unavailable] The service is currently unavailable
   ```
   **Solutions:**
   - Ensure Firestore database is created in Firebase Console
   - Check internet connectivity
   - Verify Firebase configuration values

3. **WebRTC Connection Issues**
   - Ensure both devices are on the same network or use STUN servers
   - Check camera and microphone permissions
   - Verify Firestore security rules allow read/write access

4. **Build Issues**
   ```
   The plugin "cloud_firestore" requires a higher minimum iOS deployment version
   ```
   **Solution:** Update `ios/Podfile` to use iOS 13.0+:
   ```ruby
   platform :ios, '13.0'
   ```

5. **Kotlin Version Error**
   ```
   Kotlin binary version is incompatible
   ```
   **Solution:** Update `android/settings.gradle.kts`:
   ```kotlin
   id("org.jetbrains.kotlin.android") version "2.1.0" apply false
   ```

### Debug Mode

Enable debug logs by running:
```bash
flutter run --debug
```

Check Firebase connection:
```bash
flutter logs | grep Firebase
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Guidelines

1. Follow the existing code structure and naming conventions
2. Write tests for new features
3. Update documentation for any changes
4. Use conventional commit messages
5. Ensure code passes linting: `flutter analyze`

### Commit Message Format

```
type(scope): description

feat: add video call functionality
fix: resolve Firebase connection issue  
docs: update README with setup instructions
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Firebase Team](https://firebase.google.com) for the backend services
- [WebRTC Community](https://webrtc.org) for real-time communication

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Search existing [GitHub Issues](https://github.com/yourusername/video_call_app/issues)
3. Create a new issue with detailed information

---

**Made with ❤️ using Flutter**
