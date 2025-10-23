// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Prints a styled debug log in the console, optionally pretty-printing JSON.
///
/// This method only logs in **debug mode** (`kDebugMode == true`). It supports:
/// - Colored output using ANSI codes
/// - Optional bold and underline styling
/// - Pretty-printed output for `Map`, `List`, and valid JSON strings
/// - Optional heading with divider lines
///
/// ---
///
/// ### Parameters:
///
/// - [message] *(dynamic)*: Any value to be logged. Maps, Lists, or valid JSON
/// strings are printed as formatted JSON.
/// - [heading] *(String)*: Optional title for the log section.
/// - [color] *(DevPrintColorEnum?)*: ANSI color for the log output.
/// - [isBold] *(bool)*: If `true`, applies bold formatting.
/// - [isUnderline] *(bool)*: If `true`, underlines the output.
///
/// ---
///
/// ### Example:
///
/// ```dart
/// devPrint(
///   {'name': 'Rafi', 'role': 'Flutter Dev'},
///   heading: '👨‍💻 Profile',
///   color: DevPrintColorEnum.green,
///   isBold: true,
/// );
/// ```
///
/// ---
///
/// ### Output:
/// ```
/// [Log] - ----------------------------------------------------------------
/// 👨‍💻 Profile
/// [Log] - {
/// [Log] -   "name": "Rafi",
/// [Log] -   "role": "Flutter Dev"
/// [Log] - }
/// [Log] - ----------------------------------------------------------------
/// ```
void devPrint(
  dynamic message, {
  String heading = '',
  DevPrintColorEnum? color,
  bool isBold = false,
  bool isUnderline = false,
}) {
  if (!kDebugMode) return;

  const String resetColor = '\x1B[0m';
  final String bold = isBold ? '\x1B[1m' : '';
  final String underline = isUnderline ? '\x1B[4m' : '';
  final String logPrefix = '${DevPrintColorEnum.white.code}[Log] - $resetColor';

  try {
    // Try to format message as pretty JSON
    String message_;
    if (message is Map || message is List) {
      message_ = const JsonEncoder.withIndent('  ').convert(message);
    } else {
      try {
        final dynamic parsed = json.decode(message.toString());
        message_ = const JsonEncoder.withIndent('  ').convert(parsed);
      } catch (_) {
        message_ = message.toString().trim();
      }
    }

    final List<String> stringList = message_.split('\n');

    // Get terminal width or default
    int count = 80;
    try {
      count = stdout.terminalColumns;
    } catch (_) {}

    final String coloredPrefix =
        '$logPrefix$bold$underline${color?.code ?? ''}';
    String dividerLine = '';
    final bool printDash = stringList.length > 1 || heading.isNotEmpty;

    // Print heading if applicable
    if (printDash) {
      int length = count - heading.length - 1;
      if (length < 0) length = 0;
      dividerLine = '-' * length;
      print(
        '''$coloredPrefix$dividerLine ${DevPrintColorEnum.yellow.code}$heading$resetColor''',
      );
    }

    // Print message lines
    for (final String line in stringList) {
      print('$coloredPrefix$line$resetColor');
    }

    // Print closing line
    if (printDash) {
      dividerLine = '-' * count;
      print('$coloredPrefix$dividerLine$resetColor');
    }
  } catch (e) {
    print('$logPrefix${DevPrintColorEnum.red.code}Error: $e$resetColor');
  }
}

/// Enum representing ANSI escape codes for coloring and formatting console
/// output.
///
/// Each value of [DevPrintColorEnum] corresponds to a specific ANSI escape code
/// that can be used to format text with colors in supported terminals.
enum DevPrintColorEnum {
  /// 🔴 Sets the text color to red. `ERROR`
  red('\x1B[31m'),

  /// 🟢 Sets the text color to green. `SUCCESSFUL`
  green('\x1B[32m'),

  /// 🟡 Sets the text color to yellow. `WARNING`
  yellow('\x1B[33m'),

  /// 🔵 Sets the text color to blue.
  blue('\x1B[34m'),

  /// 🟣 Sets the text color to magenta.
  magenta('\x1B[35m'),

  /// ⚫ Sets the text color to black.
  black('\x1B[30m'),

  /// ⚪ Sets the text color to white.
  white('\x1B[37m'),
  ;

  /// Constructor to associate an ANSI escape code with the enum value.
  ///
  /// Each enum value has a [code] property containing the escape code string.
  const DevPrintColorEnum(this.code);

  /// The ANSI escape code for this color or style.
  final String code;
}
