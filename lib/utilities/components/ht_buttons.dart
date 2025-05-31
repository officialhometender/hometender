import 'package:flutter/material.dart';

/// HTButton is a smart button component for Home Tender app
///
/// Features:
/// - Multiple variants (primary, secondary, outline, text)
/// - Automatic loading state with spinner
/// - Size variations (small, medium, large)
/// - Icon support (leading or trailing)
/// - Full width option
/// - Disabled state handling
class HTButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? borderRadius;

  const HTButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius,
  });

  /// Primary button constructor - blue background
  factory HTButton.primary({
    required String label,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? borderRadius,
  }) {
    return HTButton(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.primary,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
    );
  }

  /// Secondary button constructor - orange/mandarin color
  factory HTButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? borderRadius,
  }) {
    return HTButton(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.secondary,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
    );
  }

  /// Outline button constructor - transparent with border
  factory HTButton.outline({
    required String label,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? borderRadius,
  }) {
    return HTButton(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.outline,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
    );
  }

  /// Text button constructor - just text, no background
  factory HTButton.text({
    required String label,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? borderRadius,
  }) {
    return HTButton(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.text,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
    );
  }

  /// Success button constructor - green background
  factory HTButton.success({
    required String label,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? borderRadius,
  }) {
    return HTButton(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.success,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
    );
  }

  /// Danger/error button constructor - red background
  factory HTButton.danger({
    required String label,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? borderRadius,
  }) {
    return HTButton(
      label: label,
      onPressed: onPressed,
      variant: ButtonVariant.danger,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
    );
  }

  /// Get padding based on button size
  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  /// Get text style based on button size
  TextStyle _getTextStyle(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    switch (size) {
      case ButtonSize.small:
        return textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600);
      case ButtonSize.medium:
        return textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600);
      case ButtonSize.large:
        return textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600);
    }
  }

  /// Get icon size based on button size
  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  /// Get spacing between icon and text
  double _getSpacing() {
    switch (size) {
      case ButtonSize.small:
        return 4;
      case ButtonSize.medium:
        return 8;
      case ButtonSize.large:
        return 12;
    }
  }

  /// Get button height based on size
  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 56;
    }
  }

  /// Get button styles based on variant
  ButtonStyle _getButtonStyle(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final radius = borderRadius ?? 8.0;

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _getTextStyle(context),
          minimumSize: Size(0, _getHeight()),
        );

      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _getTextStyle(context),
          minimumSize: Size(0, _getHeight()),
        );

      case ButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _getTextStyle(context),
          minimumSize: Size(0, _getHeight()),
        );

      case ButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _getTextStyle(context),
          minimumSize: Size(0, _getHeight()),
        );

      case ButtonVariant.success:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.tertiary,
          foregroundColor: colorScheme.onTertiary,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _getTextStyle(context),
          minimumSize: Size(0, _getHeight()),
        );

      case ButtonVariant.danger:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _getTextStyle(context),
          minimumSize: Size(0, _getHeight()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = _getButtonStyle(context);
    final bool isDisabled = onPressed == null || isLoading;
    final Widget buttonContent = _buildButtonContent(context);

    // Determine which button type to use based on variant
    Widget button;
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.success:
      case ButtonVariant.danger:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: buttonContent,
        );
        break;

      case ButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: buttonContent,
        );
        break;

      case ButtonVariant.text:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: buttonContent,
        );
        break;
    }

    // Apply full width if needed
    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }

  /// Build the button content including icons, text and loading spinner
  Widget _buildButtonContent(BuildContext context) {
    final List<Widget> children = [];
    final double iconSize = _getIconSize();
    final double spacing = _getSpacing();
    final Color foregroundColor = _getForegroundColor(context);

    // Add loading spinner if in loading state
    if (isLoading) {
      return SizedBox(
        height: iconSize,
        width: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      );
    }

    // Add leading icon if provided
    if (leadingIcon != null) {
      children.add(Icon(leadingIcon, size: iconSize));
      children.add(SizedBox(width: spacing));
    }

    // Add text label
    children.add(Text(label));

    // Add trailing icon if provided
    if (trailingIcon != null) {
      children.add(SizedBox(width: spacing));
      children.add(Icon(trailingIcon, size: iconSize));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  /// Get foreground color based on variant and theme
  Color _getForegroundColor(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    switch (variant) {
      case ButtonVariant.primary:
        return colorScheme.onPrimary;
      case ButtonVariant.secondary:
        return colorScheme.onSecondary;
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return colorScheme.primary;
      case ButtonVariant.success:
        return colorScheme.onTertiary;
      case ButtonVariant.danger:
        return colorScheme.onError;
    }
  }
}

/// Button variants
enum ButtonVariant {
  primary,
  secondary,
  outline,
  text,
  success,
  danger,
}

/// Button sizes
enum ButtonSize {
  small,
  medium,
  large,
}
