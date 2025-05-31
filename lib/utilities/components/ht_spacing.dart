import 'package:flutter/material.dart';

/// HTSpacing provides consistent spacing utilities for the Home Tender app
///
/// This class offers pre-defined spacing values and widgets for maintaining
/// a consistent layout system throughout the app.
class HTSpacing {
  HTSpacing._(); // Private constructor to prevent instantiation

  /// Spacing values in logical pixels
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  /// Horizontal spacing widgets

  /// Extra small horizontal space (4px)
  static const Widget horizontalXS = SizedBox(width: xs);

  /// Small horizontal space (8px)
  static const Widget horizontalSM = SizedBox(width: sm);

  /// Medium horizontal space (16px)
  static const Widget horizontalMD = SizedBox(width: md);

  /// Large horizontal space (24px)
  static const Widget horizontalLG = SizedBox(width: lg);

  /// Extra large horizontal space (32px)
  static const Widget horizontalXL = SizedBox(width: xl);

  /// Double extra large horizontal space (48px)
  static const Widget horizontalXXL = SizedBox(width: xxl);

  /// Vertical spacing widgets

  /// Extra small vertical space (4px)
  static const Widget verticalXS = SizedBox(height: xs);

  /// Small vertical space (8px)
  static const Widget verticalSM = SizedBox(height: sm);

  /// Medium vertical space (16px)
  static const Widget verticalMD = SizedBox(height: md);

  /// Large vertical space (24px)
  static const Widget verticalLG = SizedBox(height: lg);

  /// Extra large vertical space (32px)
  static const Widget verticalXL = SizedBox(height: xl);

  /// Double extra large vertical space (48px)
  static const Widget verticalXXL = SizedBox(height: xxl);

  /// Create a custom-sized horizontal space
  static Widget horizontalSpace(double width) => SizedBox(width: width);

  /// Create a custom-sized vertical space
  static Widget verticalSpace(double height) => SizedBox(height: height);

  /// Common padding values

  /// All sides padding - extra small (4px)
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);

  /// All sides padding - small (8px)
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);

  /// All sides padding - medium (16px)
  static const EdgeInsets paddingMD = EdgeInsets.all(md);

  /// All sides padding - large (24px)
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);

  /// All sides padding - extra large (32px)
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);

  /// Horizontal padding - extra small (4px)
  static const EdgeInsets paddingHorizontalXS =
      EdgeInsets.symmetric(horizontal: xs);

  /// Horizontal padding - small (8px)
  static const EdgeInsets paddingHorizontalSM =
      EdgeInsets.symmetric(horizontal: sm);

  /// Horizontal padding - medium (16px)
  static const EdgeInsets paddingHorizontalMD =
      EdgeInsets.symmetric(horizontal: md);

  /// Horizontal padding - large (24px)
  static const EdgeInsets paddingHorizontalLG =
      EdgeInsets.symmetric(horizontal: lg);

  /// Horizontal padding - extra large (32px)
  static const EdgeInsets paddingHorizontalXL =
      EdgeInsets.symmetric(horizontal: xl);

  /// Vertical padding - extra small (4px)
  static const EdgeInsets paddingVerticalXS =
      EdgeInsets.symmetric(vertical: xs);

  /// Vertical padding - small (8px)
  static const EdgeInsets paddingVerticalSM =
      EdgeInsets.symmetric(vertical: sm);

  /// Vertical padding - medium (16px)
  static const EdgeInsets paddingVerticalMD =
      EdgeInsets.symmetric(vertical: md);

  /// Vertical padding - large (24px)
  static const EdgeInsets paddingVerticalLG =
      EdgeInsets.symmetric(vertical: lg);

  /// Vertical padding - extra large (32px)
  static const EdgeInsets paddingVerticalXL =
      EdgeInsets.symmetric(vertical: xl);

  /// Common screen paddings

  /// Standard screen padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );

  /// Screen padding with extra horizontal space
  static const EdgeInsets screenPaddingWide = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  /// Content section padding
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: lg,
  );

  /// Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// Form field spacing
  static const double formFieldSpacing = md;

  /// Helper widget to add vertical space between form fields
  static const Widget formFieldSpacer = SizedBox(height: formFieldSpacing);

  /// Helper widget to add vertical space between sections
  static const Widget sectionSpacer = SizedBox(height: xl);
}

/// A responsive spacing system that adjusts based on screen size
class HTResponsiveSpacing {
  // Base spacing unit
  static const double _baseUnit = 8.0;

  /// Get scaled spacing based on screen width
  static double getResponsiveSpacing(BuildContext context, double multiplier) {
    final width = MediaQuery.of(context).size.width;

    // Scale factor between 0.8 and 1.2 based on screen width
    double scaleFactor = 1.0;

    if (width < 360) {
      // Small phones
      scaleFactor = 0.8;
    } else if (width >= 600) {
      // Tablets
      scaleFactor = 1.1;
    } else if (width >= 900) {
      // Large tablets
      scaleFactor = 1.2;
    }

    return _baseUnit * multiplier * scaleFactor;
  }

