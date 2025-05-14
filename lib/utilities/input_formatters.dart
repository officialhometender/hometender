// lib/utilities/input_formatters.dart
import 'package:flutter/services.dart';

/// Collection of useful input formatters
class AppInputFormatters {
  /// Allows only numbers
  static final digitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  /// Allows only letters (no spaces)
  static final lettersOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));

  /// Allows letters and spaces
  static final lettersAndSpaces =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));

  /// Allows alphanumeric characters only (letters and numbers)
  static final alphanumeric =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

  /// Allows alphanumeric characters and spaces
  static final alphanumericWithSpaces =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]'));

  /// Nigerian phone number formatter
  static final nigerianPhoneFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      // Keep only digits
      var text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

      // Handle +234 prefix
      if (text.startsWith('234')) {
        text = '+$text';
      } else if (text.startsWith('0') && text.length > 1) {
        // Convert 0xxx to +234xxx
        text = '+234${text.substring(1)}';
      }

      // Limit length (considering +234 prefix)
      if (text.startsWith('+234') && text.length > 14) {
        text = text.substring(0, 14);
      } else if (!text.startsWith('+') && text.length > 11) {
        text = text.substring(0, 11);
      }

      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    },
  );

  /// Currency input formatter (Naira)
  static final nairaFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      if (newValue.text.isEmpty) {
        return newValue;
      }

      // Remove all non-digit characters
      var text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

      // Convert to double and format as currency
      final value = int.tryParse(text);
      if (value == null) {
        return oldValue;
      }

      final formattedValue = '₦${_addThousandSeparator(text)}';

      return TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    },
  );

  /// Helper function to add thousand separators
  static String _addThousandSeparator(String value) {
    final result = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && (value.length - i) % 3 == 0) {
        result.write(',');
      }
      result.write(value[i]);
    }
    return result.toString();
  }
}
