import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utilities/components/ht_buttons.dart';
import '../../utilities/components/ht_spacing.dart';
import '../../utilities/components/ht_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: HTButton.text(
                  label: 'Skip',
                  onPressed: () => context.go('/onboarding/final'),
                  trailingIcon: Icons.arrow_forward_ios,
                  size: ButtonSize.small,
                ),
              ),
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        isDarkMode
                            ? 'assets/logo/logo-dark.png'
                            : 'assets/logo/logo-light.png',
                        height: 90,
                        width: 90,
                      ),
                    ),

                    HTSpacing.verticalMD,

                    // Description
                    HTText.bodyLarge(
                      'Nigeria\'s first specialized platform connecting families with professionally trained domestic workers',
                      textAlign: TextAlign.center,
                    ),

                    HTSpacing.verticalXL,

                    // Feature icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureIcon(
                            context, Icons.verified_user_rounded, 'Safe'),
                        _buildFeatureIcon(
                            context, Icons.access_time_rounded, 'On-Demand'),
                        _buildFeatureIcon(
                            context, Icons.auto_awesome, 'Quality'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Navigation
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIndicator(context, isActive: true),
                      _buildIndicator(context, isActive: false),
                      _buildIndicator(context, isActive: false),
                    ],
                  ),

                  HTSpacing.verticalMD,

                  // Next button
                  HTButton.primary(
                    size: ButtonSize.large,
                    label: 'Next',
                    onPressed: () => context.go('/onboarding/user-type'),
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
        ),
        HTSpacing.verticalXS,
        HTText.bodySmall(label),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, {required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
