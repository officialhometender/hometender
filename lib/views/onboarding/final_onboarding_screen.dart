import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tender/utilities/router/app_router.dart';
import 'package:home_tender/utilities/theme/app_color.dart';

import '../../utilities/components/ht_buttons.dart';
import '../../utilities/components/ht_spacing.dart';
import '../../utilities/components/ht_text.dart';

class FinalScreen extends ConsumerWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with background
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? AppColors.surfaceDark : AppColors.aliceBlue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.home_rounded,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              HTSpacing.verticalXL,

              HTText.headlineLarge(
                'Ready to Get Started!',
                textAlign: TextAlign.center,
              ),

              HTSpacing.verticalMD,

              HTText.bodyLarge(
                userType == UserType.family
                    ? 'Create your account to find reliable domestic help for your home'
                    : userType == UserType.worker
                        ? 'Create your account to find great job opportunities'
                        : 'Create your account to experience HomeTender',
                textAlign: TextAlign.center,
              ),

              HTSpacing.verticalXXL,

              // Sign up button
              HTButton.primary(
                label: 'Create Account',
                onPressed: () {
                  // Mark onboarding as completed
                  final routerNotifier = ref.read(routerNotifierProvider);
                  routerNotifier.completeOnboarding();

                  // Navigate to registration
                  context.go('/register');
                },
                isFullWidth: true,
                size: ButtonSize.large,
              ),

              HTSpacing.verticalMD,

              // Login button
              HTButton.outline(
                label: 'Already have an account? Login',
                onPressed: () {
                  // Mark onboarding as completed
                  final routerNotifier = ref.read(routerNotifierProvider);
                  routerNotifier.completeOnboarding();

                  // Navigate to login
                  context.go('/login');
                },
                isFullWidth: true,
              ),

              const Spacer(),

              // Terms & privacy
              HTText.bodySmall(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
