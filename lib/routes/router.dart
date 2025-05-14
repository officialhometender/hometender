import 'package:HomeTender/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/features/auth/login/login_screen.dart';
import '../views/features/onboarding/onboarding_screen.dart';
import '../views/home.dart';

// Manage our route state with Riverpod
final routerProvider = Provider<GoRouter>((ref) {
  // Create a key for navigation state persistence
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstLaunch') == false;
  }

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteConstants.onboarding,
    debugLogDiagnostics: true,
    // Helpful for debugging navigation

    routes: [
      // Onboarding route
      GoRoute(
        path: RouteConstants.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Auth routes
      GoRoute(
        path: RouteConstants.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Home route
      GoRoute(
        path: RouteConstants.home,
        name: 'home',
        builder: (context, state) => const Home(),
      ),
    ],

    // Redirect based on auth state, etc. (we'll keep it simple for now)
    redirect: (context, state) {
      // You can add authentication logic here later
      return null; // No redirection for now
    },
  );
});
