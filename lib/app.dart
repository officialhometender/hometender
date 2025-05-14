import 'package:HomeTender/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/app_theme.dart';

/// HomeTender Nigeria - Main Application
///
/// Core application setup with theming and routing
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Configure system overlay style (status bar)
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Get router from provider
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // App information
      title: 'HomeTender Nigeria',
      debugShowCheckedModeBanner: false,

      // Routing configuration
      routerConfig: router,

      // Theme configuration
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
