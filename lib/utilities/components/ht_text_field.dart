import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// HTTextField is a smart text field component for Home Tender app
///
/// Features:
/// - Multiple variants (outlined, filled)
/// - Pre-built validation (email, phone, required)
/// - Built-in prefixes and suffixes (icons, text)
/// - Error states with messages
/// - Character counters
/// - Clear button option
/// - Success state with checkmark
/// - Customizable formatting
class HTTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool showCounter;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool isLoading;
  final bool showClearButton;
  final bool isDense;
  final double? borderRadius;
  final bool success;
  final TextFieldVariant variant;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;

  const HTTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.focusNode,
    this.autovalidateMode,
    this.validator,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.isLoading = false,
    this.showClearButton = false,
    this.isDense = false,
    this.borderRadius,
    this.success = false,
    this.variant = TextFieldVariant.outlined,
    this.contentPadding,
    this.autofocus = false,
  });

  /// Factory constructor for email field with validation
  factory HTTextField.email({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    bool readOnly = false,
    bool enabled = true,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    AutovalidateMode? autovalidateMode,
    bool showClearButton = true,
    bool isDense = false,
    double? borderRadius,
    TextFieldVariant variant = TextFieldVariant.outlined,
    bool autofocus = false,
  }) {
    return HTTextField(
      key: key,
      label: label ?? 'Email',
      hint: hint ?? 'Enter your email address',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      enabled: enabled,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
      prefixIcon: Icons.email_outlined,
      showClearButton: showClearButton,
      isDense: isDense,
      borderRadius: borderRadius,
      variant: variant,
      autofocus: autofocus,
    );
  }

  /// Factory constructor for password field
  /// Note: For toggle visibility, use HTPasswordField instead
  factory HTTextField.password({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    bool readOnly = false,
    bool enabled = true,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    AutovalidateMode? autovalidateMode,
    String? Function(String?)? validator,
    bool isDense = false,
    double? borderRadius,
    TextFieldVariant variant = TextFieldVariant.outlined,
    bool autofocus = false,
    bool obscureText = true,
  }) {
    return HTTextField(
      key: key,
      label: label ?? 'Password',
      hint: hint ?? 'Enter your password',
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      enabled: enabled,
      focusNode: focusNode,
      textInputAction: textInputAction ?? TextInputAction.done,
      autovalidateMode: autovalidateMode,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
      prefixIcon: Icons.lock_outline,
      isDense: isDense,
      borderRadius: borderRadius,
      variant: variant,
      autofocus: autofocus,
    );
  }

  /// Factory constructor for phone field with formatting
  factory HTTextField.phone({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    bool readOnly = false,
    bool enabled = true,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    AutovalidateMode? autovalidateMode,
    bool showClearButton = true,
    bool isDense = false,
    double? borderRadius,
    TextFieldVariant variant = TextFieldVariant.outlined,
    bool autofocus = false,
  }) {
    return HTTextField(
      key: key,
      label: label ?? 'Phone',
      hint: hint ?? 'Enter your phone number',
      controller: controller,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      enabled: enabled,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        }
        // Nigerian phone number validation (starts with +234 or 0, followed by 9-10 digits)
        final phoneRegex = RegExp(r'^(\+234|0)[0-9]{9,10}$');
        if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[^0-9+]'), ''))) {
          return 'Enter a valid Nigerian phone number';
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\(\) ]')),
        LengthLimitingTextInputFormatter(15),
      ],
      prefixIcon: Icons.phone_outlined,
      showClearButton: showClearButton,
      isDense: isDense,
      borderRadius: borderRadius,
      variant: variant,
      autofocus: autofocus,
    );
  }

  /// Factory constructor for search field
  factory HTTextField.search({
    Key? key,
    String? hint,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    VoidCallback? onClear,
    FocusNode? focusNode,
    bool showClearButton = true,
    bool isDense = true,
    double? borderRadius,
    TextFieldVariant variant = TextFieldVariant.filled,
    bool autofocus = false,
  }) {
    return HTTextField(
      key: key,
      hint: hint ?? 'Search...',
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (onChanged != null) onChanged(value);
      },
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
      prefixIcon: Icons.search,
      showClearButton: showClearButton,
      isDense: isDense,
      borderRadius: borderRadius ?? 24,
      variant: variant,
      autofocus: autofocus,
    );
  }

  /// Factory constructor for multiline text field
  factory HTTextField.multiline({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    bool readOnly = false,
    bool enabled = true,
    int minLines = 3,
    int maxLines = 5,
    int? maxLength,
    bool showCounter = true,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    AutovalidateMode? autovalidateMode,
    String? Function(String?)? validator,
    bool isDense = false,
    double? borderRadius,
    TextFieldVariant variant = TextFieldVariant.outlined,
    bool autofocus = false,
  }) {
    return HTTextField(
      key: key,
      label: label,
      hint: hint,
      controller: controller,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      showCounter: showCounter,
      focusNode: focusNode,
      textInputAction: textInputAction ?? TextInputAction.newline,
      autovalidateMode: autovalidateMode,
      validator: validator,
      isDense: isDense,
      borderRadius: borderRadius,
      variant: variant,
      autofocus: autofocus,
    );
  }

  @override
  State<HTTextField> createState() => _HTTextFieldState();
}

