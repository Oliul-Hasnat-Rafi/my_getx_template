import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

import '../../../components.dart';

/// A custom text button widget that uses [OnProcessButtonWidget].
///
/// This button can be expanded, have a custom color, and execute a callback
/// when the process is done.
class CustomTextButton extends StatelessWidget {
  /// Creates a [CustomTextButton].
  ///
  /// The [child] parameter must not be null.
  const CustomTextButton({
    super.key,
    required this.child,
    this.onDone,
    this.expanded = false,
    this.color,
    this.onPrimary = false,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// A callback function that is called when the process is done.
  ///
  /// The callback receives a boolean value indicating the success of the
  /// process.
  final dynamic Function(bool? _)? onDone;

  /// Whether the button should be expanded to fill its parent.
  final bool expanded;

  /// Whether the button should use the primary color scheme.
  final bool onPrimary;

  /// The background color of the button.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final Color textColor =
        onPrimary ? colorScheme.onPrimary : colorScheme.primary;
    return OnProcessButtonWidget(
      expanded: expanded,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        vertical: defaultPadding / 4,
        horizontal: defaultPadding / 2,
      ),
      constraints: const BoxConstraints(),
      textStyle: textTheme.labelLarge?.copyWith(color: color ?? textColor),
      onDone: onDone,
      iconColor: color ?? textColor,
      child: child,
    );
  }
}
