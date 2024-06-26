String? emailValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
      .hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null; // Return null if the input is valid
}

String? passwordValidator(password) {
  if (password == null || password.trim().isEmpty) {
    return "Password field is required.";
  }
  String errorMessage = '';
  // Password length greater than 6
  if (password.length < 6) {
    errorMessage += '• Password must be longer than 6 characters.\n';
  }
  // Contains at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    errorMessage += '• Uppercase letter is missing.\n';
  }
  // Contains at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    errorMessage += '• Lowercase letter is missing.\n';
  }
  // Contains at least one digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    errorMessage += '• Digit is missing.\n';
  }
  // Contains at least one special character
  if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
    errorMessage += '• Special character is missing.\n';
  }
  // If there are no error messages, the password is valid
  if (errorMessage.isEmpty) return null;
  return errorMessage;
}
