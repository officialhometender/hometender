// lib/views/home.dart
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeTender'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Show theme colors demo
              _showColorsDemo(context);
            },
            icon: const Icon(Icons.palette),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to HomeTender',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your trusted home care platform',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Demo buttons showing theme colors
            Text(
              'Theme Colors Demo',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            // Primary button
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Button'),
            ),

            const SizedBox(height: 8),

            // Secondary button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colors.secondary,
                side: BorderSide(color: context.colors.secondary),
              ),
              child: const Text('Secondary Button'),
            ),

            const SizedBox(height: 8),

            // Text button
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),

            const SizedBox(height: 24),

            // Theme info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    context.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: context.colors.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Current theme: ${context.isDarkMode ? 'Dark' : 'Light'} Mode',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: context.colors.onPrimaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Brand colors showcase
            Text(
              'Brand Colors',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ColorChip('Primary', AppColors.primary),
                _ColorChip('Guppie', AppColors.guppie),
                _ColorChip('Jasmine', AppColors.jasmine),
                _ColorChip('Mandarin', AppColors.mandarin),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('HomeTender theme system is working! 🎨'),
            ),
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }

  void _showColorsDemo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Theme Colors'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ColorRow('Primary', context.colors.primary),
              _ColorRow('Secondary', context.colors.secondary),
              _ColorRow('Background', context.colors.background),
              _ColorRow('Surface', context.colors.surface),
              _ColorRow('On Surface', context.colors.onSurface),
              _ColorRow('Outline', context.colors.outline),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colors.outline,
              width: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorRow(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: context.colors.outline,
                width: 1,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}
