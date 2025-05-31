import 'package:flutter/material.dart';

import 'ht_spacing.dart';

/// HTCard is a versatile card component for Home Tender app
///
/// Features:
/// - Multiple variants (elevated, outlined, filled)
/// - Customizable padding and border radius
/// - Header and footer sections
/// - Clickable behavior with ripple effect
/// - Support for header actions
/// - Loading state
class HTCard extends StatelessWidget {
  final Widget? child;
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? footer;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? footerPadding;
  final double borderRadius;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final double elevation;
  final double? width;
  final double? height;
  final CardVariant variant;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? coverImage;
  final double? coverHeight;
  final BoxFit coverFit;

  const HTCard({
    super.key,
    this.child,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.actions,
    this.leading,
    this.footer,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.all(16.0),
    this.headerPadding,
    this.footerPadding,
    this.borderRadius = 12.0,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.elevation = 1.0,
    this.width,
    this.height,
    this.variant = CardVariant.elevated,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.coverImage,
    this.coverHeight,
    this.coverFit = BoxFit.cover,
  });

  /// Creates an elevated card with shadow
  factory HTCard.elevated({
    Key? key,
    Widget? child,
    String? title,
    Widget? titleWidget,
    String? subtitle,
    Widget? subtitleWidget,
    List<Widget>? actions,
    Widget? leading,
    Widget? footer,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? footerPadding,
    double borderRadius = 12.0,
    bool isLoading = false,
    Color? backgroundColor,
    double elevation = 1.0,
    double? width,
    double? height,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    Widget? coverImage,
    double? coverHeight,
    BoxFit coverFit = BoxFit.cover,
  }) {
    return HTCard(
      key: key,
      title: title,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      actions: actions,
      leading: leading,
      footer: footer,
      onTap: onTap,
      onLongPress: onLongPress,
      padding: padding,
      headerPadding: headerPadding,
      footerPadding: footerPadding,
      borderRadius: borderRadius,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      elevation: elevation,
      width: width,
      height: height,
      variant: CardVariant.elevated,
      crossAxisAlignment: crossAxisAlignment,
      coverImage: coverImage,
      coverHeight: coverHeight,
      coverFit: coverFit,
      child: child,
    );
  }

  /// Creates an outlined card with a border
  factory HTCard.outlined({
    Key? key,
    Widget? child,
    String? title,
    Widget? titleWidget,
    String? subtitle,
    Widget? subtitleWidget,
    List<Widget>? actions,
    Widget? leading,
    Widget? footer,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? footerPadding,
    double borderRadius = 12.0,
    bool isLoading = false,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    Widget? coverImage,
    double? coverHeight,
    BoxFit coverFit = BoxFit.cover,
  }) {
    return HTCard(
      key: key,
      title: title,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      actions: actions,
      leading: leading,
      footer: footer,
      onTap: onTap,
      onLongPress: onLongPress,
      padding: padding,
      headerPadding: headerPadding,
      footerPadding: footerPadding,
      borderRadius: borderRadius,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: 0,
      width: width,
      height: height,
      variant: CardVariant.outlined,
      crossAxisAlignment: crossAxisAlignment,
      coverImage: coverImage,
      coverHeight: coverHeight,
      coverFit: coverFit,
      child: child,
    );
  }

  /// Creates a filled card with a background color
  factory HTCard.filled({
    Key? key,
    Widget? child,
    String? title,
    Widget? titleWidget,
    String? subtitle,
    Widget? subtitleWidget,
    List<Widget>? actions,
    Widget? leading,
    Widget? footer,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? footerPadding,
    double borderRadius = 12.0,
    bool isLoading = false,
    Color? backgroundColor,
    double? width,
    double? height,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    Widget? coverImage,
    double? coverHeight,
    BoxFit coverFit = BoxFit.cover,
  }) {
    return HTCard(
      key: key,
      title: title,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      actions: actions,
      leading: leading,
      footer: footer,
      onTap: onTap,
      onLongPress: onLongPress,
      padding: padding,
      headerPadding: headerPadding,
      footerPadding: footerPadding,
      borderRadius: borderRadius,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      elevation: 0,
      width: width,
      height: height,
      variant: CardVariant.filled,
      crossAxisAlignment: crossAxisAlignment,
      coverImage: coverImage,
      coverHeight: coverHeight,
      coverFit: coverFit,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Determine background color based on variant and theme
    Color bgColor =
        backgroundColor ?? _getDefaultBackgroundColor(theme, isDarkMode);

    // Card shape
    ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: _getBorderSide(theme, isDarkMode),
    );

    // Build card content
    Widget cardContent = Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cover image if provided
        if (coverImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            child: SizedBox(
              width: double.infinity,
              height: coverHeight,
              child: coverImage!,
            ),
          ),
        ],

