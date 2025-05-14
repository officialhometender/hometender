// lib/widgets/app_form_card.dart
import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class AppFormCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool hasShadow;

  const AppFormCard({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.onTap,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final cardColor =
        backgroundColor ?? (isLight ? Colors.white : AppColors.surfaceDark);

    // Card content with title, subtitle and children
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: theme.textTheme.titleMedium,
          ),
          if (subtitle != null) const SizedBox(height: 4),
        ],
        if (subtitle != null) ...[
          Text(
            subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isLight ? AppColors.gray600 : AppColors.gray400,
            ),
          ),
          const SizedBox(height: 16),
        ] else if (title != null) ...[
          const SizedBox(height: 16),
        ],
        ...children,
      ],
    );

    // Decoration for the card
    final boxDecoration = BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isLight ? AppColors.gray200 : AppColors.gray800,
        width: 1,
      ),
      boxShadow: hasShadow
          ? [
              BoxShadow(
                color: isLight
                    ? Colors.black.withOpacity(0.05)
                    : Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
    );

    // Build card with optional tap behavior
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: onTap != null
            ? theme.colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
        highlightColor: onTap != null
            ? theme.colorScheme.primary.withOpacity(0.05)
            : Colors.transparent,
        child: Ink(
          decoration: boxDecoration,
          child: Padding(
            padding: padding,
            child: content,
          ),
        ),
      ),
    );
  }
}
