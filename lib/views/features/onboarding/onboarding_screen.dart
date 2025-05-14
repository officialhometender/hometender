import 'package:HomeTender/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_color.dart';
import '../../../routes/route_constants.dart';

// State provider for tracking onboarding page
final currentOnboardingPageProvider = StateProvider<int>((ref) => 0);

// Adjust these values to control the darkness of the overlay
// Higher values = darker overlay
const double topOverlayOpacity = 0.0; // Darkness at the top
const double middleOverlayOpacity = 0.6; // Darkness in the middle
const double bottomOverlayOpacity = 0.9; // Darkness at the bottom

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  // Mark onboarding as completed in SharedPreferences
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current theme brightness
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Choose appropriate colors based on theme
    final continueButtonColor =
        isDarkMode ? AppColors.guppie500 : AppColors.primary600;
    final skipButtonColor = isDarkMode ? AppColors.jasmine500 : Colors.white;

    // Page controller for managing the PageView
    final pageController = PageController();

    // Watch the current page from state
    final currentPage = ref.watch(currentOnboardingPageProvider);

    // Onboarding data
    final onboardingData = [
      // First screen
      OnboardingPageData(
        image: 'assets/images/onboarding/onboarding_one.png',
        title: 'Find Trusted Home Services',
        description:
            'Connect with reliable professionals for all your home maintenance needs.',
      ),
      // Second screen
      OnboardingPageData(
        image: 'assets/images/onboarding/onboarding_two.jpg',
        title: 'Book Services Easily',
        description:
            'Schedule, track, and manage home services with just a few taps.',
      ),
      // Third screen
      OnboardingPageData(
        image: 'assets/images/onboarding/onboarding_three.jpg',
        title: 'Your Home, Our Priority',
        description:
            'Experience quality service from vetted professionals you can trust.',
      ),
    ];

    return Scaffold(
      // Use a dark background to enhance image visibility
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // PageView for swiping between onboarding screens
          PageView.builder(
            controller: pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              // Update the current page in state
              ref.read(currentOnboardingPageProvider.notifier).state = index;
            },
            itemBuilder: (context, index) {
              return _buildOnboardingPage(
                context,
                onboardingData[index],
              );
            },
          ),

          // Skip button (only on pages 0-1)
          if (currentPage < onboardingData.length - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: TextButton(
                onPressed: () async {
                  // Skip directly to login screen
                  await _completeOnboarding();
                  if (context.mounted) {
                    context.go(RouteConstants.login);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black.withAlpha(76), // 0.3 opacity
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: skipButtonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          // Page indicator and buttons at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Page indicator dots
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onboardingData.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: continueButtonColor,
                      dotColor: Color.fromRGBO(255, 255, 255, 0.5),
                      // Using RGBA instead of withOpacity
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Continue/Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: continueButtonColor,
                        foregroundColor:
                            isDarkMode ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (currentPage < onboardingData.length - 1) {
                          // Go to next page
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else {
                          // Mark onboarding as completed
                          await _completeOnboarding();
                          // Navigate to login on the last page
                          if (context.mounted) {
                            context.go(RouteConstants.login);
                          }
                        }
                      },
                      child: Text(
                        currentPage < onboardingData.length - 1
                            ? 'Continue'
                            : 'Get Started',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each onboarding page
  Widget _buildOnboardingPage(
    BuildContext context,
    OnboardingPageData data,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          data.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if image fails to load
            return Container(color: Colors.grey[900]);
          },
        ),

        // Enhanced gradient overlay with darker blacks
        // Using fromRGBO instead of withOpacity
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, topOverlayOpacity),
                // Top overlay
                Color.fromRGBO(0, 0, 0, middleOverlayOpacity),
                // Middle transition
                Color.fromRGBO(0, 0, 0, bottomOverlayOpacity),
                // Bottom overlay
              ],
              stops: const [0.0, 0.5, 1.0], // Control gradient positioning
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Title
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Description
                Text(
                  data.description,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    // Using RGBA instead of withOpacity
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Add spacer to push content up from the bottom
                AppSpacing.vertical(space: 130),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Data class for onboarding pages
class OnboardingPageData {
  final String image;
  final String title;
  final String description;

  OnboardingPageData({
    required this.image,
    required this.title,
    required this.description,
  });
}
