// lib/widgets/app_spacing.dart
import 'package:flutter/material.dart';

/// A professional spacing system that provides consistent spacing throughout the app.
///
/// It supports:
/// - Predefined spacing values
/// - Responsive spacing based on screen size
/// - Custom spacing values
/// - Both horizontal and vertical spacing
/// - Special spacing for specific contexts (forms, sections, etc.)
class AppSpacing extends StatelessWidget {
  /// Predefined spacing values for consistency
  static const double xxxs = 2.0;
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  /// Spacing between form fields
  static const double formFieldSpacing = md; // Changed name here

  /// Spacing between form sections
  static const double formSectionSpacing = xl; // Changed name here

  /// Spacing for page padding
  static const double pagePadding = md;

  /// Spacing for card padding
  static const double cardPadding = md;

  /// Spacing between list items
  static const double listItemSpacing = sm; // Changed name here

  /// Spacing between buttons in a row
  static const double buttonGapSpacing = sm; // Changed name here

  /// The amount of space to add
  final double space;

  /// Whether this is horizontal or vertical spacing
  final Axis direction;

  /// Whether to apply responsive sizing
  final bool responsive;

  /// The sizing factor for responsive spacing
  /// (usually based on screen size)
  final double? responsiveFactor;

  /// Creates vertical spacing with a predefined size
  const AppSpacing.vertical({
    Key? key,
    required this.space,
    this.responsive = false,
    this.responsiveFactor,
  })  : direction = Axis.vertical,
        super(key: key);

  /// Creates horizontal spacing with a predefined size
  const AppSpacing.horizontal({
    Key? key,
    required this.space,
    this.responsive = false,
    this.responsiveFactor,
  })  : direction = Axis.horizontal,
        super(key: key);

  /// Creates vertical spacing with an extra small size (8px)
  const AppSpacing.verticalXS({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = xs,
        direction = Axis.vertical,
        super(key: key);

  /// Creates vertical spacing with a small size (12px)
  const AppSpacing.verticalSM({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = sm,
        direction = Axis.vertical,
        super(key: key);

  /// Creates vertical spacing with a medium size (16px)
  const AppSpacing.verticalMD({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = md,
        direction = Axis.vertical,
        super(key: key);

  /// Creates vertical spacing with a large size (24px)
  const AppSpacing.verticalLG({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = lg,
        direction = Axis.vertical,
        super(key: key);

  /// Creates vertical spacing with an extra large size (32px)
  const AppSpacing.verticalXL({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = xl,
        direction = Axis.vertical,
        super(key: key);

  /// Creates vertical spacing with an extra extra large size (48px)
  const AppSpacing.verticalXXL({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = xxl,
        direction = Axis.vertical,
        super(key: key);

  /// Creates horizontal spacing with an extra small size (8px)
  const AppSpacing.horizontalXS({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = xs,
        direction = Axis.horizontal,
        super(key: key);

  /// Creates horizontal spacing with a small size (12px)
  const AppSpacing.horizontalSM({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = sm,
        direction = Axis.horizontal,
        super(key: key);

  /// Creates horizontal spacing with a medium size (16px)
  const AppSpacing.horizontalMD({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = md,
        direction = Axis.horizontal,
        super(key: key);

  /// Creates horizontal spacing with a large size (24px)
  const AppSpacing.horizontalLG({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = lg,
        direction = Axis.horizontal,
        super(key: key);

  /// Creates horizontal spacing with an extra large size (32px)
  const AppSpacing.horizontalXL({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = xl,
        direction = Axis.horizontal,
        super(key: key);

  /// Creates horizontal spacing with an extra extra large size (48px)
  const AppSpacing.horizontalXXL({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = xxl,
        direction = Axis.horizontal,
        super(key: key);

  /// Creates spacing for form fields
  const AppSpacing.formField({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = formFieldSpacing,
        // Updated to use formFieldSpacing
        direction = Axis.vertical,
        super(key: key);

  /// Creates spacing between form sections
  const AppSpacing.formSection({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = formSectionSpacing,
        // Updated to use formSectionSpacing
        direction = Axis.vertical,
        super(key: key);

  /// Creates spacing for list items
  const AppSpacing.listItem({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = listItemSpacing,
        // Updated to use listItemSpacing
        direction = Axis.vertical,
        super(key: key);

  /// Creates spacing between buttons in a row
  const AppSpacing.buttonGap({
    Key? key,
    this.responsive = false,
    this.responsiveFactor,
  })  : space = buttonGapSpacing,
        // Updated to use buttonGapSpacing
        direction = Axis.horizontal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the actual space based on screen size if responsive
    double actualSpace = space;

    if (responsive) {
      // Get screen size
      final screenSize = MediaQuery.of(context).size;
      final screenWidth = screenSize.width;

      // Apply responsive factor or calculate one based on screen width
      double factor =
          responsiveFactor ?? _calculateResponsiveFactor(screenWidth);
      actualSpace = space * factor;
    }

    // Return SizedBox with appropriate dimensions
    return direction == Axis.vertical
        ? SizedBox(height: actualSpace)
        : SizedBox(width: actualSpace);
  }

  /// Calculates a responsive factor based on screen width
  double _calculateResponsiveFactor(double screenWidth) {
    if (screenWidth < 360) {
      return 0.8; // Small phones
    } else if (screenWidth < 600) {
      return 1.0; // Normal phones (baseline)
    } else if (screenWidth < 900) {
      return 1.2; // Large phones and small tablets
    } else if (screenWidth < 1200) {
      return 1.5; // Tablets
    } else {
      return 1.8; // Large tablets and desktops
    }
  }
}
