// lib/components/containers/app_card.dart
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Professional card component with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;
  final VoidCallback? onTap;
  final bool showShadow;
  final CardVariant variant;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.border,
    this.onTap,
    this.showShadow = true,
    this.variant = CardVariant.elevated,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Default values based on variant
    final defaultElevation = switch (variant) {
      CardVariant.elevated => AppSizing.elevationLow,
      CardVariant.outlined => 0.0,
      CardVariant.filled => 0.0,
    };

    final defaultBorder = switch (variant) {
      CardVariant.elevated => null,
      CardVariant.outlined =>
        Border.all(color: colors.outline, width: AppSizing.borderNormal),
      CardVariant.filled => null,
    };

    final defaultBackgroundColor = switch (variant) {
      CardVariant.elevated => colors.surface,
      CardVariant.outlined => colors.surface,
      CardVariant.filled => colors.surfaceVariant,
    };

    final effectiveElevation = elevation ?? defaultElevation;
    final effectiveBorder = border ?? defaultBorder;
    final effectiveBackgroundColor = backgroundColor ?? defaultBackgroundColor;

    final card = Container(
      padding: padding ?? AppSizing.paddingLarge,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: borderRadius ?? AppSizing.borderRadiusLarge,
        border: effectiveBorder,
        boxShadow: showShadow && effectiveElevation > 0
            ? [
                BoxShadow(
                  color: colors.shadow,
                  blurRadius: effectiveElevation * 2,
                  offset: Offset(0, effectiveElevation / 2),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? AppSizing.borderRadiusLarge,
          child: card,
        ),
      );
    }

    return card;
  }
}

/// Card variant options
enum CardVariant {
  /// Elevated card with shadow
  elevated,

  /// Outlined card with border
  outlined,

  /// Filled card with background color
  filled,
}
