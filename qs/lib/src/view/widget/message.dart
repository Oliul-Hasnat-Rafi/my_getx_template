import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({
    super.key,
    required this.message,
    this.color,
  });
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color ?? Theme.of(context).colorScheme.onBackground),
    );
  }
}
