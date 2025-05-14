// lib/widgets/app_text.dart
import 'package:flutter/material.dart';

import '../constants/app_color.dart';

enum TextSize {
  xs, // Extra Small
  sm, // Small
  md, // Medium
  lg, // Large
  xl, // Extra Large
  xxl, // Double Extra Large
  xxxl, // Triple Extra Large
}

enum TextWeight {
  light,
  regular,
  medium,
  semiBold,
  bold,
  extraBold,
}

class AppText extends StatelessWidget {
  final String text;
  final TextSize size;
  final TextWeight weight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool selectable;
  final double? letterSpacing;
  final double? lineHeight;
  final TextDecoration? decoration;
  final TextStyle? style;

  const AppText(
    this.text, {
    Key? key,
    this.size = TextSize.md,
    this.weight = TextWeight.regular,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  }) : super(key: key);

  // Named constructors for common text styles

  /// Heading 1 - xxxl bold text
  const AppText.h1(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.xxxl,
        weight = TextWeight.bold,
        super(key: key);

  /// Heading 2 - xxl bold text
  const AppText.h2(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.xxl,
        weight = TextWeight.bold,
        super(key: key);

  /// Heading 3 - xl semiBold text
  const AppText.h3(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.xl,
        weight = TextWeight.semiBold,
        super(key: key);

  /// Heading 4 - lg semiBold text
  const AppText.h4(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.lg,
        weight = TextWeight.semiBold,
        super(key: key);

  /// Subtitle - md medium text
  const AppText.subtitle(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.md,
        weight = TextWeight.medium,
        super(key: key);

  /// Body text - md regular text
  const AppText.body(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.md,
        weight = TextWeight.regular,
        super(key: key);

  /// Caption - sm regular text
  const AppText.caption(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.sm,
        weight = TextWeight.regular,
        super(key: key);

  /// Small caption - xs regular text
  const AppText.smallCaption(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.style,
  })  : size = TextSize.xs,
        weight = TextWeight.regular,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    // Get the default color based on theme mode if not specified
    final textColor = color ?? (isLight ? AppColors.gray900 : AppColors.gray50);

    // Map size enum to actual font size
    double fontSize;
    switch (size) {
      case TextSize.xs:
        fontSize = 12;
        break;
      case TextSize.sm:
        fontSize = 14;
        break;
      case TextSize.md:
        fontSize = 16;
        break;
      case TextSize.lg:
        fontSize = 18;
        break;
      case TextSize.xl:
        fontSize = 20;
        break;
      case TextSize.xxl:
        fontSize = 24;
        break;
      case TextSize.xxxl:
        fontSize = 32;
        break;
    }

    // Map weight enum to FontWeight
    FontWeight fontWeight;
    switch (weight) {
      case TextWeight.light:
        fontWeight = FontWeight.w300;
        break;
      case TextWeight.regular:
        fontWeight = FontWeight.w400;
        break;
      case TextWeight.medium:
        fontWeight = FontWeight.w500;
        break;
      case TextWeight.semiBold:
        fontWeight = FontWeight.w600;
        break;
      case TextWeight.bold:
        fontWeight = FontWeight.w700;
        break;
      case TextWeight.extraBold:
        fontWeight = FontWeight.w800;
        break;
    }

    // Combine into a TextStyle
    final textStyle = style?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          letterSpacing: letterSpacing,
          height: lineHeight,
          decoration: decoration,
        ) ??
        TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          letterSpacing: letterSpacing,
          height: lineHeight,
          decoration: decoration,
        );

    // Return either selectable or regular text
    if (selectable) {
      return SelectableText(
        text,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    } else {
      return Text(
        text,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
    }
  }
}
