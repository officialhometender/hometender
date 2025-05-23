// lib/screens/onboarding/onboarding_slider_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/components.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';
import 'role_selection_screen.dart';

class OnboardingSliderScreen extends StatefulWidget {
  const OnboardingSliderScreen({super.key});

  @override
  State<OnboardingSliderScreen> createState() => _OnboardingSliderScreenState();
}

class _OnboardingSliderScreenState extends State<OnboardingSliderScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _progressController;

  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      icon: Iconsax.people,
      title: 'Professional Caregivers',
      subtitle: 'Trained & Trusted',
      description:
          'Connect with verified nannies and house helpers who have completed our comprehensive training program.',
      primaryColor: AppColors.primary,
      secondaryColor: AppColors.guppie,
      imagePath: 'assets/images/nanny_one.jpg', // You'll add this
    ),
    OnboardingItem(
      icon: Iconsax.security_user,
      title: 'Background Verified',
      subtitle: 'Safety First',
      description:
          'All our workers undergo thorough background checks, health screening, and skills assessment.',
      primaryColor: AppColors.guppie,
      secondaryColor: AppColors.jasmine,
      imagePath: 'assets/images/family_one.jpg', // You'll add this
    ),
    OnboardingItem(
      icon: Iconsax.clock,
      title: 'Flexible Scheduling',
      subtitle: 'On Your Terms',
      description:
          'Book services hourly with a minimum of 4 hours. Schedule recurring help or one-time assistance.',
      primaryColor: AppColors.jasmine,
      secondaryColor: AppColors.mandarin,
      imagePath: 'assets/images/onboarding_3.png', // You'll add this
    ),
    OnboardingItem(
      icon: Iconsax.mobile,
      title: 'Seamless Experience',
      subtitle: 'Easy to Use',
      description:
          'Book, communicate, and pay securely through our app. Rate and review to help the community.',
      primaryColor: AppColors.mandarin,
      secondaryColor: AppColors.primary,
      imagePath: 'assets/images/onboarding_4.png', // You'll add this
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToRoleSelection();
    }
  }

  void _skipOnboarding() {
    _navigateToRoleSelection();
  }

  void _navigateToRoleSelection() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RoleSelectionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colors.surface,
              context.colors.surfaceVariant.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with skip button
              _buildHeader(),

              // Page indicator
              _buildPageIndicator(),

              const SizedBox(height: AppSizing.lg),

              // PageView
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    _animationController.reset();
                    _animationController.forward();
                  },
                  itemCount: _onboardingItems.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_onboardingItems[index]);
                  },
                ),
              ),

              // Bottom navigation
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: AppSizing.screenPaddingHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(AppSizing.sm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.guppie],
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
            ),
            child: const Icon(
              Iconsax.home,
              color: AppColors.white,
              size: 24,
            ),
          ),

          // Skip button
          TextButton(
            onPressed: _skipOnboarding,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizing.md,
                vertical: AppSizing.sm,
              ),
              decoration: BoxDecoration(
                color: context.colors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSizing.radiusFull),
              ),
              child: Text(
                'Skip',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Container(
          height: 8,
          margin: AppSizing.screenPaddingHorizontal,
          child: Row(
            children: List.generate(_onboardingItems.length, (index) {
              final isActive = index == _currentPage;
              final item = _onboardingItems[index];

              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isActive
                        ? item.primaryColor
                        : context.colors.surfaceVariant,
                  ),
                  child: isActive
                      ? FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressController.value,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                colors: [
                                  item.primaryColor,
                                  item.secondaryColor
                                ],
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Padding(
          padding: AppSizing.screenPaddingHorizontal,
          child: Column(
            children: [
              // Illustration container
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: AppSizing.lg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        item.primaryColor.withValues(alpha: 0.1),
                        item.secondaryColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(AppSizing.radiusXXLarge),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background pattern
                      _buildBackgroundPattern(item),

                      // Main icon or image placeholder
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeOutBack,
                        )),
                        child: FadeTransition(
                          opacity: _animationController,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  item.primaryColor,
                                  item.secondaryColor
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      item.primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              item.icon,
                              size: 60,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSizing.xl),

              // Content
              Expanded(
                flex: 2,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeOutCubic,
                  )),
                  child: FadeTransition(
                    opacity: _animationController,
                    child: Column(
                      children: [
                        // Subtitle badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizing.md,
                            vertical: AppSizing.xs,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                item.primaryColor.withValues(alpha: 0.1),
                                item.secondaryColor.withValues(alpha: 0.1),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.circular(AppSizing.radiusFull),
                            border: Border.all(
                              color: item.primaryColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            item.subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: item.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),

                        const SizedBox(height: AppSizing.md),

                        // Title
                        Text(
                          item.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colors.onSurface,
                              ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppSizing.md),

                        // Description
                        Text(
                          item.description,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: context.colors.onSurfaceVariant,
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundPattern(OnboardingItem item) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          right: 30,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.secondaryColor.withValues(alpha: 0.2),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.primaryColor.withValues(alpha: 0.3),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 40,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.secondaryColor.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    final isLastPage = _currentPage == _onboardingItems.length - 1;
    final currentItem = _onboardingItems[_currentPage];

    return Container(
      padding: AppSizing.screenPadding,
      child: Row(
        children: [
          // Previous button
          if (_currentPage > 0)
            Expanded(
              child: AppButton(
                text: 'Previous',
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                variant: ButtonVariant.outline,
                size: ButtonSize.large,
              ),
            )
          else
            const Spacer(),

          const SizedBox(width: AppSizing.md),

          // Next/Get Started button
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizing.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: currentItem.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: AppButton(
                text: isLastPage ? 'Get Started' : 'Next',
                onPressed: _nextPage,
                size: ButtonSize.large,
                icon: Container(
                  padding: const EdgeInsets.all(AppSizing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isLastPage ? Iconsax.arrow_right_1 : Iconsax.arrow_right_3,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final String imagePath;

  OnboardingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.imagePath,
  });
}
