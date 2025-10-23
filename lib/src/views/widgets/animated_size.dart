import 'package:flutter/material.dart';

import '../../../components.dart';

/// A custom widget that animates its size when its child's size changes.
///
/// The [CustomAnimatedSize] widget is a wrapper around the [AnimatedSize]
/// widget, which animates the size of its child when the child's size changes.
/// It also uses a [FractionallySizedBox] to allow for fractional sizing of
/// its child.
///
/// The [alignment] property specifies how the child should be aligned within
/// the widget. The [duration] property specifies the duration of the animation.
/// The [curve] property specifies the curve to use for the animation. The
/// [clipBehavior] property specifies how to clip the content. The [widthFactor]
/// and [heightFactor] properties specify the fractional width and height of
/// the child, respectively.
class CustomAnimatedSize extends StatelessWidget {
  /// Creates a [CustomAnimatedSize] widget.
  ///
  /// The [alignment], [duration], [curve], and [clipBehavior] properties must
  /// not be null.
  const CustomAnimatedSize({
    super.key,
    this.child,
    this.alignment = Alignment.center,
    this.duration = defaultDuration,
    this.curve = Curves.linear,
    this.clipBehavior = Clip.antiAlias,
    this.widthFactor,
    this.heightFactor,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// How to align the child.
  final AlignmentGeometry alignment;

  /// The duration of the animation.
  final Duration duration;

  /// The curve to use for the animation.
  final Curve curve;

  /// How to clip the content.
  final Clip clipBehavior;

  /// The fractional width of the child.
  final double? widthFactor;

  /// The fractional height of the child.
  final double? heightFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: AnimatedSize(
        curve: Curves.easeInOut,
        clipBehavior: clipBehavior,
        alignment: alignment,
        duration: duration,
        child: child ?? const SizedBox(),
      ),
    );
  }
}
