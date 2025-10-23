import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../core/localization/app_translations.dart';
import '../../utils/functions/string_conversion.dart';

/// A custom widget that displays a checkbox along with text for
/// Terms and Conditions and Privacy Policy with clickable links.
class CustomTOCAndPP extends StatelessWidget {
  /// Creates a [CustomTOCAndPP] widget.
  ///
  /// The [onChanged] callback is called when the checkbox value changes.
  /// The [value] determines the initial state of the checkbox.
  const CustomTOCAndPP({super.key, this.onChanged, this.value = false});

  /// Callback function that is called when the checkbox value changes.
  final void Function(bool value)? onChanged;

  /// The initial value of the checkbox.
  final bool value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final TextStyle? buttonText =
        textTheme.titleSmall?.copyWith(color: colorScheme.onSurface);
    final Color color = colorScheme.primary;

    TextSpan tSpan(String s, Function(TapDownDetails _)? onTapDown) {
      return TextSpan(
        text: s,
        style: buttonText?.copyWith(
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationThickness: defaultBorderWidth1,
          decorationColor: color,
          shadows: <Shadow>[
            Shadow(color: color, offset: Offset(0, -defaultBorderWidth2)),
          ],
        ),
        recognizer: TapGestureRecognizer()..onTapDown = onTapDown,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: (bool? value) {
            onChanged == null ? null : onChanged!(value ?? false);
          },
        ),
        Flexible(
          child: Text.rich(
            style: buttonText,
            TextSpan(
              text: '${TextEnum.iHaveReadAndApproved.tr} ',
              children: <InlineSpan>[
                tSpan('Terms and Conditions', (_) => urlTOS.launchUrl),
                TextSpan(text: ' ${TextEnum.and.tr} '),
                tSpan('Privacy Policy', (_) => urlPP.launchUrl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
