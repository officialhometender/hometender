import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tender/views/auth/login_screen.dart'; // Screens
import 'package:home_tender/views/home/home_screen.dart';
import 'package:home_tender/views/onboarding/features_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/auth/registration_screen.dart';
import '../../views/home/user_type_screen.dart';
import '../../views/home/welcome_screen.dart';
import '../../views/onboarding/final_onboarding_screen.dart';
import '../components/error_screen.dart';

// DEVELOPMENT MODE: Set to true during development to control initial route
// Set to false before production
const bool kDevMode = true;

// DEVELOPMENT: Change this to the route you want to start with during development
// Examples: '/' (home), '/onboarding/welcome', '/onboarding/features', '/register'
const String kInitialRoute =
    '/onboarding/welcome'; // Set to register for now to test it

// Provider to store user type selection across screens
final userTypeProvider = StateProvider<UserType?>((ref) => null);

// User types
enum UserType { family, worker }

// Provider for router instance
final goRouterProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: kDevMode ? null : router._redirectLogic,
    // Skip redirects in dev mode if desired
    routes: router._routes,
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    initialLocation:
        kDevMode ? kInitialRoute : '/', // Use initial route in dev mode
  );
});

// Router notifier to handle redirects and auth state
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _isInitialized = false;
  bool _showOnboarding = true; // Default to showing onboarding

  RouterNotifier(this._ref) {
    _init();
  }

  // Initialize and check if we should show onboarding
  Future<void> _init() async {
    if (_isInitialized) return;

    // Check if user has completed onboarding
    try {
      final prefs = await SharedPreferences.getInstance();
      _showOnboarding = !(prefs.getBool('hasCompletedOnboarding') ?? false);
    } catch (e) {
      debugPrint('Error checking onboarding status: $e');
      _showOnboarding = true; // Default to showing onboarding on error
    }

    _isInitialized = true;
    notifyListeners();
  }

  // Redirect logic
  String? _redirectLogic(BuildContext context, GoRouterState state) {
    // Wait until initialization is complete
    if (!_isInitialized) return null;

    // Get the current location
    final path = state.uri.path;

    // If we need to show onboarding and user is not already in onboarding flow
    if (_showOnboarding &&
        !path.startsWith('/onboarding') &&
        path != '/login' &&
        path != '/register') {
      return '/onboarding/welcome';
    }

    // Normal flow (no redirect)
    return null;
  }

  // Define routes
  List<RouteBase> get _routes => [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),

        // Onboarding flow
        GoRoute(
          path: '/onboarding/welcome',
          name: 'onboarding.welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/onboarding/user-type',
          name: 'onboarding.userType',
          builder: (context, state) => const UserTypeScreen(),
        ),
        GoRoute(
          path: '/onboarding/features',
          name: 'onboarding.features',
          builder: (context, state) => const FeaturesScreen(),
        ),
        GoRoute(
          path: '/onboarding/final',
          name: 'onboarding.final',
          builder: (context, state) => const FinalScreen(),
        ),

        // Auth routes
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
      ];

  // Helper to mark onboarding as completed
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
    _showOnboarding = false;
    notifyListeners();
  }
}

// Helper to access router notifier
final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

// Provider for checking if onboarding is completed
final onboardingCompletedProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hasCompletedOnboarding') ?? false;
});
