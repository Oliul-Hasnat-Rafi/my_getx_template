import 'package:flutter/material.dart';

import '../../../components.dart';

/// A custom widget that creates a `SizedBox` with a height and width
/// based on a fraction of the default padding.
class CustomSize extends StatelessWidget {
  /// Creates a `CustomSize` widget.
  ///
  /// The [fraction] parameter determines the size of the `SizedBox`
  /// relative to the default padding. The default value is 1.
  const CustomSize({super.key, this.fraction = 1});

  /// The fraction of the default padding to use for the height and width
  /// of the `SizedBox`.
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultPadding / fraction,
      width: defaultPadding / fraction,
    );
  }
}
