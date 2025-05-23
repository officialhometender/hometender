// lib/screens/onboarding/hirer_onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/components.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';
import '../home.dart';

class HirerOnboardingScreen extends StatefulWidget {
  const HirerOnboardingScreen({super.key});

  @override
  State<HirerOnboardingScreen> createState() => _HirerOnboardingScreenState();
}

class _HirerOnboardingScreenState extends State<HirerOnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late AnimationController _pageAnimationController;

  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form data
  String? _selectedServiceType;
  String? _selectedLocation;
  List<String> _selectedRequirements = [];
  String? _selectedSchedule;

  final List<HirerOnboardingStep> _steps = [
    HirerOnboardingStep(
      title: 'What help do you need?',
      subtitle: 'Choose the service type',
      icon: Iconsax.people,
      color: AppColors.primary,
    ),
    HirerOnboardingStep(
      title: 'Where are you located?',
      subtitle: 'Select your area in Lagos',
      icon: Iconsax.location,
      color: AppColors.guppie,
    ),
    HirerOnboardingStep(
      title: 'Any special requirements?',
      subtitle: 'Let us know your preferences',
      icon: Iconsax.task_square,
      color: AppColors.jasmine,
    ),
    HirerOnboardingStep(
      title: 'When do you need help?',
      subtitle: 'Set your preferred schedule',
      icon: Iconsax.calendar_1,
      color: AppColors.mandarin,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _pageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _progressController.forward();
    _pageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    _pageAnimationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });

      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      _pageAnimationController.reset();
      _pageAnimationController.forward();
    } else {
      _completeOnboarding();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });

      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      _pageAnimationController.reset();
      _pageAnimationController.forward();
    }
  }

  void _completeOnboarding() {
    // Save onboarding data
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Home(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
      (route) => false,
    );
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedServiceType != null;
      case 1:
        return _selectedLocation != null;
      case 2:
        return true; // Requirements are optional
      case 3:
        return _selectedSchedule != null;
      default:
        return false;
    }
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
              _steps[_currentStep].color.withValues(alpha: 0.05),
              context.colors.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Progress indicator
              _buildProgressIndicator(),

              // Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _totalSteps,
                  itemBuilder: (context, index) {
                    return _buildStepContent(index);
                  },
                ),
              ),

              // Navigation buttons
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: AppSizing.screenPadding,
      child: Row(
        children: [
          // Back button
          if (_currentStep > 0)
            IconButton(
              onPressed: _previousStep,
              icon: Container(
                padding: const EdgeInsets.all(AppSizing.sm),
                decoration: BoxDecoration(
                  color: context.colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
                ),
                child: const Icon(Iconsax.arrow_left_2, size: 20),
              ),
            )
          else
            const SizedBox(width: 48),

          const Spacer(),

          // Step indicator
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizing.md,
              vertical: AppSizing.sm,
            ),
            decoration: BoxDecoration(
              color: _steps[_currentStep].color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizing.radiusFull),
            ),
            child: Text(
              '${_currentStep + 1} of $_totalSteps',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: _steps[_currentStep].color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          const Spacer(),

          // Skip button
          TextButton(
            onPressed: _completeOnboarding,
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: AppSizing.screenPaddingHorizontal,
      height: 6,
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(3),
      ),
      child: AnimatedBuilder(
        animation: _progressController,
        builder: (context, child) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (_currentStep + 1) / _totalSteps,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _steps[_currentStep].color,
                    _steps[_currentStep].color.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepContent(int stepIndex) {
    return AnimatedBuilder(
      animation: _pageAnimationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _pageAnimationController,
            curve: Curves.easeOutCubic,
          )),
          child: FadeTransition(
            opacity: _pageAnimationController,
            child: Padding(
              padding: AppSizing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizing.xl),

                  // Step header
                  _buildStepHeader(stepIndex),

                  const SizedBox(height: AppSizing.xl),

                  // Step content
                  Expanded(
                    child: _buildStepSpecificContent(stepIndex),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepHeader(int stepIndex) {
    final step = _steps[stepIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSizing.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [step.color, step.color.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: step.color.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            step.icon,
            size: 32,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSizing.lg),
        Text(
          step.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
              ),
        ),
        const SizedBox(height: AppSizing.sm),
        Text(
          step.subtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildStepSpecificContent(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return _buildServiceTypeSelection();
      case 1:
        return _buildLocationSelection();
      case 2:
        return _buildRequirementsSelection();
      case 3:
        return _buildScheduleSelection();
      default:
        return const SizedBox();
    }
  }

  Widget _buildServiceTypeSelection() {
    final services = [
      ServiceOption(
        id: 'nanny',
        title: 'Nanny',
        description: 'Childcare specialist for kids 0-12 years',
        icon: Iconsax.heart,
        features: [
          'Child supervision',
          'Educational activities',
          'Meal preparation for kids'
        ],
      ),
      ServiceOption(
        id: 'house_help',
        title: 'House Help',
        description: 'Professional domestic assistance',
        icon: Iconsax.home_1,
        features: ['House cleaning', 'Cooking', 'Laundry & errands'],
      ),
      ServiceOption(
        id: 'both',
        title: 'Both Services',
        description: 'Complete home and childcare support',
        icon: Iconsax.people,
        features: [
          'All childcare services',
          'All domestic services',
          'Flexible scheduling'
        ],
      ),
    ];

    return ListView.separated(
      itemCount: services.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizing.md),
      itemBuilder: (context, index) {
        final service = services[index];
        final isSelected = _selectedServiceType == service.id;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedServiceType = service.id;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSizing.lg),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : context.colors.surface,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : context.colors.outline.withValues(alpha: 0.5),
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizing.md),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
                  ),
                  child: Icon(
                    service.icon,
                    size: 24,
                    color: isSelected
                        ? AppColors.white
                        : context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSizing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.onSurface,
                                ),
                      ),
                      Text(
                        service.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: AppSizing.sm),
                      Wrap(
                        spacing: AppSizing.xs,
                        children: service.features.map((feature) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.1)
                                  : context.colors.surfaceVariant,
                              borderRadius:
                                  BorderRadius.circular(AppSizing.radiusSmall),
                            ),
                            child: Text(
                              feature,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : context.colors.onSurfaceVariant,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(AppSizing.xs),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.tick_circle,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationSelection() {
    final locations = [
      'Lekki Phase 1',
      'Lekki Phase 2',
      'Victoria Island',
      'Ikoyi',
      'Ikeja',
      'Surulere',
      'Yaba',
      'Maryland',
      'Gbagada',
      'Magodo',
      'Ajah',
      'Banana Island',
      'Other'
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: AppSizing.md,
        mainAxisSpacing: AppSizing.md,
      ),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        final isSelected = _selectedLocation == location;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedLocation = location;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSizing.md),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.guppie.withValues(alpha: 0.1)
                  : context.colors.surface,
              border: Border.all(
                color: isSelected
                    ? AppColors.guppie
                    : context.colors.outline.withValues(alpha: 0.5),
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
            ),
            child: Center(
              child: Text(
                location,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? AppColors.guppie
                          : context.colors.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequirementsSelection() {
    final requirements = [
      'Cooking skills',
      'English speaking',
      'Experience with infants',
      'Pet friendly',
      'First aid certified',
      'Can drive',
      'Live-in available',
      'Weekend availability'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select any that apply (optional)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: AppSizing.lg),
        Expanded(
          child: Wrap(
            spacing: AppSizing.sm,
            runSpacing: AppSizing.sm,
            children: requirements.map((requirement) {
              final isSelected = _selectedRequirements.contains(requirement);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedRequirements.remove(requirement);
                    } else {
                      _selectedRequirements.add(requirement);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizing.md,
                    vertical: AppSizing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.jasmine.withValues(alpha: 0.2)
                        : context.colors.surfaceVariant,
                    border: Border.all(
                      color:
                          isSelected ? AppColors.jasmine : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(AppSizing.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Iconsax.tick_circle,
                          size: 16,
                          color: AppColors.jasmine,
                        ),
                        const SizedBox(width: AppSizing.xs),
                      ],
                      Text(
                        requirement,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: isSelected
                                      ? AppColors.jasmine
                                      : context.colors.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleSelection() {
    final schedules = [
      ScheduleOption(
        id: 'weekdays',
        title: 'Weekdays',
        description: 'Monday to Friday',
        icon: Iconsax.calendar,
      ),
      ScheduleOption(
        id: 'weekends',
        title: 'Weekends',
        description: 'Saturday and Sunday',
        icon: Iconsax.calendar_tick,
      ),
      ScheduleOption(
        id: 'daily',
        title: 'Daily',
        description: 'Every day of the week',
        icon: Iconsax.calendar_1,
      ),
      ScheduleOption(
        id: 'as_needed',
        title: 'As Needed',
        description: 'Flexible scheduling',
        icon: Iconsax.clock,
      ),
    ];

    return ListView.separated(
      itemCount: schedules.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizing.md),
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        final isSelected = _selectedSchedule == schedule.id;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedSchedule = schedule.id;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSizing.lg),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.mandarin.withValues(alpha: 0.1)
                  : context.colors.surface,
              border: Border.all(
                color: isSelected
                    ? AppColors.mandarin
                    : context.colors.outline.withValues(alpha: 0.5),
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizing.md),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.mandarin
                        : context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
                  ),
                  child: Icon(
                    schedule.icon,
                    size: 24,
                    color: isSelected
                        ? AppColors.white
                        : context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSizing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.onSurface,
                                ),
                      ),
                      Text(
                        schedule.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(AppSizing.xs),
                    decoration: const BoxDecoration(
                      color: AppColors.mandarin,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.tick_circle,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationButtons() {
    final isLastStep = _currentStep == _totalSteps - 1;
    final canProceed = _canProceed();

    return Container(
      padding: AppSizing.screenPadding,
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: AppButton(
                text: 'Previous',
                onPressed: _previousStep,
                variant: ButtonVariant.outline,
                size: ButtonSize.large,
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: AppSizing.md),
          Expanded(
            flex: 2,
            child: AppButton(
              text: isLastStep ? 'Complete Setup' : 'Continue',
              onPressed: canProceed ? _nextStep : null,
              size: ButtonSize.large,
              icon: Container(
                padding: const EdgeInsets.all(AppSizing.xs),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLastStep ? Iconsax.tick_circle : Iconsax.arrow_right_1,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HirerOnboardingStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  HirerOnboardingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class ServiceOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<String> features;

  ServiceOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
  });
}

class ScheduleOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  ScheduleOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
