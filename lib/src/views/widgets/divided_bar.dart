import 'package:flutter/material.dart';

import '../../../components.dart';

/// A custom widget that displays a divided bar with optional text in the
/// middle.
///
/// The bar can be oriented either horizontally or vertically, and its
/// appearance can be customized using various properties.
class CustomDividedBar extends StatelessWidget {
  /// Creates a new instance of the [CustomDividedBar] widget without text.
  ///
  /// The bar will be displayed without any text in the middle.
  const CustomDividedBar({
    super.key,
    this.margin,
    this.direction = Axis.horizontal,
    this.size,
    this.color,
    this.textStyle,
  })  : _withOr = false,
        text = null,
        containPadding = 0;

  /// Creates a new instance of the [CustomDividedBar] widget with text.
  ///
  /// The bar will be displayed with the specified [text] in the middle.
  const CustomDividedBar.or({
    super.key,
    this.margin,
    this.direction = Axis.horizontal,
    this.size,
    this.color,
    this.containPadding = 8,
    this.text,
    this.textStyle,
  }) : _withOr = true;

  /// The margin around the bar.
  final EdgeInsetsGeometry? margin;

  /// The direction of the bar, either horizontal or vertical.
  final Axis direction;

  /// The size of the bar.
  final double? size;

  /// The color of the bar. If not specified, a default color is used.
  final Color? color;

  /// The padding inside the bar when it contains text.
  final double containPadding;

  /// Whether the bar contains text in the middle.
  final bool _withOr;

  /// The text to display in the middle of the bar. If not specified, "or" is
  /// used.
  final String? text;

  /// The text style for the text in the middle of the bar.
  final TextStyle? textStyle;

  /// Builds the widget for the bar.
  ///
  /// If the bar contains text, it displays the text in the middle with
  /// padding on either side. Otherwise, it displays a simple bar.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (!_withOr) return _widget(context, margin);

    return Container(
      margin: margin,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _widget(
              context,
              EdgeInsets.only(right: containPadding),
            ),
          ),
          Text(
            text ?? 'or',
            textAlign: TextAlign.center,
            style: (textStyle ?? theme.textTheme.titleMedium)
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
          Expanded(
            child: _widget(
              context,
              EdgeInsets.only(left: containPadding),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widget(BuildContext context, final EdgeInsetsGeometry? m) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Container(
      margin: m,
      width: direction == Axis.vertical ? defaultPadding / 16 : size,
      height: direction == Axis.horizontal ? defaultPadding / 16 : size,
      decoration: BoxDecoration(
        color: color ?? colorScheme.onPrimaryContainer.withAlpha(127),
        borderRadius: BorderRadius.circular(defaultPadding / 2),
      ),
    );
  }
}
