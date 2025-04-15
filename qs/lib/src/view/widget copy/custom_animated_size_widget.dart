import 'package:flutter/material.dart';

import '../../../components.dart';

class CustomAnimatedSize extends StatelessWidget {
  const CustomAnimatedSize({
    super.key,
    this.child,
    this.alignment = Alignment.center,
    this.duration = defaultDuration,
    this.curve = Curves.linear,
    this.clipBehavior = Clip.antiAlias,
    this.widthFactor,
    this.heightFactor,
    this.margin,
  });
  final Widget? child;
  final AlignmentGeometry alignment;
  final Duration duration;
  final Curve curve;
  final Clip clipBehavior;
  final double? widthFactor;
  final double? heightFactor;
  final EdgeInsets? margin;

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
        child: child != null ? Container(margin: margin, child: child) : const SizedBox(),
      ),
    );
  }
}
