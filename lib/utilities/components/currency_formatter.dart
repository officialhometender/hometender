import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// A utility class for formatting currency values in the Home Tender app
/// Provides formatters for Naira (₦) currency with proper separators
class CurrencyFormatter {
  CurrencyFormatter._(); // Private constructor to prevent instantiation

  /// The Naira symbol
  static const String nairaSymbol = '₦';

  /// Format a number as Naira currency with the ₦ symbol
  /// Example: formatNaira(1500) => "₦1,500.00"
  static String formatNaira(num value) {
    final formatter = NumberFormat.currency(
      locale: 'en_NG',
      symbol: nairaSymbol,
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  /// Format a number as Naira currency without the ₦ symbol
  /// Example: formatNairaWithoutSymbol(1500) => "1,500.00"
  static String formatNairaWithoutSymbol(num value) {
    final formatter = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(value).trim();
  }

  /// Format a number as Naira currency without decimal places
  /// Example: formatNairaWholeNumber(1500) => "₦1,500"
  static String formatNairaWholeNumber(num value) {
    final formatter = NumberFormat.currency(
      locale: 'en_NG',
      symbol: nairaSymbol,
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  /// Format a number as compact Naira currency (e.g., 1.5K, 2.3M)
  /// Example: formatCompactNaira(1500000) => "₦1.5M"
  static String formatCompactNaira(num value) {
    final formatter = NumberFormat.compactCurrency(
      locale: 'en_NG',
      symbol: nairaSymbol,
      decimalDigits: 1,
    );
    return formatter.format(value);
  }

  /// Parse a formatted Naira string back to a number
  /// Example: parseNairaString("₦1,500.00") => 1500.0
  static double? parseNairaString(String value) {
    if (value.isEmpty) return null;

    // Remove Naira symbol and any non-numeric characters except decimal points
    final cleanValue = value
        .replaceAll(nairaSymbol, '')
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .trim();

    return double.tryParse(cleanValue);
  }

  /// A TextInputFormatter for Naira currency input fields
  /// Automatically formats input as Naira with commas as you type
  static TextInputFormatter nairaInputFormatter({bool addSymbol = true}) {
    return _NairaTextInputFormatter(addSymbol: addSymbol);
  }
}

/// Custom TextInputFormatter for Naira currency
class _NairaTextInputFormatter extends TextInputFormatter {
  final bool addSymbol;

  _NairaTextInputFormatter({this.addSymbol = true});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Allow backspace and deletion
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Remove all non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // If it's just zeros or empty, return a single zero
    if (newText.isEmpty || newText == '0') {
      final prefix = addSymbol ? '${CurrencyFormatter.nairaSymbol} ' : '';
      return TextEditingValue(
        text: '${prefix}0',
        selection: TextSelection.collapsed(offset: (prefix.length + 1)),
      );
    }

    // Format with commas for thousands
    final value = int.parse(newText);
    final formatter = NumberFormat('#,###', 'en_US');
    newText = formatter.format(value);

    // Add Naira symbol if requested
    final prefix = addSymbol ? '${CurrencyFormatter.nairaSymbol} ' : '';
    final formattedText = '$prefix$newText';

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Currency TextInputField using the Naira formatter
class HTCurrencyField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final Function(double value)? onChanged;
  final bool showSymbol;
  final bool readOnly;
  final bool enabled;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool showClearButton;
  final double? borderRadius;

  const HTCurrencyField({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.onChanged,
    this.showSymbol = true,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.validator,
    this.showClearButton = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      readOnly: readOnly,
      enabled: enabled,
      inputFormatters: [
        CurrencyFormatter.nairaInputFormatter(addSymbol: showSymbol),
      ],
      onChanged: (value) {
        if (onChanged != null) {
          final numValue = CurrencyFormatter.parseNairaString(value) ?? 0;
          onChanged!(numValue);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        hintText:
            hint ?? (showSymbol ? '${CurrencyFormatter.nairaSymbol} 0' : '0'),
        prefixIcon: showSymbol ? const Icon(Icons.currency_exchange) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        suffixIcon: showClearButton
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  if (onChanged != null) {
                    onChanged!(0);
                  }
                },
              )
            : null,
      ),
    );
  }

  /// Format a value and update the controller
  void setValue(double value) {
    final formatted = showSymbol
        ? CurrencyFormatter.formatNaira(value)
        : CurrencyFormatter.formatNairaWithoutSymbol(value);
    controller.text = formatted;
  }

  /// Get the current value as a double
  double getValue() {
    return CurrencyFormatter.parseNairaString(controller.text) ?? 0;
  }
}