class _HTTextFieldState extends State<HTTextField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.isNotEmpty;

    _controller.addListener(_updateHasText);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_updateHasText);
    }
    super.dispose();
  }

  void _updateHasText() {
    final hasText = _controller.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _clearText() {
    _controller.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final radius = widget.borderRadius ?? 8.0;

    // Prepare decorations and styles based on variant and state
    InputBorder border;
    InputBorder focusedBorder;
    InputBorder errorBorder;
    InputBorder focusedErrorBorder;
    Color? fillColor;

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: widget.enabled
                ? theme.colorScheme.outline
                : theme.disabledColor,
          ),
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: widget.success
                ? theme.colorScheme.tertiary
                : theme.colorScheme.primary,
            width: 1.5,
          ),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5,
          ),
        );
        focusedErrorBorder = errorBorder;
        fillColor = Colors.transparent;
        break;

      case TextFieldVariant.filled:
        border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: widget.success
                ? theme.colorScheme.tertiary
                : theme.colorScheme.primary,
            width: 1.0,
          ),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.0,
          ),
        );
        focusedErrorBorder = errorBorder;
        fillColor = isDarkMode
            ? theme.inputDecorationTheme.fillColor
            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5);
        break;
    }

    // Calculate contentPadding
    final EdgeInsetsGeometry padding = widget.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: widget.isDense ? 12.0 : 16.0,
        );

    // Prepare suffixes - load spinner, clear button, custom suffix, etc.
    Widget? suffixWidget;

    if (widget.isLoading) {
      suffixWidget = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
        ),
      );
    } else if (widget.success) {
      suffixWidget = Icon(
        Icons.check_circle,
        color: theme.colorScheme.tertiary,
        size: 20,
      );
    } else if (widget.showClearButton && _hasText) {
      suffixWidget = IconButton(
        icon: const Icon(Icons.clear, size: 18),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        splashRadius: 20,
        onPressed: _clearText,
      );
    } else if (widget.suffix != null) {
      suffixWidget = widget.suffix;
    } else if (widget.suffixIcon != null) {
      suffixWidget = IconButton(
        icon: Icon(widget.suffixIcon, size: 20),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        splashRadius: 20,
        onPressed: widget.onSuffixIconTap,
      );
    }

    // Prepare prefix
    Widget? prefixWidget;

    if (widget.prefix != null) {
      prefixWidget = widget.prefix;
    } else if (widget.prefixIcon != null) {
      prefixWidget = Icon(
        widget.prefixIcon,
        size: 20,
        color: theme.colorScheme.onSurfaceVariant,
      );
    }

    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        counterText: widget.showCounter ? null : '',
        filled: widget.variant == TextFieldVariant.filled,
        fillColor: fillColor,
        prefixIcon: prefixWidget != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: prefixWidget,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        suffixIcon: suffixWidget != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: suffixWidget,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        contentPadding: padding,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        isDense: widget.isDense,
      ),
    );
  }
}

/// Text field variants
enum TextFieldVariant {
  outlined,
  filled,
}

/// Password field with toggle visibility functionality
/// This is a separate widget that provides password visibility toggling
class HTPasswordField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool readOnly;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final bool isDense;
  final double? borderRadius;
  final TextFieldVariant variant;
  final bool autofocus;

  const HTPasswordField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
    this.autovalidateMode,
    this.validator,
    this.isDense = false,
    this.borderRadius,
    this.variant = TextFieldVariant.outlined,
    this.autofocus = false,
  });

  @override
  State<HTPasswordField> createState() => _HTPasswordFieldState();
}

class _HTPasswordFieldState extends State<HTPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HTTextField(
      label: widget.label ?? 'Password',
      hint: widget.hint ?? 'Enter your password',
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
      prefixIcon: Icons.lock_outline,
      suffixIcon: _obscureText
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined,
      onSuffixIconTap: _togglePasswordVisibility,
      isDense: widget.isDense,
      borderRadius: widget.borderRadius,
      variant: widget.variant,
      autofocus: widget.autofocus,
    );
  }
}
