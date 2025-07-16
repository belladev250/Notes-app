/// Flutter Notes App
/// 
/// A modern notes application with Firebase backend featuring:
/// - User authentication with Firebase Auth
/// - Real-time note synchronization with Cloud Firestore
/// - Clean Architecture with BLoC state management
/// - Cross-platform support (Android, iOS, Web, Desktop)
/// 
/// Author: twizelissa
/// Email: twizelissa@gmail.com

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/notes_repository.dart';
import 'data/services/firebase_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/notes/notes_bloc.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseService.initializeFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => NotesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(AuthCheckRequested()),
          ),
          BlocProvider(
            create: (context) => NotesBloc(
              notesRepository: context.read<NotesRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Notes App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
