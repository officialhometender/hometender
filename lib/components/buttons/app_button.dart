// lib/components/buttons/app_button.dart
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Professional button component with multiple variants and sizes
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Button dimensions
    final height = switch (size) {
      ButtonSize.small => AppSizing.buttonSmall,
      ButtonSize.medium => AppSizing.buttonMedium,
      ButtonSize.large => AppSizing.buttonLarge,
      ButtonSize.extraLarge => AppSizing.buttonExtraLarge,
    };

    final padding = switch (size) {
      ButtonSize.small => const EdgeInsets.symmetric(
          horizontal: AppSizing.md, vertical: AppSizing.xs),
      ButtonSize.medium => const EdgeInsets.symmetric(
          horizontal: AppSizing.lg, vertical: AppSizing.sm),
      ButtonSize.large => const EdgeInsets.symmetric(
          horizontal: AppSizing.xl, vertical: AppSizing.md),
      ButtonSize.extraLarge => const EdgeInsets.symmetric(
          horizontal: AppSizing.xxl, vertical: AppSizing.lg),
    };

    // Button colors based on variant
    final (backgroundColor, foregroundColor, borderColor) = switch (variant) {
      ButtonVariant.primary => (
          colors.primary,
          colors.onPrimary,
          colors.primary
        ),
      ButtonVariant.secondary => (
          colors.secondary,
          colors.onSecondary,
          colors.secondary
        ),
      ButtonVariant.outline => (
          Colors.transparent,
          colors.primary,
          colors.primary
        ),
      ButtonVariant.ghost => (
          Colors.transparent,
          colors.primary,
          Colors.transparent
        ),
      ButtonVariant.danger => (
          AppColors.error,
          AppColors.white,
          AppColors.error
        ),
      ButtonVariant.success => (
          AppColors.success,
          AppColors.white,
          AppColors.success
        ),
    };

    final borderRadius = BorderRadius.circular(AppSizing.radiusMedium);

    return SizedBox(
      height: height,
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: variant == ButtonVariant.outline ||
                  variant == ButtonVariant.ghost
              ? BorderSide(color: borderColor, width: AppSizing.borderNormal)
              : null,
          elevation:
              variant == ButtonVariant.outline || variant == ButtonVariant.ghost
                  ? 0
                  : AppSizing.elevationLow,
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          disabledBackgroundColor: colors.disabled,
          disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        ),
        child: isLoading
            ? SizedBox(
                width: AppSizing.iconMedium,
                height: AppSizing.iconMedium,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppSizing.sm),
                  ],
                  Text(text),
                ],
              ),
      ),
    );
  }
}

/// Button size options
enum ButtonSize { small, medium, large, extraLarge }

/// Button variant options
enum ButtonVariant { primary, secondary, outline, ghost, danger, success }
