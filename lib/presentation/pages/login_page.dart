import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../core/config/app_router.dart';
import '../../core/services/firebase_auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _authService = FirebaseAuthService();
  
  bool _isLoading = false;
  bool _isSignUpMode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (_isSignUpMode && (value == null || value.isEmpty)) {
      return 'Please enter your name';
    }
    return null;
  }

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    BotToast.showLoading();

    try {
      if (_isSignUpMode) {
        await _authService.signUpWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
          _nameController.text.trim(),
        );
        BotToast.showText(
          text: 'Account created successfully!',
          textStyle: const TextStyle(color: Colors.white),
          contentColor: Colors.green,
        );
      } else {
        await _authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );
      }
      
      // Navigate to users page on success
      if (mounted) {
        context.go(AppRouter.users);
      }
    } catch (e) {
      BotToast.showText(
        text: e.toString(),
        textStyle: const TextStyle(color: Colors.white),
        contentColor: Colors.red,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
        BotToast.closeAllLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.video_call,
                  size: 80,
                  color: Colors.white,
                ),
                Text(
                  _isSignUpMode ? 'Create Account' : 'Welcome Back',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _isSignUpMode ? 'Sign up to get started' : 'Sign in to continue',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_isSignUpMode) ...[
                            CustomTextField(
                              controller: _nameController,
                              label: 'Full Name',
                              keyboardType: TextInputType.name,
                              validator: _validateName,
                            ),
                            const SizedBox(height: 16),
                          ],
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            obscureText: true,
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isSignUpMode 
                                ? 'Password must be at least 6 characters'
                                : 'Use your Firebase account credentials',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            onPressed: _isLoading ? null : _handleAuth,
                            text: _isSignUpMode ? 'Sign Up' : 'Sign In',
                            isLoading: _isLoading,
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSignUpMode = !_isSignUpMode;
                                _nameController.clear();
                                _emailController.clear();
                                _passwordController.clear();
                              });
                            },
                            child: Text(
                              _isSignUpMode 
                                  ? 'Already have an account? Sign In'
                                  : 'Don\'t have an account? Sign Up',
                              style: const TextStyle(
                                color: Color(0xFF667eea),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
