// lib/theme/app_colors.dart
import 'package:flutter/material.dart';

/// App color palette - like SwiftUI's Color system but more comprehensive
class AppColors {
  // ============ BRAND COLORS ============
  /// Primary brand color - HomeTender Blue
  static const Color primary = Color(0xFF0048FC);

  /// Secondary brand colors
  static const Color guppie = Color(0xFF00FF8B);
  static const Color jasmine = Color(0xFFFDD778);
  static const Color mandarin = Color(0xFFEA7745);
  static const Color richBlack = Color(0xFF010704);
  static const Color aliceBlue = Color(0xFFE8F2FC);

  // ============ LIGHT THEME COLORS ============
  static const LightColors light = LightColors();

  // ============ DARK THEME COLORS ============
  static const DarkColors dark = DarkColors();

  // ============ NEUTRAL COLORS (SHARED) ============
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gray scale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // ============ SEMANTIC COLORS ============
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Success variations
  static const Color successLight = Color(0xFFECFDF5);
  static const Color successDark = Color(0xFF065F46);

  // Warning variations
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFF92400E);

  // Error variations
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color errorDark = Color(0xFF991B1B);

  // Info variations
  static const Color infoLight = Color(0xFFEFF6FF);
  static const Color infoDark = Color(0xFF1E40AF);
}

/// Base class for theme colors
abstract class BaseColors {
  const BaseColors();

  // Backgrounds
  Color get background;

  Color get surface;

  Color get surfaceVariant;

  Color get surfaceContainer;

  // Text colors
  Color get onBackground;

  Color get onSurface;

  Color get onSurfaceVariant;

  Color get onPrimary;

  Color get onSecondary;

  // Interactive elements
  Color get primary;

  Color get primaryContainer;

  Color get onPrimaryContainer;

  Color get secondary;

  Color get secondaryContainer;

  Color get onSecondaryContainer;

  // Borders and dividers
  Color get outline;

  Color get outlineVariant;

  // Special states
  Color get disabled;

  Color get disabledContainer;

  // Shadows
  Color get shadow;

  Color get elevation;
}

/// Light theme colors
class LightColors extends BaseColors {
  const LightColors();

  // Backgrounds
  Color get background => AppColors.white;

  Color get surface => AppColors.white;

  Color get surfaceVariant => AppColors.gray50;

  Color get surfaceContainer => AppColors.gray100;

  // Text colors
  Color get onBackground => AppColors.gray900;

  Color get onSurface => AppColors.gray900;

  Color get onSurfaceVariant => AppColors.gray600;

  Color get onPrimary => AppColors.white;

  Color get onSecondary => AppColors.richBlack;

  // Interactive elements
  Color get primary => AppColors.primary;

  Color get primaryContainer => AppColors.aliceBlue;

  Color get onPrimaryContainer => AppColors.primary;

  Color get secondary => AppColors.guppie;

  Color get secondaryContainer => const Color(0xFFE8FFF4);

  Color get onSecondaryContainer => const Color(0xFF003D20);

  // Borders and dividers
  Color get outline => AppColors.gray300;

  Color get outlineVariant => AppColors.gray200;

  // Special states
  Color get disabled => AppColors.gray400;

  Color get disabledContainer => AppColors.gray100;

  // Shadows
  Color get shadow => AppColors.black.withValues(alpha: 0.1);

  Color get elevation => AppColors.black.withValues(alpha: 0.05);
}

/// Dark theme colors
class DarkColors extends BaseColors {
  const DarkColors();

  // Backgrounds
  Color get background => const Color(0xFF0F0F0F);

  Color get surface => const Color(0xFF1A1A1A);

  Color get surfaceVariant => const Color(0xFF2A2A2A);

  Color get surfaceContainer => const Color(0xFF252525);

  // Text colors
  Color get onBackground => AppColors.gray100;

  Color get onSurface => AppColors.gray100;

  Color get onSurfaceVariant => AppColors.gray400;

  Color get onPrimary => AppColors.white;

  Color get onSecondary => AppColors.richBlack;

  // Interactive elements
  Color get primary => const Color(0xFF4A7CFF); // Lighter primary for dark mode
  Color get primaryContainer => const Color(0xFF1A2947);

  Color get onPrimaryContainer => const Color(0xFF9BB5FF);

  Color get secondary => AppColors.guppie;

  Color get secondaryContainer => const Color(0xFF003D20);

  Color get onSecondaryContainer => const Color(0xFF7DFFC0);

  // Borders and dividers
  Color get outline => AppColors.gray600;

  Color get outlineVariant => AppColors.gray700;

  // Special states
  Color get disabled => AppColors.gray600;

  Color get disabledContainer => AppColors.gray800;

  // Shadows
  Color get shadow => AppColors.black.withValues(alpha: 0.3);

  Color get elevation => AppColors.black.withValues(alpha: 0.2);
}

/// Extension to easily access theme colors from BuildContext
extension AppColorsExtension on BuildContext {
  /// Get current theme colors based on brightness
  /// Usage: context.colors.primary, context.colors.background, etc.
  BaseColors get colors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.light ? AppColors.light : AppColors.dark;
  }

  /// Check if current theme is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if current theme is light mode
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
}
