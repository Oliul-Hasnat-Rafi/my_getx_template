const int _defaultPasswordMinLength = 6;
const int _defaultNameMinLength = 8;
const int _defaultPhoneNumberLength = 11;
const int _defaultAddressLength = 10;
const String _defaultEmailValidationPattern =
    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

/// Validates an email address.
///
/// Checks if the [email] is not null or empty and matches the email pattern.
///
/// If [showDetails] is true, returns a detailed error message.
/// Otherwise, returns a generic error message.
///
/// Returns `null` if the email address is valid.
String? emailValidation(String? email, {bool showDetails = true}) {
  if (email == null || email.trim().isEmpty) return 'Email can not be empty';

  final RegExp regex = RegExp(_defaultEmailValidationPattern);
  if (!regex.hasMatch(email)) return 'Invalid email address';

  return null;
}

/// Validates a password.
///
/// Checks if the [password] is not null or empty and has at least
/// [_defaultPasswordMinLength] characters. Also checks if the password contains
/// at least one digit, one lowercase letter, one uppercase letter, and one
/// non-alphanumeric character.
///
/// If [showDetails] is true, returns a detailed error message.
/// Otherwise, returns a generic error message.
///
/// Returns `null` if the password is valid.
String? passwordValidation(String? password, {bool showDetails = true}) {
  if (password == null || password.trim().isEmpty) {
    return 'Password can not be empty';
  }

  if (password.length < _defaultPasswordMinLength) {
    return showDetails
        ? '''Password must have at least ($_defaultPasswordMinLength) characters in length'''
        : 'Invalid password';
  }

  RegExp digitRegex = RegExp(r'[0-9]');
  RegExp lowercaseRegex = RegExp(r'[a-z]');
  RegExp uppercaseRegex = RegExp(r'[A-Z]');
  RegExp nonAlphanumericRegex = RegExp(r'[\W_]');

  if (!digitRegex.hasMatch(password)) {
    return showDetails
        ? '''Password must contain at least one digit.'''
        : '''Invalid password''';
  }
  if (!lowercaseRegex.hasMatch(password)) {
    return showDetails
        ? '''Password must contain at least one lowercase letter.'''
        : '''Invalid password''';
  }
  if (!uppercaseRegex.hasMatch(password)) {
    return showDetails
        ? '''Password must contain at least one uppercase letter.'''
        : '''Invalid password''';
  }
  if (!nonAlphanumericRegex.hasMatch(password)) {
    return showDetails
        ? '''Password must contain at least one non-alphanumeric character.'''
        : 'Invalid password' '';
  }

  return null;
}

/// Validates a name.
///
/// Checks if the [name] is not null or empty and has at least
/// [_defaultNameMinLength] characters. Also checks if the name contains
/// only alphabetic characters and spaces, and does not contain multiple
/// consecutive spaces.
///
/// If [showDetails] is true, returns a detailed error message.
/// Otherwise, returns a generic error message.
///
/// Returns `null` if the name is valid.
String? nameValidation(String? name, {bool showDetails = true}) {
  if (name == null || name.trim().isEmpty) return 'Name can not be empty';

  if (name.length < _defaultNameMinLength) {
    return '''Name must have at least ($_defaultNameMinLength) characters in length''';
  }

  RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
  if (!regex.hasMatch(name)) {
    return 'Name must not contain any numeric characters or symbol';
  }

  regex = RegExp(r'\s{2,}');
  if (regex.hasMatch(name.trim())) {
    return 'Name must not contain multiple white space in row';
  }

  return null;
}

/// Validates a phone number.
///
/// Checks if the [number] contains only digits (0-9) and matches the specified
/// lengths.
///
/// If [showDetails] is true, returns a detailed error message.
/// Otherwise, returns a generic error message.
///
/// Returns `null` if the phone number is valid.
String? phoneNumberValidation(
  String? number, {
  List<int>? lengths,
  bool showDetails = true,
}) {
  if (number == null || number.trim().isEmpty) {
    return 'Phone number can not be empty';
  }

  int l = number.length;

  lengths ??= <int>[_defaultPhoneNumberLength];
  if (!lengths.contains(l)) {
    return showDetails
        ? 'Phone number must be with length of $lengths digits'
        : 'Invalid phone number';
  }

  final RegExp regex = RegExp(r'^[0-9]+$');
  if (!regex.hasMatch(number)) {
    return showDetails
        ? 'Phone number must be contain only digits (0-9)'
        : 'Invalid phone number';
  }

  return null;
}

/// Validates an address.
///
/// Checks if the [value] is not null or empty and has at least
/// [_defaultAddressLength] characters.
///
/// If [showDetails] is true, returns a detailed error message.
/// Otherwise, returns a generic error message.
///
/// Returns `null` if the address is valid.
String? addressValidation(String? value, {bool showDetails = true}) {
  if (value == null || value.trim().isEmpty) return 'Address can not be empty';

  if (value.length < _defaultAddressLength) {
    return showDetails
        ? '''Address must have at least ($_defaultAddressLength) characters in length'''
        : 'Invalid address';
  }

  return null;
}

/// Validates a web address.
///
/// Checks if the [value] is not null or empty and matches the web address
/// pattern.
///
/// If [showDetails] is true, returns a detailed error message.
/// Otherwise, returns a generic error message.
///
/// Returns `null` if the web address is valid.
String? webAddressValidation(String? value, {bool showDetails = true}) {
  if (value == null || value.trim().isEmpty) {
    return 'Web-address can not be empty';
  }

  final RegExp regex = RegExp(
    r"^(?:http:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(\/[a-zA-Z0-9-._~:/?#[\]@!$&\'()*+,;=]*)?$",
  );

  if (!regex.hasMatch(value)) return 'Invalid website';

  return null;
}
