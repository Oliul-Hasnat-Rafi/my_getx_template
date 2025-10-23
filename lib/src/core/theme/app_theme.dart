import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components.dart';
import '../../utils/dev_functions/dev_print.dart';

part 'colors.dart';
part 'text_styles.dart';

/// App theme data. Always try to
class AppTheme {
  static bool _isInit = false;
  static const String _localeKey = 'AppTheme_theme';
  static final GetStorage _storage = GetStorage();

  static Future<void> get ____init async {
    if (_isInit) return;
    await GetStorage.init();
    _isInit = true;
  }

  /// Load preset brightness from local data when the app is starting
  static Future<ThemeMode> get init async {
    await ____init;
    ThemeMode? themeMode;

    try {
      String? themeModeString = _storage.read<String>(_localeKey);
      if (themeModeString == null) throw Exception('No theme mode found.');

      themeMode = _getThemeMode(themeModeString);
      if (themeMode == null) throw Exception('Theme mode encrypted.');
    } catch (e) {
      devPrint(
        'AppTheme: Unable to load local date. Reset Local Data. $e',
        color: DevPrintColorEnum.yellow,
      );
    }

    if (themeMode == null) {
      themeMode = ThemeMode.system;
      _saveData(themeMode, isInit: true);
    }

    __message(themeMode);

    return themeMode;
  }

  static void __message(ThemeMode value) {
    devPrint(
      'AppTheme: ThemeMode is set to ${value.toString()}',
      color: DevPrintColorEnum.black,
    );
  }

  /// Used to update the locale
  static Future<void> update({required ThemeMode themeMode}) async {
    await _saveData(themeMode);
    Get.changeThemeMode(themeMode);
  }

  static Future<void> _saveData(
    ThemeMode themeMode, {
    bool isInit = false,
  }) async {
    await ____init;
    await _storage.write(_localeKey, themeMode.toString());
    devPrint(
      '''AppTheme: Theme brightness saved to ${themeMode.toString()}.''',
      color: isInit ? DevPrintColorEnum.black : DevPrintColorEnum.green,
    );
  }

  static ThemeMode? _getThemeMode(String value) {
    if (value.isEmpty) return null;

    for (final ThemeMode mode in ThemeMode.values) {
      if (mode.toString() == value) return mode;
    }

    return null;
  }

  /// Set safe area color
  static SystemUiOverlayStyle setSafeAreaColor(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
      );
    } else {
      return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
      );
    }
  }

  /// Get App theme
  static ThemeData theme(
    BuildContext context, {
    Brightness brightness = Brightness.light,
  }) {
    return ThemeData(
      textTheme: AppTextStyles._textTheme(context),
      buttonTheme: ButtonThemeData(height: defaultButtonHeight),
      colorScheme: brightness == Brightness.light
          ? AppColors._lightScheme
          : AppColors._darkScheme,
    );
  }
}
