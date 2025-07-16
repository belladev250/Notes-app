import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAMHDG0adlHZjW-arr9v-SC5i6e28INn3o',
    appId: '1:178955885332:android:cc9130c78123626e3e4001',
    messagingSenderId: '178955885332',
    projectId: 'noteapp-3cbff',
    authDomain: 'noteapp-3cbff.firebaseapp.com',
    storageBucket: 'noteapp-3cbff.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMHDG0adlHZjW-arr9v-SC5i6e28INn3o',
    appId: '1:178955885332:android:cc9130c78123626e3e4001',
    messagingSenderId: '178955885332',
    projectId: 'noteapp-3cbff',
    storageBucket: 'noteapp-3cbff.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMHDG0adlHZjW-arr9v-SC5i6e28INn3o',
    appId: '1:178955885332:ios:cc9130c78123626e3e4001',
    messagingSenderId: '178955885332',
    projectId: 'noteapp-3cbff',
    storageBucket: 'noteapp-3cbff.firebasestorage.app',
    iosClientId: '178955885332-your-ios-client-id.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMHDG0adlHZjW-arr9v-SC5i6e28INn3o',
    appId: '1:178955885332:macos:cc9130c78123626e3e4001',
    messagingSenderId: '178955885332',
    projectId: 'noteapp-3cbff',
    storageBucket: 'noteapp-3cbff.firebasestorage.app',
    iosClientId: '178955885332-your-macos-client-id.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteapp',
  );
}