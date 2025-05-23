// lib/app.dart
import 'package:flutter/material.dart';
import 'package:home_tender/screens/onboarding/onboarding.dart';

import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeTender',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Follows system setting

      // Start with welcome screen instead of home
      home: const WelcomeScreen(),

      // Additional app configuration
      builder: (context, child) {
        return MediaQuery(
          // Ensure text doesn't scale beyond reasonable limits
          data: MediaQuery.of(context).copyWith(
            textScaleFactor:
                MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.4),
          ),
          child: child!,
        );
      },
    );
  }
}
