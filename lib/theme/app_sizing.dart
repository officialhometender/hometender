// lib/theme/app_sizing.dart
import 'package:flutter/material.dart';

/// Comprehensive sizing system for consistent dimensions across the app
class AppSizing {
  // ============ BASE SPACING UNITS ============
  static const double _baseUnit = 4.0;

  // ============ SPACING SCALE ============
  /// Extra small spacing - 4px
  static const double xs = _baseUnit * 1;

  /// Small spacing - 8px
  static const double sm = _baseUnit * 2;

  /// Medium spacing - 12px
  static const double md = _baseUnit * 3;

  /// Large spacing - 16px
  static const double lg = _baseUnit * 4;

  /// Extra large spacing - 20px
  static const double xl = _baseUnit * 5;

  /// 2X large spacing - 24px
  static const double xxl = _baseUnit * 6;

  /// 3X large spacing - 32px
  static const double xxxl = _baseUnit * 8;

  /// 4X large spacing - 40px
  static const double xxxxl = _baseUnit * 10;

  // ============ COMPONENT HEIGHTS ============
  /// Button heights
  static const double buttonSmall = 32;
  static const double buttonMedium = 44;
  static const double buttonLarge = 52;
  static const double buttonExtraLarge = 60;

  /// Input field heights
  static const double inputSmall = 36;
  static const double inputMedium = 44;
  static const double inputLarge = 52;

  /// App bar and navigation
  static const double appBarHeight = 56;
  static const double tabBarHeight = 48;
  static const double bottomNavHeight = 60;

  /// List items
  static const double listItemSmall = 48;
  static const double listItemMedium = 56;
  static const double listItemLarge = 72;

  /// Cards and containers
  static const double cardMinHeight = 120;
  static const double cardMediumHeight = 160;
  static const double cardLargeHeight = 200;

  // ============ COMPONENT WIDTHS ============
  /// Button widths
  static const double buttonMinWidth = 88;
  static const double buttonMediumWidth = 120;
  static const double buttonLargeWidth = 160;

  /// Input field widths (for specific use cases)
  static const double inputSmallWidth = 80;
  static const double inputMediumWidth = 120;

  // ============ ICON SIZES ============
  /// Tiny icon - 12px
  static const double iconTiny = 12;

  /// Small icon - 16px
  static const double iconSmall = 16;

  /// Medium icon - 20px
  static const double iconMedium = 20;

  /// Large icon - 24px
  static const double iconLarge = 24;

  /// Extra large icon - 32px
  static const double iconXLarge = 32;

  /// 2X large icon - 40px
  static const double iconXXLarge = 40;

  /// 3X large icon - 48px
  static const double iconXXXLarge = 48;

  // ============ AVATAR SIZES ============
  static const double avatarSmall = 24;
  static const double avatarMedium = 32;
  static const double avatarLarge = 40;
  static const double avatarXLarge = 56;
  static const double avatarXXLarge = 72;
  static const double avatarXXXLarge = 96;

  // ============ BORDER WIDTHS ============
  static const double borderThin = 0.5;
  static const double borderNormal = 1.0;
  static const double borderThick = 2.0;
  static const double borderExtraThick = 3.0;

  // ============ BORDER RADIUS ============
  static const double radiusNone = 0;
  static const double radiusSmall = 4;
  static const double radiusMedium = 8;
  static const double radiusLarge = 12;
  static const double radiusXLarge = 16;
  static const double radiusXXLarge = 20;
  static const double radiusXXXLarge = 24;
  static const double radiusFull = 9999; // For fully rounded elements

  // ============ SCREEN DIMENSIONS ============
  /// Maximum content width (for tablets/desktop)
  static const double maxContentWidth = 480;

  /// Maximum form width
  static const double maxFormWidth = 400;

  /// Minimum touch target size (accessibility)
  static const double minTouchTarget = 44;

  // ============ ELEVATION LEVELS ============
  static const double elevationNone = 0;
  static const double elevationLow = 1;
  static const double elevationMedium = 4;
  static const double elevationHigh = 8;
  static const double elevationHigher = 12;
  static const double elevationHighest = 16;

  // ============ HELPFUL SIZE CLASSES ============

