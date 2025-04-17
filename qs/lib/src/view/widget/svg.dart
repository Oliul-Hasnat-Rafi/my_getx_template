import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSVG extends StatelessWidget {
  const CustomSVG(
    this.assetName, {
    super.key,
    this.height,
    this.color,
    this.onBackground = true,
    this.fill = true,
  });
  final String assetName;
  final double? height;
  final Color? color;
  final bool fill;

  /// onBackground ? theme.colorScheme.onBackground : theme.colorScheme.background
  final bool onBackground;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final ColorFilter? col = !fill ? null : ColorFilter.mode(color ?? (onBackground ? c.onBackground : c.background), BlendMode.srcIn);
    return SvgPicture.asset(
      assetName,
      height: height,
      width: height,
      placeholderBuilder: (context) => SvgPicture.asset("", colorFilter: col),
      colorFilter: col,
    );
  }
}
