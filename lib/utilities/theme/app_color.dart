import 'package:flutter/material.dart';

/// AppColors defines the color palette for the Home Tender application.
/// This class provides both light and dark mode colors for various UI components.
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Brand primary colors
  static const Color primaryBlue = Color(0xFF0048FC);
  static const Color mandarin = Color(0xFFEA7745);
  static const Color jasmin = Color(0xFFFDD778);
  static const Color guppie = Color(0xFF00FF8B);
  static const Color aliceBlue = Color(0xFFE8F2FC);
  static const Color richBlack = Color(0xFF010704);

  // Primary color shades (for buttons, highlights, etc.)
  static const Color primaryLight = Color(0xFF4B7EFF);
  static const Color primaryDark = Color(0xFF0035BD);

  // Secondary colors - adjusted for better visual harmony
  static const Color secondaryOrange = Color(0xFFEA7745); // Mandarin
  static const Color secondaryOrangeSoft =
      Color(0xFFF2A07B); // Softer version for light mode
  static const Color secondaryYellow = Color(0xFFFDD778); // Jasmin
  static const Color secondaryYellowSoft =
      Color(0xFFFEE5A8); // Softer version for light mode
  static const Color secondaryGreen = Color(0xFF00FF8B); // Guppie
  static const Color secondaryGreenSoft =
      Color(0xFF66FFBA); // Softer version for light mode

  // Dark mode adjusted secondary colors (less harsh)
  static const Color darkModeOrange = Color(0xFFD06A3D);
  static const Color darkModeYellow = Color(0xFFEBC55E);
  static const Color darkModeGreen = Color(0xFF00D676);

  // Neutral colors for backgrounds, cards, etc.
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark =
      Color(0xFF121212); // Slightly lighter than richBlack for usability
  static const Color surfaceLight = Color(0xFFF5F9FF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF252525);

  // Text colors
  static const Color textDark = Color(0xFF121212);
  static const Color textLight = Color(0xFFF9F9F9);
  static const Color textSecondaryDark = Color(0xFF5B5B5B);
  static const Color textSecondaryLight = Color(0xFFD5D5D5);

  // Feedback colors (success, error, warning, info)
  static const Color success = Color(0xFF00C853);
  static const Color successDark = Color(0xFF009D41);
  static const Color error = Color(0xFFFF3B30);
  static const Color errorDark = Color(0xFFCC2F26);
  static const Color warning = Color(0xFFFFCC00);
  static const Color warningDark = Color(0xFFD9AD00);
  static const Color info = primaryBlue;
  static const Color infoDark = primaryDark;

  // Input field colors
  static const Color inputBorderLight = Color(0xFFE0E0E0);
  static const Color inputBorderDark = Color(0xFF3D3D3D);
  static const Color inputFilledLight = Color(0xFFF5F5F5);
  static const Color inputFilledDark = Color(0xFF2A2A2A);

  // Divider and border colors
  static const Color dividerLight = Color(0xFFEEEEEE);
  static const Color dividerDark = Color(0xFF2E2E2E);

  // Overlay and shadow colors
  static const Color shadowLight = Color(0x1A000000); // 10% opacity black
  static const Color shadowDark = Color(0x1A000000); // 10% opacity black
  static const Color overlayLight = Color(0x80000000); // 50% opacity black
  static const Color overlayDark = Color(0x80000000); // 50% opacity black

  // Shimmer effect colors (for loading states)
  static const Color shimmerBaseLight = Color(0xFFF0F0F0);
  static const Color shimmerHighlightLight = Color(0xFFFFFFFF);
  static const Color shimmerBaseeDark = Color(0xFF2A2A2A);
  static const Color shimmerHighlightDark = Color(0xFF3D3D3D);

  // Get color based on brightness
  static Color getColor({
    required Color lightModeColor,
    required Color darkModeColor,
    required Brightness brightness,
  }) {
    return brightness == Brightness.light ? lightModeColor : darkModeColor;
  }
}
