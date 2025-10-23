import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Custom SVG widget
class CustomSVG extends StatelessWidget {
  /// Custom SVG widget
  const CustomSVG(
    this.svgLink, {
    super.key,
    this.color,
    this.onPrimary = false,
    this.width,
    this.height,
  });

  /// SVG asset link
  final String svgLink;

  /// Color of the SVG
  final Color? color;

  /// If the color is on primary
  final bool onPrimary;

  /// If specified, the width to use for the SVG. If unspecified, the SVG will
  /// take the width of its parent.
  final double? width;

  /// If specified, the height to use for the SVG. If unspecified, the SVG will
  /// take the height of its parent.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SvgPicture.asset(
      svgLink,
      height: height,
      width: width,
      // colorFilter: ColorFilter.mode(
      //   color ?? (onPrimary ? colorScheme.onPrimary : colorScheme.onSurface),
      //   BlendMode.srcIn,
      // ),
    );
  }
}
