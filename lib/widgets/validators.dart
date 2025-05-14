class Validators {
  /// Validates an email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validates a password with requirements
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasNumber = false;
    bool hasSpecialChar = false;

    for (var char in value.runes) {
      final character = String.fromCharCode(char);
      if (RegExp(r'[A-Z]').hasMatch(character)) hasUppercase = true;
      if (RegExp(r'[a-z]').hasMatch(character)) hasLowercase = true;
      if (RegExp(r'[0-9]').hasMatch(character)) hasNumber = true;
      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(character))
        hasSpecialChar = true;
    }

    if (!hasUppercase)
      return 'Password must contain at least one uppercase letter';
    if (!hasLowercase)
      return 'Password must contain at least one lowercase letter';
    if (!hasNumber) return 'Password must contain at least one number';
    if (!hasSpecialChar)
      return 'Password must contain at least one special character';

    return null;
  }

  /// Validates a name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  /// Validates a Nigerian phone number
  static String? validateNigerianPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Nigerian phone number format
    final phoneRegExp = RegExp(
      r'^(\+234|0)[0-9]{10}$',
    );

    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid Nigerian phone number';
    }

    return null;
  }

  /// Validates that two passwords match
  static String? validatePasswordMatch(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates a required field
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  /// Validates a number within a range
  static String? validateNumberInRange(
    String? value, {
    required double min,
    required double max,
    String fieldName = 'Value',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    if (number < min) {
      return '$fieldName must be greater than or equal to $min';
    }

    if (number > max) {
      return '$fieldName must be less than or equal to $max';
    }

    return null;
  }
}
