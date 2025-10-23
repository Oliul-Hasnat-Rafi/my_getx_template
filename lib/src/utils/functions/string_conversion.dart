import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as luncher;

import '../dev_functions/dev_print.dart';
import '../user_message/snackbar.dart';

/// Extension methods for the [String] class to provide additional
/// functionality.
extension StringExtensions on String {
  /// Cuts the string from [starting] index to [ending] index and appends
  /// [replaceString].
  ///
  /// If [ending] is null or the string length is less than [ending], the
  /// original string is returned.
  String customCutString({
    int starting = 0,
    int? ending = 100,
    String replaceString = '',
  }) =>
      (ending != null && length >= ending)
          ? '${substring(starting, ending)}$replaceString'
          : this;

  /// Capitalizes the first letter of the string.
  ///
  /// If the string is empty, the original string is returned.
  String get customCapitalizeFirstLetter =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Converts the string to a double.
  ///
  /// If the conversion fails, 0 is returned.
  double get customStringToDouble {
    double res = 0;

    try {
      res = double.parse(this);
    } catch (_) {}

    return res;
  }

  /// Checks if the string matches the [searchValue] after trimming and removing
  /// spaces.
  bool customSearchMatch(String searchValue) {
    bool r = searchValue
        .trim()
        .replaceAll(' ', '')
        .toLowerCase()
        .contains(trim().replaceAll(' ', '').toLowerCase());
    return r;
  }

  /// Copies the string to the clipboard.
  ///
  /// Returns true if the operation is successful, otherwise false.
  Future<bool> get customCopyToClipboard async {
    try {
      await Clipboard.setData(ClipboardData(text: this));
      showToast(message: 'Text copied', title: null);
      return true;
    } catch (e) {
      devPrint('customCopyToClipboard: $e');
      return false;
    }
  }

  /// Launches the URL represented by the string in the default browser.
  ///
  /// Returns true if the operation is successful, otherwise false.
  Future<bool> get launchUrl async {
    try {
      await luncher.launchUrl(Uri.parse(this));
      showToast(message: 'Opening browser');
      return true;
    } catch (_) {
      showToast(message: 'Unable to launch');
      return false;
    }
  }
}
