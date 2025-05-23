// lib/screens/onboarding/role_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/components.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';
import 'hirer_onboarding_screen.dart';
import 'worker_onboarding_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _cardsController;
  late AnimationController _floatingController;

  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _cardsScale;
  late Animation<double> _cardsOpacity;

  String? _selectedRole;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeInOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutCubic),
    );

    _cardsScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _cardsController, curve: Curves.elasticOut),
    );

    _cardsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardsController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _titleController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      _cardsController.forward();
    });

    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _cardsController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  void _selectRole(String role) {
    if (_isAnimating) return;

    setState(() {
      _selectedRole = role;
      _isAnimating = true;
    });

    // Add haptic feedback
    // HapticFeedback.mediumImpact();

    // Navigate after animation
    Future.delayed(const Duration(milliseconds: 600), () {
      if (role == 'hirer') {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HirerOnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const WorkerOnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
    });
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
              context.colors.surface,
              AppColors.primary.withValues(alpha: 0.03),
              AppColors.guppie.withValues(alpha: 0.02),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: AppSizing.screenPadding,
            child: Column(
              children: [
                const Spacer(),

                // Title section
                _buildTitleSection(),

                const SizedBox(height: AppSizing.xxxl),

                // Role cards
                _buildRoleCards(),

                const Spacer(flex: 2),

                // Bottom text
                _buildBottomText(),

                const SizedBox(height: AppSizing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return AnimatedBuilder(
      animation: _titleController,
      builder: (context, child) {
        return SlideTransition(
          position: _titleSlide,
          child: FadeTransition(
            opacity: _titleOpacity,
            child: Column(
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(AppSizing.md),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.guppie],
                    ),
                    borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Iconsax.home,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),

                const SizedBox(height: AppSizing.lg),

                Text(
                  'Choose Your Journey',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSizing.sm),

                Text(
                  'Are you looking for help or ready to help?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleCards() {
    return AnimatedBuilder(
      animation: _cardsController,
      builder: (context, child) {
        return Transform.scale(
          scale: _cardsScale.value,
          child: FadeTransition(
            opacity: _cardsOpacity,
            child: Column(
              children: [
                // Hirer card
                _buildRoleCard(
                  role: 'hirer',
                  title: 'I Need Help',
                  subtitle: 'Find trusted care for your family',
                  description:
                      'Connect with professional nannies and house helpers',
                  icon: Iconsax.people,
                  primaryColor: AppColors.primary,
                  secondaryColor: AppColors.guppie,
                  features: [
                    'Browse verified profiles',
                    'Book flexible schedules',
                    'Secure in-app payments',
                    'Real-time communication',
                  ],
                ),

                const SizedBox(height: AppSizing.lg),

                // Worker card
                _buildRoleCard(
                  role: 'worker',
                  title: 'I Want to Help',
                  subtitle: 'Start your journey as a caregiver',
                  description:
                      'Join our community of professional home care workers',
                  icon: Iconsax.heart,
                  primaryColor: AppColors.mandarin,
                  secondaryColor: AppColors.jasmine,
                  features: [
                    'Flexible work schedules',
                    'Professional training',
                    'Competitive earnings',
                    'Trusted platform',
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleCard({
    required String role,
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color primaryColor,
    required Color secondaryColor,
    required List<String> features,
  }) {
    final isSelected = _selectedRole == role;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()
        ..scale(isSelected && _isAnimating ? 0.95 : 1.0),
      child: GestureDetector(
        onTap: () => _selectRole(role),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withValues(alpha: 0.05),
                secondaryColor.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(AppSizing.radiusXLarge),
            border: Border.all(
              color: isSelected && _isAnimating
                  ? primaryColor
                  : primaryColor.withValues(alpha: 0.2),
              width: isSelected && _isAnimating ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(
                    alpha: isSelected && _isAnimating ? 0.2 : 0.1),
                blurRadius: isSelected && _isAnimating ? 20 : 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(AppSizing.md),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppSizing.radiusMedium),
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: AppColors.white,
                    ),
                  ),

                  const SizedBox(width: AppSizing.md),

                  // Title and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.onSurface,
                                  ),
                        ),
                        Text(
                          subtitle,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow
                  AnimatedBuilder(
                    animation: _floatingController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          5 * _floatingController.value,
                          0,
                        ),
                        child: Icon(
                          Iconsax.arrow_right_1,
                          color: primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: AppSizing.md),

              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
              ),

              const SizedBox(height: AppSizing.md),

              // Features
              Wrap(
                spacing: AppSizing.sm,
                runSpacing: AppSizing.xs,
                children: features.map((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizing.sm,
                      vertical: AppSizing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizing.radiusFull),
                      border: Border.all(
                        color: primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.tick_circle,
                          size: 14,
                          color: primaryColor,
                        ),
                        const SizedBox(width: AppSizing.xs),
                        Text(
                          feature,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return AnimatedBuilder(
      animation: _cardsController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _cardsOpacity,
          child: Container(
            padding: const EdgeInsets.all(AppSizing.md),
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.info_circle,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
                const SizedBox(width: AppSizing.sm),
                Flexible(
                  child: Text(
                    'You can always switch between roles in your profile settings',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
