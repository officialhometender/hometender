// lib/constants/app_color.dart
import 'package:flutter/material.dart';

/// A professional color system for HomeTender Nigeria
/// This class provides a comprehensive set of colors for building a consistent UI
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  /// Brand Colors - Primary
  static const Color primaryBase = Color(0xFF0D1CFD);
  static const Color primary100 = Color(0xFFE8EAFF); // Lightest tint
  static const Color primary200 = Color(0xFFBDC2FF);
  static const Color primary300 = Color(0xFF949BFF);
  static const Color primary400 = Color(0xFF6C77FF);
  static const Color primary500 = Color(0xFF4353FF); // Base shade
  static const Color primary600 = Color(0xFF0D1CFD); // Original primary
  static const Color primary700 = Color(0xFF0B16CA);
  static const Color primary800 = Color(0xFF091098);
  static const Color primary900 = Color(0xFF060A65); // Darkest shade

  /// Secondary Colors - Guppie Green
  static const Color guppieBase = Color(0xFF00FF8B);
  static const Color guppie100 = Color(0xFFE6FFF3);
  static const Color guppie200 = Color(0xFFB3FFDC);
  static const Color guppie300 = Color(0xFF80FFC5);
  static const Color guppie400 = Color(0xFF4DFFAE);
  static const Color guppie500 = Color(0xFF1AFF98);
  static const Color guppie600 = Color(0xFF00FF8B); // Original Guppie
  static const Color guppie700 = Color(0xFF00CC6F);
  static const Color guppie800 = Color(0xFF009953);
  static const Color guppie900 = Color(0xFF006637);

  /// Secondary Colors - Jasmine
  static const Color jasmineBase = Color(0xFFFDD778);
  static const Color jasmine100 = Color(0xFFFFF9E6);
  static const Color jasmine200 = Color(0xFFFFF0B3);
  static const Color jasmine300 = Color(0xFFFFE780);
  static const Color jasmine400 = Color(0xFFFFDE4D);
  static const Color jasmine500 = Color(0xFFFFD41A);
  static const Color jasmine600 = Color(0xFFFDD778); // Original Jasmine
  static const Color jasmine700 = Color(0xFFCCA200);
  static const Color jasmine800 = Color(0xFF997A00);
  static const Color jasmine900 = Color(0xFF665100);

  /// Secondary Colors - Mandarin
  static const Color mandarinBase = Color(0xFFEA7745);
  static const Color mandarin100 = Color(0xFFFDEDE6);
  static const Color mandarin200 = Color(0xFFFACBB7);
  static const Color mandarin300 = Color(0xFFF7A988);
  static const Color mandarin400 = Color(0xFFF48859);
  static const Color mandarin500 = Color(0xFFF1662A);
  static const Color mandarin600 = Color(0xFFEA7745); // Original Mandarin
  static const Color mandarin700 = Color(0xFFBB4A15);
  static const Color mandarin800 = Color(0xFF8C3810);
  static const Color mandarin900 = Color(0xFF5E250B);

  /// Tertiary Colors - Alice Blue
  static const Color aliceBlueBase = Color(0xFFE8F2FC);
  static const Color aliceBlue100 = Color(0xFFE8F2FC); // Original Alice Blue
  static const Color aliceBlue200 = Color(0xFFD1E5F9);
  static const Color aliceBlue300 = Color(0xFFADD2F6);
  static const Color aliceBlue400 = Color(0xFF8ABEF2);
  static const Color aliceBlue500 = Color(0xFF66ABEE);
  static const Color aliceBlue600 = Color(0xFF4398EB);
  static const Color aliceBlue700 = Color(0xFF1F84E7);
  static const Color aliceBlue800 = Color(0xFF126AC5);
  static const Color aliceBlue900 = Color(0xFF0D5093);

  /// Tertiary Colors - Rich Black
  static const Color richBlackBase = Color(0xFF010704);
  static const Color richBlack100 = Color(0xFF363B38);
  static const Color richBlack200 = Color(0xFF2E332F);
  static const Color richBlack300 = Color(0xFF262B27);
  static const Color richBlack400 = Color(0xFF1E231F);
  static const Color richBlack500 = Color(0xFF171B18);
  static const Color richBlack600 = Color(0xFF0F130F);
  static const Color richBlack700 = Color(0xFF080C08);
  static const Color richBlack800 = Color(0xFF040704);
  static const Color richBlack900 = Color(0xFF010704); // Original Rich Black

  /// Semantic Colors - For status indicators, etc.
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color successDark = Color(0xFF166534);

  static const Color warning = Color(0xFFFACC15);
  static const Color warningLight = Color(0xFFFEF9C3);
  static const Color warningDark = Color(0xFFCA8A04);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFB91C1C);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDEECFD);
  static const Color infoDark = Color(0xFF1E40AF);

  /// Neutral Colors - For text, backgrounds, etc.
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  /// Gray palette - Professional gradations
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  /// Surface colors - For cards, dialogs, etc.
  static const Color surfaceLight = white;
  static const Color surfaceDark = Color(0xFF1A1A1A);

  /// Background colors - For screen backgrounds
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF121212);

  /// Brand gradient - For special UI elements
  static const List<Color> primaryGradient = [
    primary600,
    primary800,
  ];

  static const List<Color> secondaryGradient = [
    guppie600,
    jasmine600,
  ];

  /// Get a color based on the theme brightness
  static Color getColor(BuildContext context, Color lightColor, Color darkColor) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  /// Get the appropriate surface color based on theme
  static Color surfaceColor(BuildContext context) {
    return getColor(context, surfaceLight, surfaceDark);
  }

  /// Get the appropriate background color based on theme
  static Color backgroundColor(BuildContext context) {
    return getColor(context, backgroundLight, backgroundDark);
  }

  /// Get the appropriate text color based on theme
  static Color textPrimaryColor(BuildContext context) {
    return getColor(context, gray900, gray50);
  }

  /// Get the appropriate text secondary color based on theme
  static Color textSecondaryColor(BuildContext context) {
    return getColor(context, gray600, gray400);
  }

  /// Get the appropriate divider color based on theme
  static Color dividerColor(BuildContext context) {
    return getColor(context, gray200, gray800);
  }

  /// Get the appropriate shadow color based on theme
  static Color shadowColor(BuildContext context) {
    return getColor(context,
        black.withOpacity(0.1),
        black.withOpacity(0.3)
    );
  }

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get a dynamic color that changes with app state
  static MaterialStateProperty<Color?> getMaterialStateColor({
    required Color defaultColor,
    Color? hoverColor,
    Color? focusColor,
    Color? pressedColor,
    Color? disabledColor,
  }) {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return disabledColor ?? defaultColor.withOpacity(0.5);
      }
      if (states.contains(MaterialState.pressed)) {
        return pressedColor ?? defaultColor.withOpacity(0.8);
      }
      if (states.contains(MaterialState.hovered)) {
        return hoverColor ?? defaultColor.withOpacity(0.9);
      }
      if (states.contains(MaterialState.focused)) {
        return focusColor ?? defaultColor;
      }
      return defaultColor;
    });
  }
}