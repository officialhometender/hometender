// lib/components/selections/app_chip.dart
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Professional chip component for filters and selections
class AppChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final bool selected;
  final ChipVariant variant;
  final ChipSize size;

  const AppChip({
    super.key,
    required this.label,
    this.avatar,
    this.onPressed,
    this.onDeleted,
    this.selected = false,
    this.variant = ChipVariant.outlined,
    this.size = ChipSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final (backgroundColor, foregroundColor, borderColor) = switch (variant) {
      ChipVariant.filled => selected
          ? (colors.primary, colors.onPrimary, colors.primary)
          : (colors.surfaceVariant, colors.onSurfaceVariant, colors.outline),
      ChipVariant.outlined => selected
          ? (colors.primaryContainer, colors.onPrimaryContainer, colors.primary)
          : (Colors.transparent, colors.onSurfaceVariant, colors.outline),
    };

    final padding = switch (size) {
      ChipSize.small => const EdgeInsets.symmetric(
          horizontal: AppSizing.sm, vertical: AppSizing.xs),
      ChipSize.medium => const EdgeInsets.symmetric(
          horizontal: AppSizing.md, vertical: AppSizing.sm),
      ChipSize.large => const EdgeInsets.symmetric(
          horizontal: AppSizing.lg, vertical: AppSizing.md),
    };

    final textStyle = switch (size) {
      ChipSize.small => Theme.of(context).textTheme.labelSmall,
      ChipSize.medium => Theme.of(context).textTheme.labelMedium,
      ChipSize.large => Theme.of(context).textTheme.labelLarge,
    };

    return FilterChip(
      label: Text(label),
      avatar: avatar,
      selected: selected,
      onSelected: onPressed != null ? (_) => onPressed!() : null,
      onDeleted: onDeleted,
      backgroundColor: backgroundColor,
      selectedColor: backgroundColor,
      labelStyle: textStyle?.copyWith(color: foregroundColor),
      side: BorderSide(color: borderColor, width: AppSizing.borderNormal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizing.radiusFull),
      ),
      padding: padding,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// Chip variant options
enum ChipVariant { filled, outlined }

/// Chip size options
enum ChipSize {
  small,
  medium,
  large,
}
