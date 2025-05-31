import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tender/utilities/theme/app_color.dart';

import '../../utilities/components/ht_buttons.dart';
import '../../utilities/components/ht_card.dart';
import '../../utilities/components/ht_spacing.dart';
import '../../utilities/components/ht_text.dart';
import '../../utilities/router/app_router.dart';

class UserTypeScreen extends ConsumerWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUserType = ref.watch(userTypeProvider);

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
                    HTText.headlineLarge(
                      'I am a...',
                      textAlign: TextAlign.center,
                    ),

                    HTSpacing.verticalXL,

                    // Family option
                    HTCard(
                      variant: selectedUserType == UserType.family
                          ? CardVariant.elevated
                          : CardVariant.outlined,
                      borderRadius: 16,
                      onTap: () {
                        ref.read(userTypeProvider.notifier).state =
                            UserType.family;
                      },
                      elevation: selectedUserType == UserType.family ? 4 : 0,
                      backgroundColor: selectedUserType == UserType.family
                          ? Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                          : null,
                      borderColor: selectedUserType == UserType.family
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.family_restroom,
                                color: AppColors.primaryBlue,
                                size: 32,
                              ),
                            ),
                            HTSpacing.horizontalMD,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HTText.titleLarge('Family / Client'),
                                  HTSpacing.verticalXS,
                                  HTText.bodyMedium(
                                    'Looking to hire professional domestic help',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                            if (selectedUserType == UserType.family)
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                          ],
                        ),
                      ),
                    ),

                    HTSpacing.verticalMD,

                    // Worker option
                    HTCard(
                      variant: selectedUserType == UserType.worker
                          ? CardVariant.elevated
                          : CardVariant.outlined,
                      borderRadius: 16,
                      onTap: () {
                        ref.read(userTypeProvider.notifier).state =
                            UserType.worker;
                      },
                      elevation: selectedUserType == UserType.worker ? 4 : 0,
                      backgroundColor: selectedUserType == UserType.worker
                          ? Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                          : null,
                      borderColor: selectedUserType == UserType.worker
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.secondaryOrange.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.cleaning_services,
                                color: AppColors.secondaryOrange,
                                size: 32,
                              ),
                            ),
                            HTSpacing.horizontalMD,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HTText.titleLarge('Domestic Worker'),
                                  HTSpacing.verticalXS,
                                  HTText.bodyMedium(
                                    'Looking for work as a nanny or house helper',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                            if (selectedUserType == UserType.worker)
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                          ],
                        ),
                      ),
                    ),

                    HTSpacing.verticalXL,

                    HTText.bodyMedium(
                      'You can always change this later in settings',
                      textAlign: TextAlign.center,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                      _buildIndicator(context, isActive: false),
                      _buildIndicator(context, isActive: true),
                      _buildIndicator(context, isActive: false),
                    ],
                  ),

                  HTSpacing.verticalMD,

                  // Next button
                  HTButton.primary(
                    size: ButtonSize.large,
                    label: 'Next',
                    onPressed: selectedUserType == null
                        ? null // Disable if no user type is selected
                        : () => context.go('/onboarding/features'),
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