  /// Get responsive padding for screen content
  static EdgeInsets getScreenPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Default padding
    double horizontal = 16.0;
    double vertical = 16.0;

    if (width < 360) {
      // Small phones
      horizontal = 12.0;
      vertical = 12.0;
    } else if (width >= 600) {
      // Tablets
      horizontal = 24.0;
      vertical = 20.0;
    } else if (width >= 900) {
      // Large tablets
      horizontal = 32.0;
      vertical = 24.0;
    }

    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }
}

/// A spacer widget with built-in responsiveness
class HTSpacer extends StatelessWidget {
  final double height;
  final double width;
  final bool responsive;

  const HTSpacer({
    super.key,
    this.height = 0,
    this.width = 0,
    this.responsive = false,
  });

  /// Vertical spacer with preset sizes
  factory HTSpacer.vertical(HTSpacerSize size, {bool responsive = false}) {
    return HTSpacer(
      height: _getSpacerSize(size),
      responsive: responsive,
    );
  }

  /// Horizontal spacer with preset sizes
  factory HTSpacer.horizontal(HTSpacerSize size, {bool responsive = false}) {
    return HTSpacer(
      width: _getSpacerSize(size),
      responsive: responsive,
    );
  }

  static double _getSpacerSize(HTSpacerSize size) {
    switch (size) {
      case HTSpacerSize.xs:
        return HTSpacing.xs;
      case HTSpacerSize.sm:
        return HTSpacing.sm;
      case HTSpacerSize.md:
        return HTSpacing.md;
      case HTSpacerSize.lg:
        return HTSpacing.lg;
      case HTSpacerSize.xl:
        return HTSpacing.xl;
      case HTSpacerSize.xxl:
        return HTSpacing.xxl;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (responsive) {
      final responsiveHeight = height > 0
          ? HTResponsiveSpacing.getResponsiveSpacing(context, height / 8)
          : 0.0;

      final responsiveWidth = width > 0
          ? HTResponsiveSpacing.getResponsiveSpacing(context, width / 8)
          : 0.0;

      return SizedBox(
        height: responsiveHeight,
        width: responsiveWidth,
      );
    }

    return SizedBox(
      height: height,
      width: width,
    );
  }
}

/// A widget that applies consistent padding around its child
class HTPadding extends StatelessWidget {
  final Widget child;
  final HTEdgeInsets padding;
  final bool responsive;

  const HTPadding({
    super.key,
    required this.child,
    required this.padding,
    this.responsive = false,
  });

  /// Applies screen padding to the child
  factory HTPadding.screen({
    required Widget child,
    bool responsive = true,
  }) {
    return HTPadding(
      padding: HTEdgeInsets.screen(),
      responsive: responsive,
      child: child,
    );
  }

  /// Applies section padding to the child
  factory HTPadding.section({
    required Widget child,
    bool responsive = true,
  }) {
    return HTPadding(
      padding: HTEdgeInsets.section(),
      responsive: responsive,
      child: child,
    );
  }

  /// Applies card padding to the child
  factory HTPadding.card({
    required Widget child,
    bool responsive = true,
  }) {
    return HTPadding(
      padding: HTEdgeInsets.card(),
      responsive: responsive,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (responsive) {
      final EdgeInsets responsivePadding = padding.toEdgeInsets(context);
      return Padding(
        padding: responsivePadding,
        child: child,
      );
    }

    return Padding(
      padding: padding.toEdgeInsets(),
      child: child,
    );
  }
}

/// Helper class for creating consistent edge insets
class HTEdgeInsets {
  final double left;
  final double top;
  final double right;
  final double bottom;

  const HTEdgeInsets.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const HTEdgeInsets.symmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  const HTEdgeInsets.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  /// Standard screen padding
  factory HTEdgeInsets.screen() {
    return const HTEdgeInsets.symmetric(
      horizontal: HTSpacing.md,
      vertical: HTSpacing.md,
    );
  }

  /// Standard section padding
  factory HTEdgeInsets.section() {
    return const HTEdgeInsets.symmetric(
      horizontal: HTSpacing.md,
      vertical: HTSpacing.lg,
    );
  }

  /// Standard card padding
  factory HTEdgeInsets.card() {
    return const HTEdgeInsets.all(HTSpacing.md);
  }

  /// Convert to EdgeInsets
  EdgeInsets toEdgeInsets([BuildContext? context]) {
    if (context != null) {
      // Apply responsive scaling
      final scale = MediaQuery.of(context).textScaleFactor;
      final scaleFactor = scale > 1.0 ? 1.0 + (scale - 1.0) * 0.5 : 1.0;

      return EdgeInsets.only(
        left: left * scaleFactor,
        top: top * scaleFactor,
        right: right * scaleFactor,
        bottom: bottom * scaleFactor,
      );
    }

    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }
}

/// Spacer size options
enum HTSpacerSize {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
}
