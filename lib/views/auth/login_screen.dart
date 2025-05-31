import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tender/utilities/theme/app_color.dart';

import '../../utilities/components/ht_buttons.dart';
import '../../utilities/components/ht_card.dart';
import '../../utilities/components/ht_spacing.dart';
import '../../utilities/components/ht_text.dart';
import '../../utilities/components/ht_text_field.dart';
import '../../utilities/router/app_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HTText.titleLarge('Sign In'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Logo and welcome text
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.home_filled,
                        color: AppColors.primaryBlue,
                        size: 60,
                      ),
                    ),
                    HTSpacing.verticalMD,
                    HTText.headlineMedium('Welcome Back'),
                    HTSpacing.verticalSM,
                    HTText.bodyMedium(
                      'Sign in to continue using HomeTender',
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),

              HTSpacing.verticalXL,

              // Login form
              HTCard(
                variant: CardVariant.filled,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HTTextField.email(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      label: 'Email Address',
                      hint: 'Enter your email address',
                    ),
                    HTSpacing.verticalMD,
                    HTTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: _showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixIconTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    HTSpacing.verticalMD,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember me checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                            HTText.bodyMedium('Remember me'),
                          ],
                        ),
                        // Forgot password button
                        TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                            // context.go('/forgot-password');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Forgot password feature coming soon!'),
                              ),
                            );
                          },
                          child: HTText.bodyMedium(
                            'Forgot Password?',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              HTSpacing.verticalXL,

              // Sign in button
              HTButton.primary(
                label: 'Sign In',
                isFullWidth: true,
                isLoading: _isLoading,
                onPressed: _handleLogin,
              ),

              HTSpacing.verticalMD,

              // Create account button
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HTText.bodyMedium('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: HTText.bodyMedium(
                        'Create Account',
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate login process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Mark onboarding as completed
      final router = ref.read(routerNotifierProvider);
      router.completeOnboarding();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home
      context.go('/');
    });
  }
}
