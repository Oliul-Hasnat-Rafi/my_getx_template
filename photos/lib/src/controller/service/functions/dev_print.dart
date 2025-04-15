import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

devPrint(dynamic message, {Color color = Colors.green}) {
  if (kDebugMode) {
    dev.log(
      '$message',
    );
  }
}
