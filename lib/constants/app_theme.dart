// lib/constants/app_theme.dart
import 'package:flutter/material.dart';
import 'app_color.dart';

/// A professional theme for HomeTender Nigeria
/// This class provides theme data for both light and dark modes
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  /// Font family configuration
  static const String _fontFamily = 'Poppins'; // You can change this to your desired font

  /// Default border radius values
  static const double _borderRadiusSmall = 4.0;
  static const double _borderRadiusMedium = 8.0;
  static const double _borderRadiusLarge = 12.0;
  static const double _borderRadiusExtraLarge = 16.0;
  static const double _borderRadiusRound = 24.0;

  /// Default padding values
  static const double _paddingSmall = 8.0;
  static const double _paddingMedium = 16.0;
  static const double _paddingLarge = 24.0;
  static const double _paddingExtraLarge = 32.0;

  /// Animation duration
  static const Duration _animationDuration = Duration(milliseconds: 200);

  /// Light theme
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: _fontFamily,

      // Primary color configurations
      primaryColor: AppColors.primary600,
      primaryColorLight: AppColors.primary400,
      primaryColorDark: AppColors.primary800,

      // Color scheme configuration
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary600,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primary100,
        onPrimaryContainer: AppColors.primary900,

        secondary: AppColors.guppie600,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.guppie100,
        onSecondaryContainer: AppColors.guppie900,

        tertiary: AppColors.jasmine600,
        onTertiary: AppColors.richBlack900,
        tertiaryContainer: AppColors.jasmine100,
        onTertiaryContainer: AppColors.jasmine900,

        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.errorLight,
        onErrorContainer: AppColors.errorDark,

        background: AppColors.backgroundLight,
        onBackground: AppColors.gray900,

        surface: AppColors.surfaceLight,
        onSurface: AppColors.gray900,

        surfaceVariant: AppColors.gray100,
        onSurfaceVariant: AppColors.gray700,

        outline: AppColors.gray300,
        outlineVariant: AppColors.gray200,

        // Shadow color for elevation
        shadow: Colors.black12,
      ),

      // Application visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Animation theming
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // Scaffolding theme (overall app background)
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // App bar theme
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        foregroundColor: AppColors.gray900,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.gray900,
        ),
        iconTheme: IconThemeData(
          color: AppColors.gray900,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary600,
        unselectedItemColor: AppColors.gray500,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Tab bar theme
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primary600,
        unselectedLabelColor: AppColors.gray500,
        indicatorColor: AppColors.primary600,
        labelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadiusLarge),
            topRight: Radius.circular(_borderRadiusLarge),
          ),
        ),
      ),

      // Card theme
      cardTheme: const CardTheme(
        color: AppColors.white,
        elevation: 2,
        shadowColor: Colors.black12,
        margin: EdgeInsets.all(_paddingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusMedium)),
        ),
      ),

      // Dialog theme
      dialogTheme: const DialogTheme(
        backgroundColor: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusMedium)),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.gray200,
        thickness: 1,
        space: 1,
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary600,
        circularTrackColor: AppColors.primary100,
        linearTrackColor: AppColors.primary100,
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray300;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary600;
          }
          return AppColors.gray300;
        }),
        checkColor: MaterialStateProperty.all(AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusSmall),
        ),
        side: const BorderSide(
          color: AppColors.gray400,
          width: 1.5,
        ),
      ),

      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray300;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary600;
          }
          return AppColors.gray400;
        }),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray300;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary600;
          }
          return AppColors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray200;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary200;
          }
          return AppColors.gray300;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray200;
          }
          return Colors.transparent;
        }),
      ),

      // Slider theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primary600,
        inactiveTrackColor: AppColors.primary100,
        thumbColor: AppColors.primary600,
        valueIndicatorColor: AppColors.primary600,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),

      // Snackbar theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.gray800,
        contentTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
        ),
        actionTextColor: AppColors.primary300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusMedium)),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Tooltip theme
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.gray800,
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusSmall)),
        ),
        textStyle: TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray100,
        disabledColor: AppColors.gray200,
        selectedColor: AppColors.primary100,
        secondarySelectedColor: AppColors.primary600,
        padding: const EdgeInsets.symmetric(
          horizontal: _paddingMedium,
          vertical: _paddingSmall,
        ),
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray800,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusRound),
          side: const BorderSide(
            color: AppColors.gray300,
          ),
        ),
      ),

      // Text theme - comprehensive and professional
      textTheme: const TextTheme(
        // Display styles
        displayLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: AppColors.gray900,
        ),
        displayMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),
        displaySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),

        // Headline styles
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        headlineSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),

        // Title styles
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: AppColors.gray900,
        ),
        titleSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.gray900,
        ),

        // Body styles
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: AppColors.gray800,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.gray800,
        ),
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.gray700,
        ),

        // Label styles
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.gray900,
        ),
        labelMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.gray800,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.gray700,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: _paddingMedium,
          vertical: _paddingMedium,
        ),

        // Border styles
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.gray300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primary600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.gray200, width: 1),
        ),

        // Text styles
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray700,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray500,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.error,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        helperStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray600,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),

        // Icon styling
        prefixIconColor: AppColors.gray600,
        suffixIconColor: AppColors.gray600,

        // Animation
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray300;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primary700;
            }
            return AppColors.primary600;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray500;
            }
            return Colors.white;
          }),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: _paddingLarge,
              vertical: _paddingMedium,
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadiusMedium),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray500;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primary700;
            }
            return AppColors.primary600;
          }),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(color: AppColors.gray300);
            }
            if (states.contains(MaterialState.pressed)) {
              return const BorderSide(color: AppColors.primary700, width: 2);
            }
            return const BorderSide(color: AppColors.primary600, width: 2);
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: _paddingLarge,
              vertical: _paddingMedium,
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadiusMedium),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray500;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primary700;
            }
            return AppColors.primary600;
          }),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: _paddingMedium,
              vertical: _paddingSmall,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }

  /// Dark theme
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: _fontFamily,

      // Primary color configurations
      primaryColor: AppColors.primary600,
      primaryColorLight: AppColors.primary300,
      primaryColorDark: AppColors.primary900,

      // Color scheme configuration
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary500,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primary900,
        onPrimaryContainer: AppColors.primary100,

        secondary: AppColors.guppie500,
        onSecondary: Colors.black,
        secondaryContainer: AppColors.guppie900,
        onSecondaryContainer: AppColors.guppie100,

        tertiary: AppColors.jasmine500,
        onTertiary: Colors.black,
        tertiaryContainer: AppColors.jasmine900,
        onTertiaryContainer: AppColors.jasmine100,

        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.errorLight,

        background: AppColors.backgroundDark,
        onBackground: AppColors.gray50,

        surface: AppColors.surfaceDark,
        onSurface: AppColors.gray50,

        surfaceVariant: AppColors.gray800,
        onSurfaceVariant: AppColors.gray300,

        outline: AppColors.gray700,
        outlineVariant: AppColors.gray800,

        // Shadow color for elevation
        shadow: Colors.black54,
      ),

      // Application visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Animation theming
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // Scaffolding theme (overall app background)
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // App bar theme
      appBarTheme: const AppBarTheme(
        color: AppColors.surfaceDark,
        foregroundColor: AppColors.gray50,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.gray50,
        ),
        iconTheme: IconThemeData(
          color: AppColors.gray50,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primary400,
        unselectedItemColor: AppColors.gray400,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Tab bar theme
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primary400,
        unselectedLabelColor: AppColors.gray400,
        indicatorColor: AppColors.primary400,
        labelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadiusLarge),
            topRight: Radius.circular(_borderRadiusLarge),
          ),
        ),
      ),

      // Card theme
      cardTheme: const CardTheme(
        color: AppColors.surfaceDark,
        elevation: 2,
        shadowColor: Colors.black54,
        margin: EdgeInsets.all(_paddingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusMedium)),
        ),
      ),

      // Dialog theme
      dialogTheme: const DialogTheme(
        backgroundColor: AppColors.surfaceDark,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusMedium)),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.gray800,
        thickness: 1,
        space: 1,
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary400,
        circularTrackColor: AppColors.primary900,
        linearTrackColor: AppColors.primary900,
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray700;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary500;
          }
          return AppColors.gray700;
        }),
        checkColor: MaterialStateProperty.all(AppColors.backgroundDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusSmall),
        ),
        side: const BorderSide(
          color: AppColors.gray600,
          width: 1.5,
        ),
      ),

      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray700;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary500;
          }
          return AppColors.gray600;
        }),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray700;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary500;
          }
          return AppColors.gray400;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray800;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary900;
          }
          return AppColors.gray700;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gray800;
          }
          return Colors.transparent;
        }),
      ),

      // Slider theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primary500,
        inactiveTrackColor: AppColors.primary900,
        thumbColor: AppColors.primary500,
        valueIndicatorColor: AppColors.primary500,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),

      // Snackbar theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.gray900,
        contentTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
        ),
        actionTextColor: AppColors.primary300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusMedium)),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Tooltip theme
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.gray900,
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusSmall)),
        ),
        textStyle: TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray800,
        disabledColor: AppColors.gray900,
        selectedColor: AppColors.primary900,
        secondarySelectedColor: AppColors.primary500,
        padding: const EdgeInsets.symmetric(
          horizontal: _paddingMedium,
          vertical: _paddingSmall,
        ),
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray200,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
        ),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusRound),
          side: const BorderSide(
            color: AppColors.gray700,
          ),
        ),
      ),

      // Text theme - comprehensive and professional
      textTheme: const TextTheme(
        // Display styles
        displayLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: AppColors.gray50,
        ),
        displayMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: AppColors.gray50,
        ),
        displaySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.gray50,
        ),

        // Headline styles
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.gray50,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.gray50,
        ),
        headlineSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.gray50,
        ),

        // Title styles
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.gray50,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: AppColors.gray50,
        ),
        titleSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.gray100,
        ),

        // Body styles
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: AppColors.gray200,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.gray200,
        ),
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.gray300,
        ),

        // Label styles
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.gray100,
        ),
        labelMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.gray200,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.gray300,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: _paddingMedium,
          vertical: _paddingMedium,
        ),

        // Border styles
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.gray700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primary500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.gray800, width: 1),
        ),

        // Text styles
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray300,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray500,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.error,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        helperStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.gray400,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),

        // Icon styling
        prefixIconColor: AppColors.gray400,
        suffixIconColor: AppColors.gray400,

        // Animation
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray700;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primary600;
            }
            return AppColors.primary500;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray500;
            }
            return Colors.white;
          }),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: _paddingLarge,
              vertical: _paddingMedium,
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadiusMedium),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray500;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primary400;
            }
            return AppColors.primary500;
          }),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(color: AppColors.gray700);
            }
            if (states.contains(MaterialState.pressed)) {
              return const BorderSide(color: AppColors.primary400, width: 2);
            }
            return const BorderSide(color: AppColors.primary500, width: 2);
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: _paddingLarge,
              vertical: _paddingMedium,
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadiusMedium),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.gray500;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primary400;
            }
            return AppColors.primary500;
          }),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: _paddingMedium,
              vertical: _paddingSmall,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }

  /// Helper method to get an appropriate theme based on platform
  static ThemeData getThemeForPlatform(BuildContext context) {
    final platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.iOS:
        return light().copyWith(
          // iOS-specific theme adjustments
          appBarTheme: const AppBarTheme(
            color: AppColors.white,
            foregroundColor: AppColors.gray900,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.gray900,
            ),
          ),
        );

      case TargetPlatform.android:
      default:
        return light(); // Default theme
    }
  }

  /// Method to update text size scale factor for accessibility
  static ThemeData withTextScaleFactor(ThemeData theme, double scaleFactor) {
    return theme.copyWith(
      textTheme: theme.textTheme.apply(
        fontSizeFactor: scaleFactor,
        fontSizeDelta: 0.0,
      ),
      primaryTextTheme: theme.primaryTextTheme.apply(
        fontSizeFactor: scaleFactor,
        fontSizeDelta: 0.0,
      ),
    );
  }

  /// Method to create a custom theme with a specific primary color
  static ThemeData withCustomColor(Color primaryColor) {
    final light = AppTheme.light();
    final colorScheme = light.colorScheme.copyWith(
      primary: primaryColor,
      primaryContainer: primaryColor.withOpacity(0.2),
    );

    return light.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
    );
  }
}