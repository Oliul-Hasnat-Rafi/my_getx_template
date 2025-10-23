import 'package:flutter/material.dart';

//! -------------------------------------------------------------------- Heading
/// CustomTextHeading is a custom text widget that uses the headline style.
/// It has three constructors, CustomTextHeading, CustomTextHeading.L, and
/// CustomTextHeading.S
class CustomTextHeading extends StatelessWidget {
  /// Text with text style headlineMedium
  const CustomTextHeading({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = null;

  /// Text with text style headlineLarge
  const CustomTextHeading.L({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = true;

  /// Text with text style headlineSmall
  const CustomTextHeading.S({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = false;

  /// Whether the text color is onPrimary or onSurface
  final bool onPrimary;

  /// The text to display
  final String text;

  /// The alignment of the text
  final TextAlign textAlign;

  /// The color of the text. If not null it will override the onPrimary/onSurface.
  final Color? color;

  final bool? _isBig;

  /// Whether the text is bold or not
  final bool isBold;

  /// The maximum number of lines to display
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle? textStyle = _isBig == null
        ? textTheme.headlineMedium
        : _isBig
            ? textTheme.headlineLarge
            : textTheme.headlineSmall;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
      style: textStyle?.copyWith(
        color: color ??
            (onPrimary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface),
        fontWeight: !isBold ? null : FontWeight.bold,
      ),
    );
  }
}

//! ---------------------------------------------------------------------- Title
/// CustomTextTitle is a custom text widget that uses the title style.
/// It has three constructors, CustomTextTitle, CustomTextTitle.L, and
/// CustomTextTitle.S
class CustomTextTitle extends StatelessWidget {
  /// Text with text style titleMedium
  const CustomTextTitle({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = null;

  /// Text with text style titleLarge
  const CustomTextTitle.L({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = true;

  /// Text with text style titleSmall
  const CustomTextTitle.S({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = false;

  /// Whether the text color is onPrimary or onSurface
  final bool onPrimary;

  /// The text to display
  final String text;

  /// The alignment of the text
  final TextAlign textAlign;

  /// The color of the text. If not null it will override the onPrimary/onSurface.
  final Color? color;

  final bool? _isBig;

  /// Whether the text is bold or not
  final bool isBold;

  /// The maximum number of lines to display
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle? textStyle = _isBig == null
        ? textTheme.titleMedium
        : _isBig
            ? textTheme.titleLarge
            : textTheme.titleSmall;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
      style: textStyle?.copyWith(
        color: color ??
            (onPrimary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface),
        fontWeight: !isBold ? null : FontWeight.bold,
      ),
    );
  }
}

//! ----------------------------------------------------------------------- Body
/// CustomTextBody is a custom text widget that uses the body style.
/// It has three constructors, CustomTextBody, CustomTextBody.L, and
/// CustomTextBody.S
class CustomTextBody extends StatelessWidget {
  /// Text with text style bodyMedium
  const CustomTextBody({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = null;

  /// Text with text style bodyLarge
  const CustomTextBody.L({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = true;

  /// Text with text style bodySmall
  const CustomTextBody.S({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = false;

  /// Whether the text color is onPrimary or onSurface
  final bool onPrimary;

  /// The text to display
  final String text;

  /// The alignment of the text
  final TextAlign textAlign;

  /// The color of the text. If not null it will override the onPrimary/onSurface.
  final Color? color;

  final bool? _isBig;

  /// Whether the text is bold or not
  final bool isBold;

  /// The maximum number of lines to display
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle? textStyle = _isBig == null
        ? textTheme.bodyMedium
        : _isBig
            ? textTheme.bodyLarge
            : textTheme.bodySmall;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
      style: textStyle?.copyWith(
        color: color ??
            (onPrimary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface),
        fontWeight: !isBold ? null : FontWeight.bold,
      ),
    );
  }
}

//! ---------------------------------------------------------------------- Label
/// CustomTextLabel is a custom text widget that uses the label style.
/// It has three constructors, CustomTextLabel, CustomTextLabel.L, and
/// CustomTextLabel.S
class CustomTextLabel extends StatelessWidget {
  /// Text with text style labelMedium
  const CustomTextLabel({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = null;

  /// Text with text style labelLarge
  const CustomTextLabel.L({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = true;

  /// Text with text style labelSmall
  const CustomTextLabel.S({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = false;

  /// Whether the text color is onPrimary or onSurface
  final bool onPrimary;

  /// The text to display
  final String text;

  /// The alignment of the text
  final TextAlign textAlign;

  /// The color of the text. If not null it will override the onPrimary/onSurface.
  final Color? color;

  final bool? _isBig;

  /// Whether the text is bold or not
  final bool isBold;

  /// The maximum number of lines to display
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle? textStyle = _isBig == null
        ? textTheme.labelMedium
        : _isBig
            ? textTheme.labelLarge
            : textTheme.labelSmall;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
      style: textStyle?.copyWith(
        color: color ??
            (onPrimary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface),
        fontWeight: !isBold ? null : FontWeight.bold,
      ),
    );
  }
}

//! -------------------------------------------------------------------- Display
/// CustomTextDisplay is a custom text widget that uses the display style.
/// It has three constructors, CustomTextDisplay, CustomTextDisplay.L, and
/// CustomTextDisplay.S
class CustomTextDisplay extends StatelessWidget {
  /// Text with text style displayMedium
  const CustomTextDisplay({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = null;

  /// Text with text style displayLarge
  const CustomTextDisplay.L({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = true;

  /// Text with text style displaySmall
  const CustomTextDisplay.S({
    super.key,
    this.onPrimary = false,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.isBold = false,
    this.maxLine,
  }) : _isBig = false;

  /// Whether the text color is onPrimary or onSurface
  final bool onPrimary;

  /// The text to display
  final String text;

  /// The alignment of the text
  final TextAlign textAlign;

  /// The color of the text. If not null it will override the onPrimary/onSurface.
  final Color? color;

  final bool? _isBig;

  /// Whether the text is bold or not
  final bool isBold;

  /// The maximum number of lines to display
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme tT = theme.textTheme;
    final TextStyle? textStyle = _isBig == null
        ? tT.displayMedium
        : _isBig
            ? tT.displayLarge
            : tT.displaySmall;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
      style: textStyle?.copyWith(
        color: color ??
            (onPrimary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface),
        fontWeight: !isBold ? null : FontWeight.bold,
      ),
    );
  }
}
