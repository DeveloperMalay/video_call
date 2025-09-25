# Video Call App

A Flutter application with real-time video calling capabilities using Amazon Chime SDK, built with clean architecture principles.

## Features

- **Authentication & Login**: Simple login screen with email/password validation
- **Video Calling**: One-to-one video calls using Amazon Chime SDK
- **User Management**: Fetch and display users from REST API with offline caching
- **Clean Architecture**: Well-structured codebase with separation of concerns
- **State Management**: Cubit for reactive state management
- **Dependency Injection**: get_it for dependency management
- **Offline Support**: Local caching with Hive database
- **Permissions**: Proper camera and microphone permission handling

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

## Technologies Used

- **Flutter**: Cross-platform mobile development
- **Amazon Chime SDK**: Video calling functionality (Custom Method Channel implementation)
- **Cubit**: State management (flutter_bloc)
- **go_router**: Navigation and routing
- **get_it**: Dependency injection
- **injectable**: Code generation for DI
- **freezed**: Immutable data classes
- **Hive**: Local database for caching
- **Dio**: HTTP client for API calls
- **Dartz**: Functional programming utilities

## Requirements

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

## Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd video_call_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 4. Configure Amazon Chime SDK
The app uses a custom Method Channel implementation that communicates with native Amazon Chime SDKs on both Android and iOS platforms.

**Current Implementation**: 
- Method Channel bridge is implemented and ready
- Native code stubs are in place for both platforms
- Actual Chime SDK integration is commented out but ready to be enabled

**To Enable Full Chime SDK Integration**:

#### Android:
1. Uncomment the Chime SDK dependencies in `android/app/build.gradle.kts`:
   ```kotlin
   implementation 'com.amazonaws:amazon-chime-sdk-media:0.17.2'
   implementation 'com.amazonaws:amazon-chime-sdk:0.17.2'
   ```

2. Uncomment the Chime SDK code in `android/app/src/main/kotlin/.../ChimeSDKPlugin.kt`

#### iOS:
1. Add Chime SDK to your `ios/Podfile`:
   ```ruby
   pod 'AmazonChimeSDK', '~> 0.17.2'
   pod 'AmazonChimeSDKMedia', '~> 0.17.2'
   ```

2. Uncomment the Chime SDK code in `ios/Runner/ChimeSDKPlugin.swift`

**Production Requirements**:
- Set up Amazon Chime SDK backend service for meeting management
- Configure proper authentication with AWS
- Implement meeting creation and attendee management APIs

## Running the App

### Development Mode
```bash
flutter run
```

### Debug Mode
```bash
flutter run --debug
```

### Release Mode
```bash
flutter run --release
```

## API Configuration

The app uses [ReqRes API](https://reqres.in/) for demonstration:

- **Base URL**: `https://reqres.in/api/`
- **Login Endpoint**: `POST /login`
- **Users Endpoint**: `GET /users`

### Test Credentials
- **Email**: `test@gmail.com`
- **Password**: `test@1234`

**Alternative ReqRes API Credentials** (also supported):
- **Email**: `eve.holt@reqres.in`
- **Password**: `cityslicka`

## Features Overview

### 1. Authentication Flow
- Clean login UI with validation
- Mock authentication using ReqRes API
- Token-based session management
- Local auth caching with Hive

### 2. Video Calling
- Amazon Chime SDK integration
- One-to-one video calls
- Audio/video controls (mute/unmute, enable/disable video)
- Permission handling for camera and microphone
- Hardcoded meeting ID for demo purposes

### 3. Users Management
- Fetch users from REST API
- Offline caching support
- Pull-to-refresh functionality
- Error handling with fallback to cached data

### 4. Offline Support
- Hive local database for data persistence
- Network connectivity detection
- Automatic fallback to cached data when offline

## Permissions

### Android
The following permissions are configured in `android/app/src/main/AndroidManifest.xml`:
- Camera access
- Microphone access
- Internet connectivity
- Network state access
- Audio settings modification

### iOS
The following permissions are configured in `ios/Runner/Info.plist`:
- Camera usage description
- Microphone usage description

## Build Configuration

### Android
- **Min SDK**: 21
- **Target SDK**: 34
- **Compile SDK**: 34

### iOS
- **Min iOS Version**: 11.0
- **Target iOS Version**: 16.0

## Testing

Run tests using:
```bash
flutter test
```

## Building for Release

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Known Limitations

1. **Amazon Chime SDK**: Method Channel implementation is ready but actual native SDK integration is commented out for demo purposes
2. **Meeting Management**: Hardcoded meeting ID for demonstration
3. **Video Rendering**: Video streams are simulated in the UI (actual video rendering requires enabling native SDK code)
4. **Backend Integration**: No real backend service for meeting creation/management
5. **Authentication**: Uses mock API (ReqRes) for demonstration

## Future Enhancements

1. **Real Backend Integration**: Implement proper Amazon Chime SDK backend service
2. **Dynamic Meeting Creation**: Allow users to create and join custom meetings
3. **Push Notifications**: Implement incoming call notifications
4. **Group Calling**: Support for multi-participant video calls
5. **Screen Sharing**: Full screen sharing implementation
6. **Recording**: Meeting recording functionality
7. **Chat**: In-call text messaging
8. **Contact Management**: User contact management system

## Troubleshooting

### Common Issues

1. **Build Runner Issues**
   ```bash
   flutter packages pub run build_runner clean
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

2. **Permission Denied**
   - Ensure camera/microphone permissions are granted
   - Check platform-specific permission configurations

3. **Network Issues**
   - Verify internet connectivity
   - Check API endpoints are accessible

4. **Dependency Conflicts**
   ```bash
   flutter clean
   flutter pub get
   ```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: This is a demonstration project showcasing Flutter development best practices with clean architecture, video calling integration, and modern state management patterns.
