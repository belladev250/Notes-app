import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository_interface.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryInterface _authRepository;

  AuthBloc({required AuthRepositoryInterface authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthUserChanged>(_onAuthUserChanged);

    // Listen to auth state changes
    _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        add(AuthUserChanged(user));
      } else {
        add(AuthUserChanged(null));
      }
    });
  }

  void _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthSignInRequested(
      AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (user != null) {
        emit(AuthAuthenticated(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.createUserWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (user != null) {
        emit(AuthAuthenticated(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthSignOutRequested(
      AuthSignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
