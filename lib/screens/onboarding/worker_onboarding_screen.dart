// lib/screens/onboarding/worker_onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/components.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';
import '../home.dart';

class WorkerOnboardingScreen extends StatefulWidget {
  const WorkerOnboardingScreen({super.key});

  @override
  State<WorkerOnboardingScreen> createState() => _WorkerOnboardingScreenState();
}

class _WorkerOnboardingScreenState extends State<WorkerOnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late AnimationController _pageAnimationController;
  late AnimationController _celebrationController;

  int _currentStep = 0;
  final int _totalSteps = 5;

  // Form data
  String? _selectedServiceType;
  List<String> _selectedSkills = [];
  String? _selectedExperience;
  String? _selectedAvailability;
  bool _agreedToTerms = false;

  final List<WorkerOnboardingStep> _steps = [
    WorkerOnboardingStep(
      title: 'What service do you provide?',
      subtitle: 'Choose your specialty',
      icon: Iconsax.heart,
      color: AppColors.mandarin,
    ),
    WorkerOnboardingStep(
      title: 'What are your skills?',
      subtitle: 'Highlight your strengths',
      icon: Iconsax.medal_star,
      color: AppColors.jasmine,
    ),
    WorkerOnboardingStep(
      title: 'Your experience level?',
      subtitle: 'Help families understand your background',
      icon: Iconsax.chart,
      color: AppColors.guppie,
    ),
    WorkerOnboardingStep(
      title: 'When are you available?',
      subtitle: 'Set your working preferences',
      icon: Iconsax.calendar_1,
      color: AppColors.primary,
    ),
    WorkerOnboardingStep(
      title: 'Terms & Training',
      subtitle: 'Complete your registration',
      icon: Iconsax.shield_tick,
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
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
    _celebrationController.dispose();
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
    _celebrationController.forward();

    Future.delayed(const Duration(milliseconds: 1800), () {
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
    });
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedServiceType != null;
      case 1:
        return _selectedSkills.isNotEmpty;
      case 2:
        return _selectedExperience != null;
      case 3:
        return _selectedAvailability != null;
      case 4:
        return _agreedToTerms;
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
        child: Stack(
          children: [
            SafeArea(
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

            // Celebration overlay
            _buildCelebrationOverlay(),
          ],
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

          // Logo
          Container(
            padding: const EdgeInsets.all(AppSizing.sm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mandarin, AppColors.jasmine],
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
            ),
            child: const Icon(
              Iconsax.home,
              color: AppColors.white,
              size: 20,
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
        return _buildSkillsSelection();
      case 2:
        return _buildExperienceSelection();
      case 3:
        return _buildAvailabilitySelection();
      case 4:
        return _buildTermsAndTraining();
      default:
        return const SizedBox();
    }
  }

  Widget _buildServiceTypeSelection() {
    final services = [
      WorkerServiceOption(
        id: 'nanny',
        title: 'Nanny',
        description: 'Specialize in childcare and child development',
        icon: Iconsax.heart,
        earnings: '₦1,125 - ₦2,000/hour',
        requirements: [
          '3-week training',
          'Background check',
          'Health screening'
        ],
      ),
      WorkerServiceOption(
        id: 'house_help',
        title: 'House Help',
        description: 'Provide domestic assistance and household management',
        icon: Iconsax.home_1,
        earnings: '₦875 - ₦1,625/hour',
        requirements: [
          '2-week training',
          'Background check',
          'Skills assessment'
        ],
      ),
      WorkerServiceOption(
        id: 'both',
        title: 'Both Services',
        description: 'Offer comprehensive home and childcare support',
        icon: Iconsax.people,
        earnings: '₦875 - ₦2,000/hour',
        requirements: [
          'Full training program',
          'Complete certification',
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
                  ? AppColors.mandarin.withValues(alpha: 0.1)
                  : context.colors.surface,
              border: Border.all(
                color: isSelected
                    ? AppColors.mandarin
                    : context.colors.outline.withValues(alpha: 0.5),
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.mandarin.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizing.md),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.mandarin
                            : context.colors.surfaceVariant,
                        borderRadius:
                            BorderRadius.circular(AppSizing.radiusMedium),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.onSurface,
                                ),
                          ),
                          Text(
                            service.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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

                const SizedBox(height: AppSizing.md),

                // Earnings
                Container(
                  padding: const EdgeInsets.all(AppSizing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.guppie.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.money_4,
                        size: 16,
                        color: AppColors.guppie,
                      ),
                      const SizedBox(width: AppSizing.xs),
                      Text(
                        'Earn ${service.earnings}',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.guppie,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizing.sm),

                // Requirements
                Wrap(
                  spacing: AppSizing.xs,
                  runSpacing: AppSizing.xs,
                  children: service.requirements.map((requirement) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizing.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.mandarin.withValues(alpha: 0.1)
                            : context.colors.surfaceVariant,
                        borderRadius:
                            BorderRadius.circular(AppSizing.radiusSmall),
                      ),
                      child: Text(
                        requirement,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isSelected
                                  ? AppColors.mandarin
                                  : context.colors.onSurfaceVariant,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillsSelection() {
    final skills = [
      'Cooking',
      'Cleaning',
      'Childcare',
      'Laundry',
      'Pet care',
      'Driving',
      'First aid',
      'English fluency',
      'Educational activities',
      'Elderly care',
      'Gardening',
      'Shopping/Errands'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select all skills that apply to you',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: AppSizing.lg),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: AppSizing.sm,
              mainAxisSpacing: AppSizing.sm,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];
              final isSelected = _selectedSkills.contains(skill);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedSkills.remove(skill);
                    } else {
                      _selectedSkills.add(skill);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(AppSizing.sm),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.jasmine.withValues(alpha: 0.2)
                        : context.colors.surfaceVariant,
                    border: Border.all(
                      color:
                          isSelected ? AppColors.jasmine : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
                  ),
                  child: Center(
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
                        Flexible(
                          child: Text(
                            skill,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: isSelected
                                      ? AppColors.jasmine
                                      : context.colors.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSelection() {
    final experiences = [
      ExperienceOption(
        id: 'beginner',
        title: 'New to Professional Service',
        description: 'Less than 1 year experience',
        icon: Iconsax.user,
        color: AppColors.info,
      ),
      ExperienceOption(
        id: 'some_experience',
        title: 'Some Experience',
        description: '1-3 years experience',
        icon: Iconsax.chart,
        color: AppColors.warning,
      ),
      ExperienceOption(
        id: 'experienced',
        title: 'Experienced',
        description: '3-5 years experience',
        icon: Iconsax.medal,
        color: AppColors.guppie,
      ),
      ExperienceOption(
        id: 'expert',
        title: 'Expert',
        description: '5+ years experience',
        icon: Iconsax.crown_1,
        color: AppColors.mandarin,
      ),
    ];

    return ListView.separated(
      itemCount: experiences.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizing.md),
      itemBuilder: (context, index) {
        final experience = experiences[index];
        final isSelected = _selectedExperience == experience.id;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedExperience = experience.id;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSizing.lg),
            decoration: BoxDecoration(
              color: isSelected
                  ? experience.color.withValues(alpha: 0.1)
                  : context.colors.surface,
              border: Border.all(
                color: isSelected
                    ? experience.color
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
                        ? experience.color
                        : context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
                  ),
                  child: Icon(
                    experience.icon,
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
                        experience.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.onSurface,
                                ),
                      ),
                      Text(
                        experience.description,
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
                    decoration: BoxDecoration(
                      color: experience.color,
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

  Widget _buildAvailabilitySelection() {
    final availabilities = [
      AvailabilityOption(
        id: 'weekdays',
        title: 'Weekdays Only',
        description: 'Monday to Friday',
        icon: Iconsax.calendar,
      ),
      AvailabilityOption(
        id: 'weekends',
        title: 'Weekends Only',
        description: 'Saturday and Sunday',
        icon: Iconsax.calendar_tick,
      ),
      AvailabilityOption(
        id: 'flexible',
        title: 'Flexible Schedule',
        description: 'Available any day with advance notice',
        icon: Iconsax.clock,
      ),
      AvailabilityOption(
        id: 'full_time',
        title: 'Full Time',
        description: 'Available 6-7 days per week',
        icon: Iconsax.calendar_1,
      ),
    ];

    return ListView.separated(
      itemCount: availabilities.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizing.md),
      itemBuilder: (context, index) {
        final availability = availabilities[index];
        final isSelected = _selectedAvailability == availability.id;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedAvailability = availability.id;
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
                    availability.icon,
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
                        availability.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.onSurface,
                                ),
                      ),
                      Text(
                        availability.description,
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

  Widget _buildTermsAndTraining() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Training info card
        Container(
          padding: const EdgeInsets.all(AppSizing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.guppie.withValues(alpha: 0.1),
                AppColors.jasmine.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
            border: Border.all(
              color: AppColors.guppie.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizing.sm),
                    decoration: const BoxDecoration(
                      color: AppColors.guppie,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.book_1,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: AppSizing.md),
                  Text(
                    'Training Program',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.guppie,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizing.md),
              Text(
                'Complete our professional training program to get certified and start earning.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: AppSizing.md),
              const Row(
                children: [
                  Icon(Iconsax.clock, size: 16, color: AppColors.guppie),
                  SizedBox(width: AppSizing.xs),
                  Text('2-3 weeks duration'),
                  SizedBox(width: AppSizing.md),
                  Icon(Iconsax.money_4, size: 16, color: AppColors.guppie),
                  SizedBox(width: AppSizing.xs),
                  Text('₦10,000 - ₦15,000 fee'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSizing.xl),

        // Terms checkbox
        GestureDetector(
          onTap: () {
            setState(() {
              _agreedToTerms = !_agreedToTerms;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(AppSizing.lg),
            decoration: BoxDecoration(
              color: _agreedToTerms
                  ? AppColors.mandarin.withValues(alpha: 0.1)
                  : context.colors.surfaceVariant,
              border: Border.all(
                color: _agreedToTerms
                    ? AppColors.mandarin
                    : context.colors.outline.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _agreedToTerms
                        ? AppColors.mandarin
                        : Colors.transparent,
                    border: Border.all(
                      color: _agreedToTerms
                          ? AppColors.mandarin
                          : context.colors.outline,
                    ),
                    borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
                  ),
                  child: _agreedToTerms
                      ? const Icon(
                          Iconsax.tick_circle,
                          size: 16,
                          color: AppColors.white,
                        )
                      : null,
                ),
                const SizedBox(width: AppSizing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I agree to HomeTender\'s Terms & Conditions',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.colors.onSurface,
                            ),
                      ),
                      const SizedBox(height: AppSizing.xs),
                      Text(
                        'Including background checks, training requirements, and platform policies',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // Welcome message
        if (_agreedToTerms)
          Container(
            padding: const EdgeInsets.all(AppSizing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mandarin, AppColors.jasmine],
              ),
              borderRadius: BorderRadius.circular(AppSizing.radiusLarge),
            ),
            child: Row(
              children: [
                const Icon(
                  Iconsax.heart,
                  color: AppColors.white,
                  size: 24,
                ),
                const SizedBox(width: AppSizing.md),
                Expanded(
                  child: Text(
                    'Welcome to the HomeTender family! You\'re about to start an amazing journey.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCelebrationOverlay() {
    return AnimatedBuilder(
      animation: _celebrationController,
      builder: (context, child) {
        if (_celebrationController.value == 0) return const SizedBox();

        return Container(
          color: AppColors.mandarin.withValues(
            alpha: 0.95 * _celebrationController.value,
          ),
          child: Center(
            child: Transform.scale(
              scale: _celebrationController.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizing.xl),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.heart,
                      size: 80,
                      color: AppColors.mandarin,
                    ),
                  ),
                  const SizedBox(height: AppSizing.xl),
                  Text(
                    'Welcome to HomeTender!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppSizing.md),
                  Text(
                    'You\'re ready to start your journey',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                  ),
                ],
              ),
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
              text: isLastStep ? 'Join HomeTender' : 'Continue',
              onPressed: canProceed ? _nextStep : null,
              size: ButtonSize.large,
              icon: Container(
                padding: const EdgeInsets.all(AppSizing.xs),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLastStep ? Iconsax.heart : Iconsax.arrow_right_1,
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

class WorkerOnboardingStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  WorkerOnboardingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class WorkerServiceOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String earnings;
  final List<String> requirements;

  WorkerServiceOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.earnings,
    required this.requirements,
  });
}

class ExperienceOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  ExperienceOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class AvailabilityOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  AvailabilityOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
