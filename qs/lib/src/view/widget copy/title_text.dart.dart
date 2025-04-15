import 'package:flutter/material.dart';

class TitleText
    extends
        StatelessWidget {
  const TitleText(
    this.string, {
    super.key,
  });
  final String string;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      string,
      textAlign:
          TextAlign.start,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(
        color:
            Theme.of(
              context,
            ).colorScheme.onBackground,
        fontWeight:
            FontWeight.bold,
      ),
    );
  }
}

class SubtitleText
    extends
        StatelessWidget {
  const SubtitleText({
    super.key,
    required this.string,
    this.color,
  });
  final String string;
  final Color? color;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      string,
      textAlign:
          TextAlign.start,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(
        color:
            color ??
            Theme.of(
              context,
            ).colorScheme.onBackground,
      ),
    );
  }
}
