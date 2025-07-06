import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/firebase_options.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/notes_bloc.dart';
import 'repositories/auth_repository.dart';
import 'repositories/notes_repository.dart';
import 'screens/auth_screen.dart';
import 'screens/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) =>
              LocalAuthRepository(), // Use concrete implementation
        ),
        RepositoryProvider<NotesRepository>(
          create: (context) =>
              LocalNotesRepository(), // Use concrete implementation
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>())
                  ..add(AuthStarted()),
          ),
        ],
        child: MaterialApp(
          title: 'Notes App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const AuthWrapper(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print('AuthWrapper state: ${state.runtimeType}');

        if (state is AuthAuthenticated) {
          return BlocProvider<NotesBloc>(
            create: (context) =>
                NotesBloc(notesRepository: context.read<NotesRepository>())
                  ..add(FetchNotes()),
            child: const NotesScreen(),
          );
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Authentication Error',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthStarted());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          // AuthInitial, AuthUnauthenticated, or any other state
          return const AuthScreen();
        }
      },
    );
  }
}
