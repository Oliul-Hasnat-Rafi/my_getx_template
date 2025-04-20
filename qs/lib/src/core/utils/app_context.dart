import 'package:flutter/material.dart';

class AppContext {
  BuildContext? _context;
  bool _lock = false;

  static final AppContext instance = AppContext._internal();

  AppContext._internal();

  factory AppContext.instantiate({
    required BuildContext context,
  }) {
    instance._context = context;
    instance._lock = true;
    return instance;
  }

  static BuildContext get context {
    if (instance._context == null) {
      throw Exception('AppContext not initialized. Call AppContext.instantiate first.');
    }
    return instance._context!;
  }
  
  static bool get isInitialized => instance._context != null;
}