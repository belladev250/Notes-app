/// Authentication Screen
/// 
/// Handles both sign-in and sign-up functionality with:
/// - Form validation for email and password
/// - Loading states during authentication
/// - Error handling and user feedback
/// - Toggle between sign-in and sign-up modes

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../notes/notes_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (_isSignUp) {
        context.read<AuthBloc>().add(
              AuthSignUpRequested(email: email, password: password),
            );
      } else {
        context.read<AuthBloc>().add(
              AuthSignInRequested(email: email, password: password),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackbar.showError(context, state.message);
          } else if (state is AuthAuthenticated) {
            CustomSnackbar.showSuccess(
              context,
              _isSignUp ? 'Account created successfully!' : 'Welcome back!',
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NotesListScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      const Icon(
                        Icons.note_alt_outlined,
                        size: 80,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _isSignUp ? 'Create Account' : 'Welcome Back',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: Validators.validatePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: state is AuthLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is AuthLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                _isSignUp ? 'Sign Up' : 'Sign In',
                                style: const TextStyle(fontSize: 16),
                              ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                                setState(() {
                                  _isSignUp = !_isSignUp;
                                });
                              },
                        child: Text(
                          _isSignUp
                              ? 'Already have an account? Sign In'
                              : 'Don\'t have an account? Sign Up',
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
