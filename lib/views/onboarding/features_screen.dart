import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tender/utilities/theme/app_color.dart';

import '../../utilities/components/ht_buttons.dart';
import '../../utilities/components/ht_spacing.dart';
import '../../utilities/components/ht_text.dart';
import '../../utilities/router/app_router.dart';

class FeaturesScreen extends ConsumerWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeProvider);
    final features = userType == UserType.family
        ? _getFamilyFeatures()
        : _getWorkerFeatures();

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
                      userType == UserType.family
                          ? 'What You\'ll Love'
                          : 'How HomeTender Helps You',
                      textAlign: TextAlign.center,
                    ),
                    HTSpacing.verticalXL,
                    Expanded(
                      child: ListView.separated(
                        itemCount: features.length,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            HTSpacing.verticalMD,
                        itemBuilder: (context, index) {
                          final feature = features[index];
                          return _buildFeatureItem(
                            context,
                            icon: feature.icon,
                            title: feature.title,
                            description: feature.description,
                            color: feature.color,
                          );
                        },
                      ),
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
                      _buildIndicator(context, isActive: false),
                      _buildIndicator(context, isActive: true),
                    ],
                  ),

                  HTSpacing.verticalMD,

                  // Next button
                  HTButton.primary(
                    size: ButtonSize.large,
                    label: 'Get Started',
                    onPressed: () => context.go('/onboarding/final'),
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

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        HTSpacing.horizontalMD,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HTText.titleMedium(title),
              HTSpacing.verticalXS,
              HTText.bodyMedium(
                description,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
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

  // Features for family/client users
  List<Feature> _getFamilyFeatures() {
    return [
      Feature(
        icon: Icons.verified_user,
        title: 'Vetted & Trained Professionals',
        description:
            'All workers undergo thorough background checks and professional training',
        color: AppColors.primaryBlue,
      ),
      Feature(
        icon: Icons.access_time,
        title: 'On-Demand Booking',
        description:
            'Book nannies or house helpers with as little as 4 hours notice',
        color: AppColors.secondaryOrange,
      ),
      Feature(
        icon: Icons.payment,
        title: 'Secure Payments',
        description: 'Pay through the app with our secure wallet system',
        color: AppColors.jasmin,
      ),
      Feature(
        icon: Icons.reviews,
        title: 'Trust & Reviews',
        description: 'See verified ratings and reviews from other families',
        color: AppColors.guppie,
      ),
      Feature(
        icon: Icons.chat,
        title: 'In-App Communication',
        description:
            'Chat directly with workers through our secure messaging system',
        color: AppColors.primaryDark,
      ),
    ];
  }

  // Features for worker users
  List<Feature> _getWorkerFeatures() {
    return [
      Feature(
        icon: Icons.school,
        title: 'Professional Training',
        description:
            'Receive expert training to enhance your skills and earning potential',
        color: AppColors.primaryBlue,
      ),
      Feature(
        icon: Icons.work,
        title: 'Consistent Job Opportunities',
        description:
            'Access a steady stream of job opportunities from verified families',
        color: AppColors.secondaryOrange,
      ),
      Feature(
        icon: Icons.payments,
        title: 'Reliable Payments',
        description: 'Get paid on time, every time through our secure system',
        color: AppColors.jasmin,
      ),
      Feature(
        icon: Icons.shield,
        title: 'Safety & Support',
        description:
            '24/7 emergency support and safety features for peace of mind',
        color: AppColors.guppie,
      ),
      Feature(
        icon: Icons.trending_up,
        title: 'Career Growth',
        description:
            'Earn badges, build your reputation, and increase your earnings',
        color: AppColors.primaryDark,
      ),
    ];
  }
}

// Helper class for features
class Feature {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  Feature({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
