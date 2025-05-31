import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ht_buttons.dart';
import 'ht_spacing.dart';
import 'ht_text.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 80,
                  color: Colors.red,
                ),
                HTSpacing.verticalLG,
                HTText.headlineMedium(
                  'Oops! Something went wrong',
                  textAlign: TextAlign.center,
                ),
                HTSpacing.verticalMD,
                if (error != null)
                  HTText.bodyMedium(
                    error.toString(),
                    textAlign: TextAlign.center,
                    color: Theme.of(context).colorScheme.error,
                  ),
                HTSpacing.verticalXL,
                HTButton.primary(
                  label: 'Go Home',
                  onPressed: () => context.go('/'),
                  leadingIcon: Icons.home,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
