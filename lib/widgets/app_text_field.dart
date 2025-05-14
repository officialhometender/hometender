// lib/widgets/app_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_color.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final bool required;
  final bool showClearButton;
  final double borderRadius;
  final bool unfocusOnTapOutside; // New property for unfocused behavior
  final bool unfocusOnSubmit; // New property for unfocused behavior
  final VoidCallback? onTap; // New property for tap callback

  const AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.required = false,
    this.showClearButton = false,
    this.borderRadius = 12.0,
    this.unfocusOnTapOutside = true, // Default to true for better UX
    this.unfocusOnSubmit = true, // Default to true for better UX
    this.onTap,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _obscureText = false;
  bool _hasError = false;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    _isEmpty = _controller.text.isEmpty;

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final newIsEmpty = _controller.text.isEmpty;
    if (_isEmpty != newIsEmpty) {
      setState(() {
        _isEmpty = newIsEmpty;
      });
    }

    if (widget.validator != null) {
      final error = widget.validator!(_controller.text);
      final hasError = error != null;
      if (_hasError != hasError) {
        setState(() {
          _hasError = hasError;
        });
      }
    }
  }

  void _onFocusChanged() {
    setState(() {
      // Trigger rebuild when focus changes
    });
  }

  // New method to handle unfocus
  void _unfocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  // New method to handle field submission
  void _handleSubmitted(String value) {
    if (widget.unfocusOnSubmit) {
      _unfocus();
    }
    widget.onSubmitted?.call(value);
  }

  // New method to handle editing complete
  void _handleEditingComplete() {
    if (widget.unfocusOnSubmit) {
      _unfocus();
    }
    widget.onEditingComplete?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;

    // Determine field colors based on state
    Color fillColor;
    Color borderColor;

    if (!widget.enabled) {
      fillColor = isLight ? AppColors.gray100 : AppColors.gray800;
      borderColor = isLight ? AppColors.gray300 : AppColors.gray700;
    } else if (_hasError || widget.errorText != null) {
      fillColor = isLight
          ? AppColors.errorLight.withOpacity(0.1)
          : AppColors.errorDark.withOpacity(0.1);
      borderColor = AppColors.error;
    } else if (_focusNode.hasFocus) {
      fillColor = isLight ? AppColors.primary100 : AppColors.gray800;
      borderColor = colorScheme.primary;
    } else {
      fillColor = isLight ? AppColors.gray100 : AppColors.gray800;
      borderColor = isLight ? AppColors.gray300 : AppColors.gray700;
    }

    // Prepare suffix icons (clear button or password visibility toggle)
    Widget? suffixIconWidget = widget.suffixIcon;

    if (widget.showClearButton && !_isEmpty && widget.enabled) {
      suffixIconWidget = IconButton(
        icon: const Icon(Icons.clear, size: 18),
        onPressed: () {
          _controller.clear();
          widget.onChanged?.call('');
        },
      );
    } else if (widget.obscureText) {
      suffixIconWidget = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    // Build required indicator for label
    Widget? labelWidget;
    if (widget.label != null) {
      labelWidget = RichText(
        text: TextSpan(
          style: theme.textTheme.labelMedium?.copyWith(
            color: _focusNode.hasFocus
                ? colorScheme.primary
                : isLight
                    ? AppColors.gray700
                    : AppColors.gray300,
          ),
          children: [
            TextSpan(text: widget.label),
            if (widget.required)
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      );
    }

    // Create the text field
    Widget textField = TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: widget.onChanged,
      onEditingComplete: _handleEditingComplete,
      // Use our custom handler
      onFieldSubmitted: _handleSubmitted,
      // Use our custom handler
      onTap: widget.onTap,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,

      style: theme.textTheme.bodyLarge?.copyWith(
        color: widget.enabled
            ? isLight
                ? AppColors.gray900
                : AppColors.gray50
            : isLight
                ? AppColors.gray500
                : AppColors.gray600,
      ),

      decoration: InputDecoration(
        labelText: null,
        // We're using custom label above
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,

        filled: true,
        fillColor: fillColor,

        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        // Handle border states
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: isLight ? AppColors.gray300 : AppColors.gray700,
          ),
        ),

        // Handle icons
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixIconWidget,
        prefix: widget.prefix,
        suffix: widget.suffix,
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIconConstraints: widget.suffixIconConstraints,
      ),
    );

    // Wrap in GestureDetector for tap outside handling if enabled
    Widget result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelWidget != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: labelWidget,
          ),
        if (widget.unfocusOnTapOutside)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Unfocused when tapping this widget's area
              FocusScope.of(context).unfocus();
            },
            child: textField,
          )
        else
          textField,
      ],
    );

    // If we want to unfocused on tap outside, wrap entire component
    if (widget.unfocusOnTapOutside) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Prevent keyboard from showing when tapping outside
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: result,
      );
    }

    return result;
  }
}
