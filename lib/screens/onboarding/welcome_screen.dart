// lib/screens/onboarding/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/components.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';
import 'onboarding_slider_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _buttonController;
  late AnimationController _backgroundController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _buttonScale;
  late Animation<double> _buttonOpacity;
  late Animation<double> _backgroundRotation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _buttonScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.bounceOut),
    );

    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );

    _backgroundRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.linear),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _logoController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _textController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      _buttonController.forward();
    });

    _backgroundController.repeat();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.guppie.withValues(alpha: 0.05),
              AppColors.jasmine.withValues(alpha: 0.08),
              AppColors.mandarin.withValues(alpha: 0.06),
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background shapes
            _buildAnimatedBackground(),

            // Main content
            SafeArea(
              child: Padding(
                padding: AppSizing.screenPadding,
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // Logo and branding
                    _buildLogo(),

                    const SizedBox(height: AppSizing.xl),

                    // Title and subtitle
                    _buildTitleSection(),

                    const Spacer(flex: 3),

                    // Get started button
                    _buildGetStartedButton(),

                    const SizedBox(height: AppSizing.lg),

                    // Footer text
                    _buildFooterText(),

                    const SizedBox(height: AppSizing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating circles
            Positioned(
              top: 100 + (50 * _backgroundRotation.value),
              right: 50 + (30 * _backgroundRotation.value),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.guppie.withValues(alpha: 0.3),
                      AppColors.guppie.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200 + (30 * (1 - _backgroundRotation.value)),
              left: 30 + (20 * _backgroundRotation.value),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.jasmine.withValues(alpha: 0.4),
                      AppColors.jasmine.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 150 + (40 * _backgroundRotation.value),
              left: 80 + (25 * (1 - _backgroundRotation.value)),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.mandarin.withValues(alpha: 0.2),
                      AppColors.mandarin.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScale.value,
          child: Opacity(
            opacity: _logoOpacity.value,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.guppie,
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Image.asset('assets/logo/logo-dark.png'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.guppie,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'HomeTender',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontSize: 28,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: AppSizing.sm),
                Text(
                  'Your trusted home care platform',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizing.lg),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizing.lg,
                    vertical: AppSizing.sm,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary
                            .withValues(alpha: context.isDarkMode ? 0.2 : 0.1),
                        AppColors.guppie
                            .withValues(alpha: context.isDarkMode ? 0.2 : 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSizing.radiusFull),
                    border: Border.all(
                      color: AppColors.primary
                          .withValues(alpha: context.isDarkMode ? 0.4 : 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizing.xs),
                        decoration: const BoxDecoration(
                          color: AppColors.guppie,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.verify5,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: AppSizing.sm),
                      Text(
                        'Professional • Trusted • Reliable',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: context.isDarkMode
                                      ? AppColors.white
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGetStartedButton() {
    return AnimatedBuilder(
      animation: _buttonController,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonScale.value,
          child: FadeTransition(
            opacity: _buttonOpacity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizing.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: AppButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const OnboardingSliderScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 600),
                    ),
                  );
                },
                size: ButtonSize.large,
                fullWidth: true,
                icon: Container(
                  padding: const EdgeInsets.all(AppSizing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.arrow_right_1,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterText() {
    return AnimatedBuilder(
      animation: _buttonController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _buttonOpacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.shield_tick,
                size: 16,
                color: context.isDarkMode
                    ? AppColors.guppie
                    : context.colors.onSurfaceVariant,
              ),
              const SizedBox(width: AppSizing.xs),
              Text(
                'Trusted by 1000+ Nigerian families',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.isDarkMode
                          ? context.colors.onSurface.withValues(alpha: 0.9)
                          : context.colors.onSurfaceVariant,
                      fontWeight: context.isDarkMode
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
