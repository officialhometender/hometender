// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

/// App theme configuration - like SwiftUI's theme system but more comprehensive
class AppTheme {
  // ============ TYPOGRAPHY ============
  static const String _fontFamily =
      'Inter'; // You can change this to your preferred font

  static const TextTheme _textTheme = TextTheme(
    // Display styles (largest)
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
    ),

    // Headline styles
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.33,
    ),

    // Title styles
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.50,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.43,
    ),

    // Label styles
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
    ),

    // Body styles
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
  );

  // ============ ELEVATION LEVELS ============
  static const double elevation0 = 0;
  static const double elevation1 = 1;
  static const double elevation2 = 3;
  static const double elevation3 = 6;
  static const double elevation4 = 8;
  static const double elevation5 = 12;

  // ============ BORDER RADIUS ============
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(6));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radius2xl = BorderRadius.all(Radius.circular(20));
  static const BorderRadius radius3xl = BorderRadius.all(Radius.circular(24));

  // ============ LIGHT THEME ============
  static ThemeData get lightTheme {
    const colors = AppColors.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: _fontFamily,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        primaryContainer: colors.primaryContainer,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondaryContainer: colors.onSecondaryContainer,
        surface: colors.surface,
        onSurface: colors.onSurface,
        surfaceVariant: colors.surfaceVariant,
        onSurfaceVariant: colors.onSurfaceVariant,
        background: colors.background,
        onBackground: colors.onBackground,
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.errorLight,
        onErrorContainer: AppColors.errorDark,
        outline: colors.outline,
        outlineVariant: colors.outlineVariant,
        shadow: colors.shadow,
      ),

      // Text theme
      textTheme: _textTheme.apply(
        bodyColor: colors.onSurface,
        displayColor: colors.onSurface,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: elevation0,
        scrolledUnderElevation: elevation1,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: colors.primary,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Bottom navigation theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: elevation2,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: colors.surface,
        surfaceTintColor: colors.primary,
        elevation: elevation1,
        shape: const RoundedRectangleBorder(borderRadius: radiusLg),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colors.surfaceVariant,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: elevation2,
          shape: const RoundedRectangleBorder(borderRadius: radiusMd),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _textTheme.labelLarge,
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.outline),
          shape: const RoundedRectangleBorder(borderRadius: radiusMd),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _textTheme.labelLarge,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          shape: const RoundedRectangleBorder(borderRadius: radiusMd),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: _textTheme.labelLarge,
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: elevation3,
        shape: const RoundedRectangleBorder(borderRadius: radiusLg),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceVariant,
        selectedColor: colors.primaryContainer,
        labelStyle:
            _textTheme.labelMedium?.copyWith(color: colors.onSurfaceVariant),
        shape: const RoundedRectangleBorder(borderRadius: radiusSm),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),

      // Dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: colors.surface,
        surfaceTintColor: colors.primary,
        elevation: elevation5,
        shape: const RoundedRectangleBorder(borderRadius: radiusXl),
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: colors.primary,
        elevation: elevation4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.surfaceVariant,
        circularTrackColor: colors.surfaceVariant,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colors.onPrimary;
          }
          return colors.outline;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colors.primary;
          }
          return colors.surfaceVariant;
        }),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // ============ DARK THEME ============
  static ThemeData get darkTheme {
    const colors = AppColors.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: _fontFamily,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        primaryContainer: colors.primaryContainer,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondaryContainer: colors.onSecondaryContainer,
        surface: colors.surface,
        onSurface: colors.onSurface,
        surfaceVariant: colors.surfaceVariant,
        onSurfaceVariant: colors.onSurfaceVariant,
        background: colors.background,
        onBackground: colors.onBackground,
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.errorLight,
        outline: colors.outline,
        outlineVariant: colors.outlineVariant,
        shadow: colors.shadow,
      ),

      // Text theme
      textTheme: _textTheme.apply(
        bodyColor: colors.onSurface,
        displayColor: colors.onSurface,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: elevation0,
        scrolledUnderElevation: elevation1,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: colors.primary,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Bottom navigation theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: elevation2,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: colors.surface,
        surfaceTintColor: colors.primary,
        elevation: elevation1,
        shape: const RoundedRectangleBorder(borderRadius: radiusLg),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colors.surfaceVariant,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radiusMd,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: elevation2,
          shape: const RoundedRectangleBorder(borderRadius: radiusMd),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _textTheme.labelLarge,
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.outline),
          shape: const RoundedRectangleBorder(borderRadius: radiusMd),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _textTheme.labelLarge,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          shape: const RoundedRectangleBorder(borderRadius: radiusMd),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: _textTheme.labelLarge,
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: elevation3,
        shape: const RoundedRectangleBorder(borderRadius: radiusLg),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceVariant,
        selectedColor: colors.primaryContainer,
        labelStyle:
            _textTheme.labelMedium?.copyWith(color: colors.onSurfaceVariant),
        shape: const RoundedRectangleBorder(borderRadius: radiusSm),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),

      // Dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: colors.surface,
        surfaceTintColor: colors.primary,
        elevation: elevation5,
        shape: const RoundedRectangleBorder(borderRadius: radiusXl),
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: colors.primary,
        elevation: elevation4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.surfaceVariant,
        circularTrackColor: colors.surfaceVariant,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colors.onPrimary;
          }
          return colors.outline;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colors.primary;
          }
          return colors.surfaceVariant;
        }),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