  /// Common button sizes
  static const Size buttonSizeSmall = Size(buttonMediumWidth, buttonSmall);
  static const Size buttonSizeMedium = Size(buttonLargeWidth, buttonMedium);
  static const Size buttonSizeLarge = Size(200, buttonLarge);

  /// Common padding values
  static const EdgeInsets paddingTiny = EdgeInsets.all(xs);
  static const EdgeInsets paddingSmall = EdgeInsets.all(sm);
  static const EdgeInsets paddingMedium = EdgeInsets.all(md);
  static const EdgeInsets paddingLarge = EdgeInsets.all(lg);
  static const EdgeInsets paddingXLarge = EdgeInsets.all(xl);

  /// Horizontal padding
  static const EdgeInsets paddingHorizontalSmall =
      EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMedium =
      EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLarge =
      EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHorizontalXLarge =
      EdgeInsets.symmetric(horizontal: xl);

  /// Vertical padding
  static const EdgeInsets paddingVerticalSmall =
      EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMedium =
      EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLarge =
      EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingVerticalXLarge =
      EdgeInsets.symmetric(vertical: xl);

  /// Screen-level padding
  static const EdgeInsets screenPadding = EdgeInsets.all(lg);
  static const EdgeInsets screenPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets screenPaddingVertical =
      EdgeInsets.symmetric(vertical: lg);

  /// Form padding
  static const EdgeInsets formPadding = EdgeInsets.all(xl);
  static const EdgeInsets formItemSpacing = EdgeInsets.only(bottom: lg);

  // ============ COMMON BORDER RADIUS VALUES ============
  static const BorderRadius borderRadiusSmall =
      BorderRadius.all(Radius.circular(radiusSmall));
  static const BorderRadius borderRadiusMedium =
      BorderRadius.all(Radius.circular(radiusMedium));
  static const BorderRadius borderRadiusLarge =
      BorderRadius.all(Radius.circular(radiusLarge));
  static const BorderRadius borderRadiusXLarge =
      BorderRadius.all(Radius.circular(radiusXLarge));
  static const BorderRadius borderRadiusXXLarge =
      BorderRadius.all(Radius.circular(radiusXXLarge));

  /// Circular border radius
  static const BorderRadius borderRadiusCircular =
      BorderRadius.all(Radius.circular(radiusFull));

  /// Top-only border radius
  static const BorderRadius borderRadiusTopSmall =
      BorderRadius.vertical(top: Radius.circular(radiusSmall));
  static const BorderRadius borderRadiusTopMedium =
      BorderRadius.vertical(top: Radius.circular(radiusMedium));
  static const BorderRadius borderRadiusTopLarge =
      BorderRadius.vertical(top: Radius.circular(radiusLarge));

  /// Bottom-only border radius
  static const BorderRadius borderRadiusBottomSmall =
      BorderRadius.vertical(bottom: Radius.circular(radiusSmall));
  static const BorderRadius borderRadiusBottomMedium =
      BorderRadius.vertical(bottom: Radius.circular(radiusMedium));
  static const BorderRadius borderRadiusBottomLarge =
      BorderRadius.vertical(bottom: Radius.circular(radiusLarge));

  // ============ RESPONSIVE HELPERS ============

  /// Get responsive padding based on screen width
  static EdgeInsets responsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return screenPadding;
    } else if (width < 768) {
      return const EdgeInsets.all(xl);
    } else {
      return const EdgeInsets.all(xxl);
    }
  }

  /// Get responsive content width
  static double responsiveContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return width - (lg * 2);
    } else {
      return maxContentWidth.clamp(0, width - (xl * 2));
    }
  }

  /// Check if screen is small (phone)
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 480;
  }

  /// Check if screen is medium (tablet)
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 480 && width < 768;
  }

  /// Check if screen is large (desktop)
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768;
  }
}

/// Extension for easy access to sizing values
extension SizingExtension on BuildContext {
  /// Quick access to sizing constants
  AppSizing get sizing => AppSizing();

  /// Get responsive padding
  EdgeInsets get responsivePadding => AppSizing.responsivePadding(this);

  /// Get responsive content width
  double get responsiveContentWidth => AppSizing.responsiveContentWidth(this);

  /// Screen size helpers
  bool get isSmallScreen => AppSizing.isSmallScreen(this);

  bool get isMediumScreen => AppSizing.isMediumScreen(this);

  bool get isLargeScreen => AppSizing.isLargeScreen(this);
}