        // Header if needed
        if (_hasHeader()) ...[
          _buildHeader(context),
        ],

        // Main content
        if (child != null) ...[
          Padding(
            padding: _getContentPadding(),
            child: isLoading ? _buildLoadingIndicator(context) : child!,
          ),
        ] else if (isLoading) ...[
          Padding(
            padding: _getContentPadding(),
            child: _buildLoadingIndicator(context),
          ),
        ],

        // Footer if provided
        if (footer != null) ...[
          _buildFooter(context),
        ],
      ],
    );

    // Wrap in Material for proper ink effects if clickable
    Widget result = Material(
      type: MaterialType.card,
      color: bgColor,
      elevation: _getElevation(),
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: cardContent,
    );

    // Add InkWell for tap effect if onTap is provided
    if (onTap != null || onLongPress != null) {
      result = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(borderRadius),
        child: result,
      );
    }

    // Apply size constraints if specified
    if (width != null || height != null) {
      result = SizedBox(
        width: width,
        height: height,
        child: result,
      );
    }

    return result;
  }

  // Check if card has a header (title, subtitle, or actions)
  bool _hasHeader() {
    return title != null ||
        titleWidget != null ||
        subtitle != null ||
        subtitleWidget != null ||
        actions != null ||
        leading != null;
  }

  // Build the header section
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: headerPadding ??
          EdgeInsets.only(
            left: padding.horizontal / 2,
            right: padding.horizontal / 2,
            top: padding.vertical / 2,
            bottom: child != null ? 0 : padding.vertical / 2,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading widget if provided
          if (leading != null) ...[
            leading!,
            HTSpacing.horizontalSM,
          ],

          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                if (titleWidget != null) ...[
                  titleWidget!,
                ] else if (title != null) ...[
                  Text(
                    title!,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // Subtitle
                if (subtitleWidget != null) ...[
                  subtitleWidget!,
                ] else if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // Actions
          if (actions != null && actions!.isNotEmpty) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }

  // Build the footer section
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: footerPadding ??
          EdgeInsets.only(
            left: padding.horizontal / 2,
            right: padding.horizontal / 2,
            bottom: padding.vertical / 2,
            top: child != null ? 0 : padding.vertical / 2,
          ),
      child: footer,
    );
  }

  // Build loading indicator
  Widget _buildLoadingIndicator(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      ),
    );
  }

  // Get content padding
  EdgeInsetsGeometry _getContentPadding() {
    if (_hasHeader() && footer != null) {
      // If both header and footer exist, only pad sides
      return EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
      );
    } else if (_hasHeader()) {
      // If only header exists, pad sides and bottom
      return EdgeInsets.only(
        left: padding.horizontal / 2,
        right: padding.horizontal / 2,
        bottom: padding.vertical / 2,
      );
    } else if (footer != null) {
      // If only footer exists, pad sides and top
      return EdgeInsets.only(
        left: padding.horizontal / 2,
        right: padding.horizontal / 2,
        top: padding.vertical / 2,
      );
    } else {
      // If neither header nor footer, pad all sides
      return padding;
    }
  }

  // Get default background color based on variant and theme
  Color _getDefaultBackgroundColor(ThemeData theme, bool isDarkMode) {
    switch (variant) {
      case CardVariant.elevated:
      case CardVariant.outlined:
        return theme.cardTheme.color ?? theme.colorScheme.surface;
      case CardVariant.filled:
        return isDarkMode
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5);
    }
  }

  // Get border side based on variant and theme
  BorderSide _getBorderSide(ThemeData theme, bool isDarkMode) {
    if (variant == CardVariant.outlined) {
      return BorderSide(
        color: borderColor ?? theme.colorScheme.outline,
        width: 1.0,
      );
    }
    return BorderSide.none;
  }

  // Get elevation based on variant
  double _getElevation() {
    switch (variant) {
      case CardVariant.elevated:
        return elevation;
      case CardVariant.outlined:
      case CardVariant.filled:
        return 0;
    }
  }
}

/// Card variants
enum CardVariant {
  elevated,
  outlined,
  filled,
}

/// Extension for EdgeInsetsGeometry to access horizontal and vertical values
extension EdgeInsetsGeometryExtension on EdgeInsetsGeometry {
  double get horizontal {
    if (this is EdgeInsets) {
      final EdgeInsets edgeInsets = this as EdgeInsets;
      return edgeInsets.horizontal;
    }
    return 32.0; // Default fallback
  }

  double get vertical {
    if (this is EdgeInsets) {
      final EdgeInsets edgeInsets = this as EdgeInsets;
      return edgeInsets.vertical;
    }
    return 32.0; // Default fallback
  }
}
