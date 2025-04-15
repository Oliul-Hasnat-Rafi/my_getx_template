import 'package:flutter/material.dart';
import '../../../components.dart';

class CustomLinearProgressBar extends StatelessWidget {
  const CustomLinearProgressBar({super.key, this.color, this.size, this.show = true}) : _opacity = 0.1;
  final Color? color;
  final double? size;
  final bool show;

  const CustomLinearProgressBar.small({super.key, this.color, this.size = 2, this.show = true}) : _opacity = 1;

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    double s = size ?? defaultPadding;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(s / 2)),
      height: s,
      child: show
          ? LinearProgressIndicator(
              color: color ?? Theme.of(context).colorScheme.primary.withOpacity(_opacity),
            )
          : null,
    );
  }
}
