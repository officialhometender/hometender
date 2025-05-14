// lib/routes/route_constants.dart
class RouteConstants {
  // Private constructor to prevent instantiation
  RouteConstants._();

  // App Routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Feature-specific routes
  static const String serviceDetails = '/service-details';
  static const String bookService = '/book-service';
  static const String serviceHistory = '/service-history';
  static const String notifications = '/notifications';
  static const String payment = '/payment';
  static const String chat = '/chat';

  // Onboarding specific routes
  static const String onboardingWelcome = '/onboarding/welcome';
  static const String onboardingFeatures = '/onboarding/features';
  static const String onboardingLocation = '/onboarding/location';
  static const String onboardingComplete = '/onboarding/complete';
}
