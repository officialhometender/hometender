import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_color.dart';
import '../../../../routes/route_constants.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/validators.dart';

// State providers for the login form
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final isLoadingProvider = StateProvider<bool>((ref) => false);
final rememberMeProvider = StateProvider<bool>((ref) => false);

// State providers for field validation status - start with null (no validation state)
final emailValidProvider = StateProvider<bool?>((ref) => null);
final passwordValidProvider = StateProvider<bool?>((ref) => null);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // Controllers for the form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Focus nodes to track field focus state
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listeners to focus nodes to handle validation only when focus changes
    _emailFocusNode.addListener(_handleEmailFocusChange);
    _passwordFocusNode.addListener(_handlePasswordFocusChange);
  }

  @override
  void dispose() {
    // Clean up controllers and focus nodes
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.removeListener(_handleEmailFocusChange);
    _passwordFocusNode.removeListener(_handlePasswordFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // Handle email field focus changes
  void _handleEmailFocusChange() {
    if (!_emailFocusNode.hasFocus) {
      // Only validate when losing focus and field has been touched
      if (_emailController.text.isNotEmpty) {
        final errorMessage = Validators.validateEmail(_emailController.text);
        ref.read(emailValidProvider.notifier).state = errorMessage == null;
      }
    }
  }

  // Handle password field focus changes
  void _handlePasswordFocusChange() {
    if (!_passwordFocusNode.hasFocus) {
      // Only validate when losing focus and field has been touched
      if (_passwordController.text.isNotEmpty) {
        final isValid = _passwordController.text.isNotEmpty;
        ref.read(passwordValidProvider.notifier).state = isValid;
      }
    }
  }

  // Process login attempt
  void _handleLogin() {
    // Unfocus to dismiss keyboard
    FocusScope.of(context).unfocus();

    // Validate the form
    if (_formKey.currentState!.validate()) {
      // Show loading state
      ref.read(isLoadingProvider.notifier).state = true;

      // Simulate API call with delay
      Future.delayed(const Duration(seconds: 2), () {
        // Reset loading state
        ref.read(isLoadingProvider.notifier).state = false;

        // Navigate to home on success
        context.go(RouteConstants.home);
      });
    } else {
      // Update validation states
      final emailError = Validators.validateEmail(_emailController.text);
      final passwordError = _passwordController.text.isEmpty;

      ref.read(emailValidProvider.notifier).state = emailError == null;
      ref.read(passwordValidProvider.notifier).state = !passwordError;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check for dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Color selection based on theme
    final titleColor = isDarkMode ? Colors.white : AppColors.gray600;
    final forgotPasswordColor =
        isDarkMode ? AppColors.jasmine500 : AppColors.primary600;
    final signUpColor = isDarkMode ? AppColors.guppie400 : AppColors.primary600;

    // Choose button style for each theme
    final buttonVariant =
        isDarkMode ? ButtonVariant.secondary : ButtonVariant.primary;

    // For dark mode, we need to customize the text style to ensure black text
    final buttonTextStyle = isDarkMode
        ? const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)
        : null; // Use default style for light mode

    // Watch state from providers
    final isLoading = ref.watch(isLoadingProvider);
    final rememberMe = ref.watch(rememberMeProvider);
    final isEmailValid = ref.watch(emailValidProvider);
    final isPasswordValid = ref.watch(passwordValidProvider);

    return GestureDetector(
      // Add unfocus on tap outside
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // No app bar as requested
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                // Disable auto-validation to prevent premature error messages
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    AppText.h2(
                      'Sign in to your account',
                      color: titleColor, // Using theme-aware color
                    ),

                    AppSpacing.verticalXL(),

                    // Email field with custom error handling
                    AppTextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      label: 'Email',
                      hint: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined),
                      // Only show error when explicitly set to false
                      errorText: isEmailValid == false
                          ? Validators.validateEmail(_emailController.text)
                          : null,
                      validator: (value) {
                        // For form validation, but error display controlled separately
                        return Validators.validateEmail(value);
                      },
                      onChanged: (value) {
                        ref.read(emailProvider.notifier).state = value;
                        // Reset validation state when user types
                        ref.read(emailValidProvider.notifier).state = null;
                      },
                    ),

                    AppSpacing.verticalXL(),

                    // Password field with custom error handling
                    AppTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      label: 'Password',
                      hint: 'Enter your password',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outline),
                      // Only show error when explicitly set to false
                      errorText: isPasswordValid == false
                          ? 'Please enter your password'
                          : null,
                      validator: (value) {
                        // For form validation, but error display controlled separately
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref.read(passwordProvider.notifier).state = value;
                        // Reset validation state when user types
                        ref.read(passwordValidProvider.notifier).state = null;
                      },
                    ),

                    const SizedBox(height: 8),

                    // Remember me and forgot password row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember me checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                ref.read(rememberMeProvider.notifier).state =
                                    value ?? false;
                              },
                              activeColor: isDarkMode
                                  ? AppColors.guppie500
                                  : AppColors.primary600,
                            ),
                            AppText(
                              'Remember me',
                              size: TextSize.sm,
                              color: isDarkMode
                                  ? Colors.white
                                  : null, // Explicit white in dark mode
                            ),
                          ],
                        ),

                        // Forgot password link
                        TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: AppText(
                            'Forgot password?',
                            size: TextSize.sm,
                            color: forgotPasswordColor,
                            // Using theme-aware color
                            weight: TextWeight.medium,
                          ),
                        ),
                      ],
                    ),

                    AppSpacing.verticalXL(),

                    // Login button using component
                    AppButton(
                      text: 'Sign In',
                      onPressed: isLoading ? null : _handleLogin,
                      isLoading: isLoading,
                      variant: buttonVariant,
                      size: ButtonSize.large,
                      textStyle:
                          buttonTextStyle, // Apply custom text style for dark mode
                    ),

                    const SizedBox(height: 16),

                    // Sign up link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            'Don\'t have an account? ',
                            size: TextSize.sm,
                            color: isDarkMode
                                ? Colors.white
                                : null, // Explicit white in dark mode
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to signup
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: AppText(
                              'Sign Up',
                              size: TextSize.sm,
                              color: signUpColor, // Using theme-aware color
                              weight: TextWeight.semiBold,
                            ),
                          ),
                        ],
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
