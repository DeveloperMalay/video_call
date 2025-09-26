import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../core/config/app_router.dart';
import '../../injection_container.dart';
import '../cubit/auth/auth_cubit.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(
          loginUser: sl(),
          authStorageService: sl(),
        ),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {
                BotToast.showLoading();
              },
              authenticated: (auth) {
                BotToast.closeAllLoading();
                context.go(AppRouter.users);
              },
              unauthenticated: () {
                BotToast.closeAllLoading();
              },
              error: (message) {
                BotToast.closeAllLoading();
                BotToast.showText(
                  text: message,
                  contentColor: Colors.red,
                  textStyle: const TextStyle(color: Colors.white),
                );
              },
            );
          },
          child: Container(
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
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
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
                              const Text(
                                'Enter any valid email and password',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 24),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return CustomButton(
                                    onPressed: state.maybeWhen(
                                      loading: () => null,
                                      orElse: () => () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthCubit>().login(
                                                _emailController.text,
                                                _passwordController.text,
                                              );
                                        }
                                      },
                                    ),
                                    text: 'Sign In',
                                    isLoading: false,
                                  );
                                },
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
        ),
      ),
    );
  }
}
