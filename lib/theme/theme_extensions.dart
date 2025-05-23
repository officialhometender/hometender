// lib/theme/theme_extensions.dart
import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Convenient extensions for accessing theme values
extension ThemeExtensions on BuildContext {
  /// Quick access to text styles
  TextTheme get textStyles => Theme.of(this).textTheme;

  /// Quick access to color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick access to elevation values
  AppElevations get elevations => const AppElevations();

  /// Quick access to spacing values
  AppSpacing get spacing => const AppSpacing();

  /// Quick access to border radius values
  AppRadius get radius => const AppRadius();

  /// Quick access to animation durations
  AppDurations get durations => const AppDurations();
}

/// Elevation constants for Material Design
class AppElevations {
  const AppElevations();

  double get none => AppTheme.elevation0;

  double get low => AppTheme.elevation1;

  double get medium => AppTheme.elevation2;

  double get high => AppTheme.elevation3;

  double get higher => AppTheme.elevation4;

  double get highest => AppTheme.elevation5;
}

/// Spacing constants following Material Design guidelines
class AppSpacing {
  const AppSpacing();

  // Base spacing units (following 8dp grid system)
  static const double _baseUnit = 8.0;

  double get xs => _baseUnit * 0.5; // 4
  double get sm => _baseUnit * 1; // 8
  double get md => _baseUnit * 2; // 16
  double get lg => _baseUnit * 3; // 24
  double get xl => _baseUnit * 4; // 32
  double get xxl => _baseUnit * 5; // 40
  double get xxxl => _baseUnit * 6; // 48

  // Common padding values
  EdgeInsets get paddingXs => EdgeInsets.all(xs);

  EdgeInsets get paddingSm => EdgeInsets.all(sm);

  EdgeInsets get paddingMd => EdgeInsets.all(md);

  EdgeInsets get paddingLg => EdgeInsets.all(lg);

  EdgeInsets get paddingXl => EdgeInsets.all(xl);

  // Symmetric padding
  EdgeInsets get horizontalXs => EdgeInsets.symmetric(horizontal: xs);

  EdgeInsets get horizontalSm => EdgeInsets.symmetric(horizontal: sm);

  EdgeInsets get horizontalMd => EdgeInsets.symmetric(horizontal: md);

  EdgeInsets get horizontalLg => EdgeInsets.symmetric(horizontal: lg);

  EdgeInsets get verticalXs => EdgeInsets.symmetric(vertical: xs);

  EdgeInsets get verticalSm => EdgeInsets.symmetric(vertical: sm);

  EdgeInsets get verticalMd => EdgeInsets.symmetric(vertical: md);

  EdgeInsets get verticalLg => EdgeInsets.symmetric(vertical: lg);

  // Screen margins
  EdgeInsets get screenPadding => EdgeInsets.all(md);

  EdgeInsets get screenPaddingHorizontal =>
      EdgeInsets.symmetric(horizontal: md);

  EdgeInsets get screenPaddingVertical => EdgeInsets.symmetric(vertical: md);
}

/// Border radius constants for consistent UI elements
class AppRadius {
  const AppRadius();

  BorderRadius get xs => AppTheme.radiusXs;

  BorderRadius get sm => AppTheme.radiusSm;

  BorderRadius get md => AppTheme.radiusMd;

  BorderRadius get lg => AppTheme.radiusLg;

  BorderRadius get xl => AppTheme.radiusXl;

  BorderRadius get xxl => AppTheme.radius2xl;

  BorderRadius get xxxl => AppTheme.radius3xl;

  // Circular radius
  BorderRadius get circular => const BorderRadius.all(Radius.circular(1000));

  // Top only radius
  BorderRadius get topSm =>
      const BorderRadius.vertical(top: Radius.circular(6));

  BorderRadius get topMd =>
      const BorderRadius.vertical(top: Radius.circular(8));

  BorderRadius get topLg =>
      const BorderRadius.vertical(top: Radius.circular(12));

  BorderRadius get topXl =>
      const BorderRadius.vertical(top: Radius.circular(16));

  // Bottom only radius
  BorderRadius get bottomSm =>
      const BorderRadius.vertical(bottom: Radius.circular(6));

  BorderRadius get bottomMd =>
      const BorderRadius.vertical(bottom: Radius.circular(8));

  BorderRadius get bottomLg =>
      const BorderRadius.vertical(bottom: Radius.circular(12));

  BorderRadius get bottomXl =>
      const BorderRadius.vertical(bottom: Radius.circular(16));
}

/// Animation duration constants for smooth transitions
class AppDurations {
  const AppDurations();

  Duration get instant => const Duration(milliseconds: 0);

  Duration get fast => const Duration(milliseconds: 150);

  Duration get normal => const Duration(milliseconds: 300);

  Duration get slow => const Duration(milliseconds: 500);

  Duration get slower => const Duration(milliseconds: 800);

  // Common animation curves
  Curve get easeIn => Curves.easeIn;

  Curve get easeOut => Curves.easeOut;

  Curve get easeInOut => Curves.easeInOut;

  Curve get bounceIn => Curves.bounceIn;

  Curve get bounceOut => Curves.bounceOut;

  Curve get elastic => Curves.elasticOut;
}

/// Box shadow presets for elevation effects
class AppShadows {
  static List<BoxShadow> get none => [];

  static List<BoxShadow> get sm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get md => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get lg => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get xl => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];
}

/// Common widget modifiers for cleaner code
extension WidgetExtensions on Widget {
  /// Add padding
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget paddingOnly(
          {double left = 0,
          double right = 0,
          double top = 0,
          double bottom = 0}) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  /// Add margin using Container
  Widget marginAll(double value) => Container(
        margin: EdgeInsets.all(value),
        child: this,
      );

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      Container(
        margin:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  /// Add border radius
  Widget withRadius(BorderRadius radius) => ClipRRect(
        borderRadius: radius,
        child: this,
      );

  /// Add shadow
  Widget withShadow(List<BoxShadow> shadows) => Container(
        decoration: BoxDecoration(
          boxShadow: shadows,
        ),
        child: this,
      );

  /// Make widget expandable
  Widget get expanded => Expanded(child: this);

  /// Make widget flexible
  Widget flexible([int flex = 1]) => Flexible(flex: flex, child: this);

  /// Center widget
  Widget get center => Center(child: this);

  /// Add tap gesture
  Widget onTap(VoidCallback? onTap) => GestureDetector(
        onTap: onTap,
        child: this,
      );

  /// Add opacity
  Widget withOpacity(double opacity) => Opacity(
        opacity: opacity,
        child: this,
      );
}
