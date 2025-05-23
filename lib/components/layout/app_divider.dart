// lib/components/layout/app_divider.dart
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Custom divider component with consistent styling
class AppDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;
  final DividerType type;
  final String? label;

  const AppDivider({
    super.key,
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
    this.type = DividerType.horizontal,
    this.label,
  });

  /// Horizontal divider with label
  const AppDivider.withLabel({
    super.key,
    required this.label,
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  }) : type = DividerType.horizontal;

  /// Vertical divider
  const AppDivider.vertical({
    super.key,
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  })  : type = DividerType.vertical,
        label = null;

  /// Thin divider
  const AppDivider.thin({
    super.key,
    this.height,
    this.color,
    this.indent,
    this.endIndent,
    this.label,
  })  : thickness = AppSizing.borderThin,
        type = DividerType.horizontal;

  /// Thick divider
  const AppDivider.thick({
    super.key,
    this.height,
    this.color,
    this.indent,
    this.endIndent,
    this.label,
  })  : thickness = AppSizing.borderThick,
        type = DividerType.horizontal;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveColor = color ?? colors.outlineVariant;
    final effectiveThickness = thickness ?? AppSizing.borderNormal;

    switch (type) {
      case DividerType.horizontal:
        if (label != null) {
          return _buildLabeledDivider(
              context, effectiveColor, effectiveThickness);
        }
        return Divider(
          height: height ?? AppSizing.lg,
          thickness: effectiveThickness,
          color: effectiveColor,
          indent: indent,
          endIndent: endIndent,
        );

      case DividerType.vertical:
        return VerticalDivider(
          width: height ?? AppSizing.lg,
          thickness: effectiveThickness,
          color: effectiveColor,
          indent: indent,
          endIndent: endIndent,
        );
    }
  }

  Widget _buildLabeledDivider(
      BuildContext context, Color effectiveColor, double effectiveThickness) {
    return Row(
      children: [
        if (indent != null) SizedBox(width: indent),
        Expanded(
          child: Divider(
            height: height ?? AppSizing.lg,
            thickness: effectiveThickness,
            color: effectiveColor,
            endIndent: AppSizing.md,
          ),
        ),
        Text(
          label!,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
        ),
        Expanded(
          child: Divider(
            height: height ?? AppSizing.lg,
            thickness: effectiveThickness,
            color: effectiveColor,
            indent: AppSizing.md,
          ),
        ),
        if (endIndent != null) SizedBox(width: endIndent),
      ],
    );
  }
}

/// Section divider with spacing
class AppSectionDivider extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  const AppSectionDivider({
    super.key,
    this.title,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? AppSizing.paddingVerticalMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: context.colors.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: AppSizing.sm),
          ],
          const AppDivider(),
        ],
      ),
    );
  }
}

/// Divider type options
enum DividerType {
  horizontal,
  vertical,
}
