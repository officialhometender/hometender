// lib/widgets/app_button.dart
import 'package:flutter/material.dart';
import '../constants/app_color.dart';

enum ButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  success,
  warning,
  error,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius = 12.0,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;

    // Determine button styling based on variant
    late final Color backgroundColor;
    late final Color textColor;
    late final Color borderColor;

    // Configure colors based on variant and brightness
    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = isLight ? AppColors.primary600 : AppColors.primary500;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.secondary:
        backgroundColor = isLight ? AppColors.guppie600 : AppColors.guppie500;
        textColor = isLight ? AppColors.richBlack900 : Colors.white;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.outlined:
        backgroundColor = Colors.transparent;
        textColor = isLight ? AppColors.primary600 : AppColors.primary500;
        borderColor = isLight ? AppColors.primary600 : AppColors.primary500;
        break;
      case ButtonVariant.text:
        backgroundColor = Colors.transparent;
        textColor = isLight ? AppColors.primary600 : AppColors.primary500;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.success:
        backgroundColor = AppColors.success;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.warning:
        backgroundColor = AppColors.warning;
        textColor = AppColors.richBlack900;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.error:
        backgroundColor = AppColors.error;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
    }

    // Configure dimensions based on size
    late final double buttonHeight;
    late final double buttonIconSize;
    late final double buttonTextSize;
    late final FontWeight buttonTextWeight;
    late final EdgeInsetsGeometry buttonPadding;

    switch (size) {
      case ButtonSize.small:
        buttonHeight = height ?? 36;
        buttonIconSize = 16;
        buttonTextSize = 12;
        buttonTextWeight = FontWeight.w500;
        buttonPadding = padding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        break;
      case ButtonSize.medium:
        buttonHeight = height ?? 44;
        buttonIconSize = 18;
        buttonTextSize = 14;
        buttonTextWeight = FontWeight.w500;
        buttonPadding = padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
        break;
      case ButtonSize.large:
        buttonHeight = height ?? 52;
        buttonIconSize = 20;
        buttonTextSize = 16;
        buttonTextWeight = FontWeight.w600;
        buttonPadding = padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
        break;
    }

    // Build button content with optional icons and loading state
    Widget buttonContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              width: buttonIconSize,
              height: buttonIconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
            ),
          )
        else if (leadingIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              leadingIcon,
              size: buttonIconSize,
              color: textColor,
            ),
          ),
        Flexible(
          child: Text(
            text,
            style: textStyle ?? TextStyle(
              fontSize: buttonTextSize,
              fontWeight: buttonTextWeight,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailingIcon != null && !isLoading)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              trailingIcon,
              size: buttonIconSize,
              color: textColor,
            ),
          ),
      ],
    );

    // Create the button based on variant
    Widget button;

    // Common properties for button container
    final buttonWidth = width ?? (isFullWidth ? double.infinity : null);

    switch (variant) {
      case ButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: backgroundColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            textStyle: TextStyle(
              fontSize: buttonTextSize,
              fontWeight: buttonTextWeight,
            ),
          ),
          child: buttonContent,
        );
        break;

      case ButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: backgroundColor,
            side: BorderSide(color: borderColor, width: 2),
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            textStyle: TextStyle(
              fontSize: buttonTextSize,
              fontWeight: buttonTextWeight,
            ),
          ),
          child: buttonContent,
        );
        break;

      default:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: backgroundColor,
            padding: buttonPadding,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            textStyle: TextStyle(
              fontSize: buttonTextSize,
              fontWeight: buttonTextWeight,
            ),
          ),
          child: buttonContent,
        );
    }

    // Wrap button in a fixed height container if needed
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: button,
    );
  }
}