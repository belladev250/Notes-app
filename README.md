# 📝 Notes App

A simple cross-platform Flutter notes app using Firebase for authentication and real-time sync. Clean UI, Firebase backend, and smooth note management.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

- Sign up / Sign in with Firebase
- Create, update, and delete notes
- Real-time sync across devices
- Clean Material UI
- BLoC state management

## 🛠 Setup

```bash
git clone https://github.com/belladev250/noteapp_new.git
cd noteapp_new
flutter pub get
flutter run
```

> 🔐 Don’t forget to set up Firebase and include the config files (`google-services.json` or `GoogleService-Info.plist`) in your project.

## 📂 Project Structure

```
lib/
├── core/
├── data/
├── domain/
└── presentation/
```

## 🚀 Build Commands

```bash
flutter build apk --release       # Android
flutter build ios --release       # iOS
flutter build web --release       # Web
```

## 👩‍💻 Author

**Melissa Ineza**  
GitHub: [@belladev250](https://github.com/belladev250)  
Email: melissaineza8@gmail.com
