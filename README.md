# 📝 Notes App

A modern Flutter notes application with Firebase backend, featuring user authentication and real-time note synchronization.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

- 🔐 **User Authentication** - Sign up, sign in, and secure logout
- 📝 **Note Management** - Create, edit, delete, and view notes
- ☁️ **Cloud Sync** - Real-time synchronization with Firebase Firestore
- 🎨 **Modern UI** - Clean Material Design interface
- 🔄 **State Management** - BLoC pattern for predictable state handling
- ✅ **Form Validation** - Email and password validation
- 📱 **Cross Platform** - Runs on Android, iOS, Web, Windows, macOS, and Linux

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── 🎯 core/                    # Core utilities and widgets
│   ├── utils/                 # Validation and utility functions
│   └── widgets/               # Reusable UI components
├── 📊 data/                   # Data layer
│   ├── models/                # Data models
│   ├── repositories/          # Repository implementations
│   └── services/              # External services (Firebase)
├── 🏛️ domain/                 # Business logic layer
│   ├── entities/              # Domain entities
│   └── repositories/          # Repository interfaces
└── 🎨 presentation/           # UI layer
    ├── bloc/                  # State management (BLoC)
    │   ├── auth/              # Authentication BLoC
    │   └── notes/             # Notes BLoC
    ├── screens/               # App screens
    │   ├── auth/              # Authentication screens
    │   ├── notes/             # Notes screens
    │   └── splash/            # Splash screen
    └── widgets/               # Screen-specific widgets
```

### 🔄 Architecture Flow

The app follows a unidirectional data flow:
1. **UI Events** → BLoC Events
2. **BLoC** → Repository Interface
3. **Repository** → Firebase Services
4. **Data** flows back through the same layers

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Firebase project

### 📱 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/twizelissa/noteapp_new.git
   cd noteapp_new
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase** (see Firebase Configuration below)

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔥 Firebase Configuration

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `noteapp-3cbff` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

### Step 2: Add Firebase to Your App

#### For Android:
1. Click "Add app" and select Android
2. Enter package name: `com.example.noteapp`
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### For iOS:
1. Click "Add app" and select iOS
2. Enter bundle ID: `com.example.noteapp`
3. Download `GoogleService-Info.plist`
4. Add it to `ios/Runner/` directory

#### For Web:
1. Click "Add app" and select Web
2. Register your app with a nickname
3. Copy the Firebase config object

### Step 3: Enable Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" provider
5. Click "Save"

### Step 4: Set up Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location close to your users
5. Click "Done"

### Step 5: Configure Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own notes
    match /notes/{document} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.userId;
    }
  }
}
```

### Step 6: Update Firebase Options

The Firebase configuration is already set up in `lib/firebase_options.dart`. Update the values with your project details if needed.

## 🏃‍♂️ Running the App

### Development Mode
```bash
# Run on connected device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run on Android emulator
flutter run -d emulator-5554

# Run on Linux desktop
flutter run -d linux
```

### Build for Production
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc**: State management with BLoC pattern
- **firebase_core**: Firebase initialization
- **firebase_auth**: User authentication
- **cloud_firestore**: NoSQL database
- **equatable**: Value equality for Dart objects

### Dev Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Dart code analysis and linting

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📁 Project Structure

```
noteapp_new/
├── android/                   # Android-specific files
├── ios/                       # iOS-specific files
├── lib/                       # Main Dart code
│   ├── core/                  # Core utilities and widgets
│   ├── data/                  # Data layer (repositories, models, services)
│   ├── domain/                # Domain layer (entities, interfaces)
│   ├── presentation/          # UI layer (screens, widgets, BLoC)
│   ├── firebase_options.dart  # Firebase configuration
│   └── main.dart             # App entry point
├── test/                      # Unit tests
├── web/                       # Web-specific files
├── windows/                   # Windows-specific files
├── linux/                     # Linux-specific files
├── macos/                     # macOS-specific files
├── pubspec.yaml              # Project dependencies
├── README.md                 # This file
└── .gitignore               # Git ignore rules
```

## 🎨 UI/UX Features

- **Material Design 3** - Modern design system
- **Responsive Layout** - Adapts to different screen sizes
- **Loading States** - Visual feedback during operations
- **Error Handling** - User-friendly error messages
- **Form Validation** - Real-time input validation
- **Smooth Animations** - Enhanced user experience
- **Splash Screen** - Professional app startup

## 🔧 Development Guidelines

### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper error handling

### Git Workflow
1. Create feature branches from `master`
2. Make small, focused commits
3. Write clear commit messages
4. Test before pushing
5. Create pull requests for review

## 🚀 Deployment

### Android (Google Play Store)
1. Update `pubspec.yaml` version
2. Build release APK: `flutter build appbundle --release`
3. Upload to Google Play Console
4. Fill in store listing details
5. Submit for review

### iOS (App Store)
1. Update version in `pubspec.yaml`
2. Build iOS: `flutter build ios --release`
3. Open in Xcode and archive
4. Upload to App Store Connect
5. Submit for review

### Web (Firebase Hosting)
1. Build web version: `flutter build web --release`
2. Install Firebase CLI: `npm install -g firebase-tools`
3. Initialize hosting: `firebase init hosting`
4. Deploy: `firebase deploy`

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 👨‍💻 Author

**twizelissa**
- GitHub: [@twizelissa](https://github.com/twizelissa)
- Email: twizelissa@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the backend services
- The Dart and Flutter community for continuous support

## 📞 Support

If you have any questions or need help with setup, feel free to:
- Open an issue on GitHub
- Contact me via email
- Check the Flutter documentation

---

⭐ **Star this repository if you found it helpful!**
