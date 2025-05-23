// lib/components/inputs/app_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Professional text field component with smart features
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autofocus;
  final InputFieldSize size;
  final bool readOnly;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.size = InputFieldSize.medium,
    this.readOnly = false,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final height = switch (widget.size) {
      InputFieldSize.small => AppSizing.inputSmall,
      InputFieldSize.medium => AppSizing.inputMedium,
      InputFieldSize.large => AppSizing.inputLarge,
    };

    final contentPadding = switch (widget.size) {
      InputFieldSize.small => const EdgeInsets.symmetric(
          horizontal: AppSizing.md, vertical: AppSizing.sm),
      InputFieldSize.medium => const EdgeInsets.symmetric(
          horizontal: AppSizing.lg, vertical: AppSizing.md),
      InputFieldSize.large => const EdgeInsets.symmetric(
          horizontal: AppSizing.lg, vertical: AppSizing.lg),
    };

    final borderRadius = BorderRadius.circular(AppSizing.radiusMedium);
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: hasError ? AppColors.error : colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: AppSizing.xs),
        ],
        SizedBox(
          height: widget.maxLines == 1 ? height : null,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            textInputAction: widget.textInputAction,
            readOnly: widget.readOnly,
            validator: widget.validator,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.enabled ? colors.onSurface : colors.disabled,
                ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: colors.onSurfaceVariant),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                      color: colors.onSurfaceVariant,
                    )
                  : widget.suffixIcon,
              filled: true,
              fillColor: widget.enabled
                  ? colors.surfaceVariant
                  : colors.disabledContainer,
              contentPadding: contentPadding,
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : colors.outline,
                  width: AppSizing.borderNormal,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : colors.outline,
                  width: AppSizing.borderNormal,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : colors.primary,
                  width: AppSizing.borderThick,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: AppSizing.borderNormal,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: AppSizing.borderThick,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: colors.outlineVariant,
                  width: AppSizing.borderNormal,
                ),
              ),
              counterText: '',
              errorText: widget.errorText,
            ),
          ),
        ),
        if (widget.errorText == null && widget.helperText != null) ...[
          const SizedBox(height: AppSizing.xs),
          Text(
            widget.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
        ],
      ],
    );
  }
}

/// Input field size options
enum InputFieldSize { small, medium, large }
