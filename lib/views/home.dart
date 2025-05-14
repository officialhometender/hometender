import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_color.dart';
import '../routes/route_constants.dart';
import '../widgets/app_text.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Log out and return to login
              context.go(RouteConstants.login);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.home_filled,
                  size: 80,
                  color: AppColors.primary600,
                ),
                const SizedBox(height: 24),
                AppText.h3(
                  'Welcome to HomeTender!',
                ),
                const SizedBox(height: 12),
                AppText.body(
                  'You have successfully logged in to your account.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to some other screen
                  },
                  child: const Text('Explore Services'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
