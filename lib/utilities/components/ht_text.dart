import 'package:flutter/material.dart';

/// HTText is a versatile text component for Home Tender app
///
/// Features:
/// - All text style variants from the app theme
/// - Rich text support with spans
/// - Custom styling options (color, weight, etc.)
/// - Max lines and overflow handling
/// - Custom decoration (underline, strikethrough)
/// - Gradients and shadows
class HTText extends StatelessWidget {
  final String text;
  final TextVariant variant;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool selectable;
  final bool softWrap;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final List<Shadow>? shadows;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final List<InlineSpan>? children;

  const HTText(
    this.text, {
    super.key,
    this.variant = TextVariant.body,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.selectable = false,
    this.softWrap = true,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.letterSpacing,
    this.shadows,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.gradient,
    this.onTap,
    this.children,
  });

  /// Display large text style (32px)
  factory HTText.displayLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.displayLarge,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Display medium text style (28px)
  factory HTText.displayMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.displayMedium,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Display small text style (24px)
  factory HTText.displaySmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.displaySmall,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Headline large text style (22px)
  factory HTText.headlineLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.headlineLarge,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Headline medium text style (20px)
  factory HTText.headlineMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.headlineMedium,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Headline small text style (18px)
  factory HTText.headlineSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.headlineSmall,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Title large text style (16px)
  factory HTText.titleLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.titleLarge,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Title medium text style (14px)
  factory HTText.titleMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.titleMedium,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Title small text style (12px)
  factory HTText.titleSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.titleSmall,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Body large text style (16px)
  factory HTText.bodyLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.bodyLarge,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Body medium text style (14px)
  factory HTText.bodyMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.bodyMedium,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Body small text style (12px)
  factory HTText.bodySmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.bodySmall,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Label large text style (14px)
  factory HTText.labelLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.labelLarge,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Label medium text style (12px)
  factory HTText.labelMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.labelMedium,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Label small text style (10px)
  factory HTText.labelSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: TextVariant.labelSmall,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Truncate text with ellipsis at the end if it exceeds max lines
  factory HTText.truncate(
    String text, {
    Key? key,
    TextVariant variant = TextVariant.body,
    TextAlign? textAlign,
    int maxLines = 1,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Gradient? gradient,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: variant,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Gradient text with a linear gradient
  factory HTText.gradient(
    String text, {
    Key? key,
    required Gradient gradient,
    TextVariant variant = TextVariant.body,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool selectable = false,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: variant,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      gradient: gradient,
      onTap: onTap,
      children: children,
    );
  }

  /// Clickable text with tap handler
  factory HTText.clickable(
    String text, {
    Key? key,
    required VoidCallback onTap,
    TextVariant variant = TextVariant.body,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    List<Shadow>? shadows,
    TextDecoration decoration = TextDecoration.underline,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<InlineSpan>? children,
  }) {
    return HTText(
      text,
      key: key,
      variant: variant,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      onTap: onTap,
      children: children,
    );
  }

  /// Price text with currency symbol
  factory HTText.price(
    double price, {
    Key? key,
    String currencySymbol = '₦',
    bool showDecimal = true,
    TextVariant variant = TextVariant.titleLarge,
    TextAlign? textAlign,
    Color? color,
    FontWeight? fontWeight,
    VoidCallback? onTap,
  }) {
    final formattedPrice =
        showDecimal ? price.toStringAsFixed(2) : price.toStringAsFixed(0);

    return HTText(
      '$currencySymbol$formattedPrice',
      key: key,
      variant: variant,
      textAlign: textAlign,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w600,
      onTap: onTap,
    );
  }

  /// Get theme text style based on variant
  TextStyle _getBaseStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (variant) {
      case TextVariant.displayLarge:
        return textTheme.displayLarge!;
      case TextVariant.displayMedium:
        return textTheme.displayMedium!;
      case TextVariant.displaySmall:
        return textTheme.displaySmall!;
      case TextVariant.headlineLarge:
        return textTheme.headlineLarge!;
      case TextVariant.headlineMedium:
        return textTheme.headlineMedium!;
      case TextVariant.headlineSmall:
        return textTheme.headlineSmall!;
      case TextVariant.titleLarge:
        return textTheme.titleLarge!;
      case TextVariant.titleMedium:
        return textTheme.titleMedium!;
      case TextVariant.titleSmall:
        return textTheme.titleSmall!;
      case TextVariant.bodyLarge:
        return textTheme.bodyLarge!;
      case TextVariant.bodyMedium:
        return textTheme.bodyMedium!;
      case TextVariant.bodySmall:
        return textTheme.bodySmall!;
      case TextVariant.labelLarge:
        return textTheme.labelLarge!;
      case TextVariant.labelMedium:
        return textTheme.labelMedium!;
      case TextVariant.labelSmall:
        return textTheme.labelSmall!;
      case TextVariant.body:
        return textTheme.bodyMedium!;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get base style from theme based on variant
    final baseStyle = _getBaseStyle(context);

    // Apply custom style overrides
    TextStyle style = baseStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );

    // Build the text widget
    Widget textWidget;

    // Handle gradient if specified
    if (gradient != null) {
      textWidget = ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(bounds),
        child: selectable
            ? SelectableText(
                text,
                style: style.copyWith(color: Colors.white),
                textAlign: textAlign,
                maxLines: maxLines,
              )
            : Text(
                text,
                style: style.copyWith(color: Colors.white),
                textAlign: textAlign,
                overflow: overflow,
                maxLines: maxLines,
                softWrap: softWrap,
              ),
      );
    } else {
      // Regular text or selectable text
      textWidget = selectable
          ? SelectableText.rich(
              TextSpan(
                text: text,
                children: children,
                style: style,
              ),
              textAlign: textAlign,
              maxLines: maxLines,
            )
          : Text.rich(
              TextSpan(
                text: text,
                children: children,
                style: style,
              ),
              textAlign: textAlign,
              overflow: overflow,
              maxLines: maxLines,
              softWrap: softWrap,
            );
    }

    // Wrap with InkWell if onTap is provided
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// Text style variants
enum TextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  body, // Default (bodyMedium)
}
