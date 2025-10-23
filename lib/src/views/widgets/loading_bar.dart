import 'package:flutter/material.dart';

import '../../../components.dart';

/// Custom Circular Progress Bar
class CustomCircularProgressBar extends StatelessWidget {
  /// Custom Circular Progress Bar
  const CustomCircularProgressBar({
    super.key,
    this.color,
    this.size,
    this.value,
  });

  /// Custom Circular Progress Bar Color
  final Color? color;

  /// Custom Circular Progress Bar Size
  final double? size;

  /// Custom Circular Progress Bar Value
  final double? value;

  @override
  Widget build(BuildContext context) {
    double widgetSize = size ?? defaultPadding;
    return SizedBox(
      width: widgetSize,
      height: widgetSize,
      child: FittedBox(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
          value: value == null ? null : value! / 100,
        ),
      ),
    );
  }
}

/// Custom Linear Progress Bar
class CustomLinearProgressBar extends StatelessWidget {
  /// Custom Linear Progress Bar
  const CustomLinearProgressBar({
    super.key,
    this.color,
    this.size,
    this.show = true,
    this.value,
  }) : _opacity = 10;

  /// Custom Linear Progress Bar Small
  const CustomLinearProgressBar.small({
    super.key,
    this.color,
    this.size = 2,
    this.show = true,
    this.value,
  }) : _opacity = 1;

  /// Custom Linear Progress Bar Color
  final Color? color;

  /// Custom Linear Progress Bar Size
  final double? size;

  /// Custom Linear Progress Bar Show
  final bool show;

  /// Custom Linear Progress Bar Value
  final double? value;

  final int _opacity;

  @override
  Widget build(BuildContext context) {
    double widgetSize = size ?? defaultPadding;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widgetSize / 2),
      ),
      height: widgetSize,
      child: show
          ? LinearProgressIndicator(
              value: value == null ? null : value! / 100,
              backgroundColor: Colors.transparent,
              color: color ??
                  Theme.of(context).colorScheme.primary.withAlpha(_opacity),
            )
          : null,
    );
  }
}
