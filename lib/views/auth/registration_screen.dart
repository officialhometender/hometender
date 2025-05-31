import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import your router file
import '../../utilities/components/ht_buttons.dart';
import '../../utilities/components/ht_card.dart';
import '../../utilities/components/ht_spacing.dart';
import '../../utilities/components/ht_text.dart';
import '../../utilities/components/ht_text_field.dart';
import '../../utilities/router/app_router.dart';
import '../../utilities/theme/app_color.dart';

// Worker type enum
enum WorkerType { nanny, houseHelper }

// Provider to store selected worker type
final workerTypeProvider = StateProvider<WorkerType?>((ref) => null);

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  // Family-specific controllers
  final _familySizeController = TextEditingController();

  // Worker-specific controllers
  final _experienceController = TextEditingController();
  final _skillsController = TextEditingController();

  // State variables
  bool _isLoading = false;
  bool _acceptedTerms = false;
  bool _showPassword = false;

  // Selected service types for families
  final Map<String, bool> _serviceTypes = {
    'Child care (Nanny)': true,
    'House cleaning': false,
    'Cooking': false,
    'Laundry': false,
    'Errands': false,
  };

  // Selected skills for workers
  final Map<String, bool> _workerSkills = {
    'Infant care (0-1 year)': false,
    'Toddler care (1-3 years)': false,
    'Preschool (3-5 years)': false,
    'School-age children': false,
    'Special needs experience': false,
    'General cleaning': false,
    'Deep cleaning': false,
    'Cooking': false,
    'Laundry & ironing': false,
    'Grocery shopping': false,
  };

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _familySizeController.dispose();
    _experienceController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the user type from provider (family or worker)
    final userType = ref.watch(userTypeProvider);

    // Get the worker type if user is a worker
    final workerType = ref.watch(workerTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: HTText.titleLarge('Create Account'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.go('/login'),
            child: HTText.titleSmall('Sign In',
                color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // User type selection
              if (userType == null) ...[
                _buildUserTypeSelection(context),
              ] else ...[
                // Basic information section
                HTCard(
                  variant: CardVariant.filled,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HTText.titleMedium('Basic Information'),
                      HTSpacing.verticalMD,
                      HTTextField(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        controller: _fullNameController,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      HTSpacing.verticalMD,
                      HTTextField.email(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                      ),
                      HTSpacing.verticalMD,
                      HTTextField.phone(
                        controller: _phoneController,
                        textInputAction: TextInputAction.next,
                      ),
                      HTSpacing.verticalMD,
                      HTTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: _showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onSuffixIconTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      HTSpacing.verticalMD,
                      HTTextField(
                        label: 'Address',
                        hint: 'Enter your address',
                        controller: _addressController,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icons.location_on_outlined,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                HTSpacing.verticalMD,

                // User-specific section
                if (userType == UserType.family) ...[
                  _buildFamilySection(),
                ] else if (userType == UserType.worker) ...[
                  _buildWorkerTypeSelection(workerType),
                  HTSpacing.verticalMD,
                  if (workerType != null)
                    _buildWorkerDetailsSection(workerType),
                ],

                HTSpacing.verticalMD,

                // Terms and conditions
                HTCard(
                  variant: CardVariant.outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HTText.titleMedium('Terms of Service'),
                      HTSpacing.verticalSM,
                      HTText.bodySmall(
                        'By creating an account, you agree to HomeTender\'s Terms of Service, Privacy Policy, and Non-Poaching Agreement.',
                      ),
                      HTSpacing.verticalSM,
                      HTText.bodySmall(
                        userType == UserType.family
                            ? '• You will be charged only for services rendered\n'
                                '• Minimum booking is 4 hours\n'
                                '• You agree not to hire workers outside the platform\n'
                                '• Cancellation policy applies for bookings'
                            : '• You will receive payments through the app\n'
                                '• A service fee of 10-15% applies to each booking\n'
                                '• You agree not to work directly with clients\n'
                                '• You must attend required training sessions',
                      ),
                      HTSpacing.verticalMD,
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptedTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptedTerms = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: HTText.bodyMedium(
                              'I agree to the Terms of Service, Privacy Policy, and Non-Poaching Agreement',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                HTSpacing.verticalLG,

                // Submit button
                HTButton.primary(
                  label: 'Create Account',
                  isFullWidth: true,
                  isLoading: _isLoading,
                  onPressed: _acceptedTerms ? _handleRegistration : null,
                ),

                HTSpacing.verticalMD,

                // Switch user type button
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Clear form and reset user type
                      _formKey.currentState?.reset();
                      ref.read(userTypeProvider.notifier).state = null;
                      ref.read(workerTypeProvider.notifier).state = null;
                    },
                    child: HTText.bodyMedium(
                      'Change account type',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                HTSpacing.verticalMD,
              ],
            ],
          ),
        ),
      ),
    );
  }

  // User type selection cards
  Widget _buildUserTypeSelection(BuildContext context) {
    return Column(
      children: [
        HTText.headlineSmall(
          'I want to use HomeTender as a:',
          textAlign: TextAlign.center,
        ),
        HTSpacing.verticalLG,

        // Family card
        HTCard(
          variant: CardVariant.outlined,
          borderRadius: 16,
          onTap: () {
            ref.read(userTypeProvider.notifier).state = UserType.family;
          },
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
                      HTText.titleLarge('Family'),
                      HTSpacing.verticalXS,
                      HTText.bodyMedium(
                        'Hire reliable nannies and house helpers for your home',
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
          ),
        ),

        HTSpacing.verticalMD,

        // Worker card
        HTCard(
          variant: CardVariant.outlined,
          borderRadius: 16,
          onTap: () {
            ref.read(userTypeProvider.notifier).state = UserType.worker;
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.work_outline,
                    color: AppColors.secondaryOrange,
                    size: 32,
                  ),
                ),
                HTSpacing.horizontalMD,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HTText.titleLarge('Worker'),
                      HTSpacing.verticalXS,
                      HTText.bodyMedium(
                        'Find work as a nanny or house helper',
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Family-specific section
  Widget _buildFamilySection() {
    return HTCard(
      variant: CardVariant.filled,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HTText.titleMedium('Family Details'),
          HTSpacing.verticalMD,
          HTTextField(
            label: 'Family Size',
            hint: 'Number of family members',
            controller: _familySizeController,
            keyboardType: TextInputType.number,
            prefixIcon: Icons.people_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your family size';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          HTSpacing.verticalMD,
          HTText.bodyMedium('Type of help needed:'),
          HTSpacing.verticalSM,

          // Service type checkboxes
          ..._serviceTypes.entries.map((entry) {
            return CheckboxListTile(
              title: HTText.bodyMedium(entry.key),
              value: entry.value,
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _serviceTypes[entry.key] = value ?? false;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  // Worker type selection cards
  Widget _buildWorkerTypeSelection(WorkerType? workerType) {
    return HTCard(
      variant: CardVariant.filled,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HTText.titleMedium('I am a:'),
          HTSpacing.verticalMD,

          // Nanny card
          HTCard(
            variant: workerType == WorkerType.nanny
                ? CardVariant.elevated
                : CardVariant.outlined,
            borderRadius: 16,
            onTap: () {
              ref.read(workerTypeProvider.notifier).state = WorkerType.nanny;
            },
            elevation: workerType == WorkerType.nanny ? 4 : 0,
            backgroundColor: workerType == WorkerType.nanny
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : null,
            borderColor: workerType == WorkerType.nanny
                ? Theme.of(context).colorScheme.primary
                : null,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.child_care,
                      color: AppColors.primaryBlue,
                      size: 28,
                    ),
                  ),
                  HTSpacing.horizontalMD,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HTText.titleMedium('Nanny'),
                        HTSpacing.verticalXS,
                        HTText.bodySmall(
                          'Childcare specialist',
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                  if (workerType == WorkerType.nanny)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),

          HTSpacing.verticalMD,

          // House Helper card
          HTCard(
            variant: workerType == WorkerType.houseHelper
                ? CardVariant.elevated
                : CardVariant.outlined,
            borderRadius: 16,
            onTap: () {
              ref.read(workerTypeProvider.notifier).state =
                  WorkerType.houseHelper;
            },
            elevation: workerType == WorkerType.houseHelper ? 4 : 0,
            backgroundColor: workerType == WorkerType.houseHelper
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : null,
            borderColor: workerType == WorkerType.houseHelper
                ? Theme.of(context).colorScheme.primary
                : null,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryOrange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.cleaning_services,
                      color: AppColors.secondaryOrange,
                      size: 28,
                    ),
                  ),
                  HTSpacing.horizontalMD,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HTText.titleMedium('House Helper'),
                        HTSpacing.verticalXS,
                        HTText.bodySmall(
                          'Cleaning, cooking, and general household tasks',
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                  if (workerType == WorkerType.houseHelper)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Worker details section
  Widget _buildWorkerDetailsSection(WorkerType workerType) {
    // Determine which skills to show based on worker type
    final skills = workerType == WorkerType.nanny
        ? _workerSkills.entries.where((e) =>
            e.key.contains('care') ||
            e.key.contains('Preschool') ||
            e.key.contains('School-age') ||
            e.key.contains('Special needs'))
        : _workerSkills.entries.where((e) =>
            e.key.contains('cleaning') ||
            e.key.contains('Cooking') ||
            e.key.contains('Laundry') ||
            e.key.contains('Grocery'));

    return HTCard(
      variant: CardVariant.filled,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HTText.titleMedium('Experience & Skills'),
          HTSpacing.verticalMD,
          HTTextField(
            label: 'Years of Experience',
            hint: 'e.g. 2',
            controller: _experienceController,
            keyboardType: TextInputType.number,
            prefixIcon: Icons.work_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your experience';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          HTSpacing.verticalMD,
          HTTextField.multiline(
            label: 'Skills & Qualifications',
            hint: workerType == WorkerType.nanny
                ? 'e.g. First aid certified, Early childhood education, etc.'
                : 'e.g. Cooking, deep cleaning, laundry, etc.',
            controller: _skillsController,
            minLines: 3,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your skills';
              }
              return null;
            },
          ),
          HTSpacing.verticalMD,
          HTText.bodyMedium(workerType == WorkerType.nanny
              ? 'Childcare Specialties:'
              : 'Household Skills:'),
          HTSpacing.verticalSM,

          // Skills checkboxes based on worker type
          ...skills.map((entry) {
            return CheckboxListTile(
              title: HTText.bodyMedium(entry.key),
              value: entry.value,
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _workerSkills[entry.key] = value ?? false;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  // Handle registration
  void _handleRegistration() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Get user type
    final userType = ref.read(userTypeProvider);

    // Get worker type if applicable
    final workerType = ref.read(workerTypeProvider);

    // Collect user data
    final Map<String, dynamic> userData = {
      'fullName': _fullNameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'userType': userType.toString(),
    };

    // Add family-specific data
    if (userType == UserType.family) {
      userData['familySize'] = _familySizeController.text;
      userData['serviceTypes'] = _serviceTypes.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();
    }

    // Add worker-specific data
    if (userType == UserType.worker && workerType != null) {
      userData['workerType'] = workerType.toString();
      userData['experience'] = _experienceController.text;
      userData['skills'] = _skillsController.text;
      userData['specialties'] = _workerSkills.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();
    }

    // Log registration data for debugging
    debugPrint('Registration data: $userData');

    // Simulate registration process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Mark onboarding as completed
      final router = ref.read(routerNotifierProvider);
      router.completeOnboarding();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home
      context.go('/');
    });
  }
}
