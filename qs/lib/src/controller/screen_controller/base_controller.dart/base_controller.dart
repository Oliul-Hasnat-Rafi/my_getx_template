import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/local_data/cache_service.dart';

class BaseController extends GetxController {
  final Rx<Locale> locale = const Locale('en', 'US').obs;
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    final theme = await CacheService.instance.retrieveTheme();
    final language = await CacheService.instance.retrieveLanguage();
    _initializedTheme(theme ?? ThemeMode.system);
    _initializedLanguage(language);
  }

  Future<void> toggleTheme() async {
    // ThemeMode newThemeMode = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    // themeMode.value = newThemeMode;
    // await CacheService.instance.changeTheme(newThemeMode);
    // Get.changeThemeMode(newThemeMode);
    final theme = await CacheService.instance.retrieveTheme();
    themeMode.value != theme;
    _initializedTheme(themeMode.value);
  }

  void changeLanguage(Locale newLocale) {
    locale.value = newLocale;
    CacheService.instance.changeLanguage(locale.value.languageCode);
    Get.updateLocale(newLocale);
  }

  void _initializedTheme(ThemeMode theme) {
    if (theme.name == 'dark') {
      themeMode.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    } else if (theme.name == 'light') {
      themeMode.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    } else {
      themeMode.value = ThemeMode.system;
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  void _initializedLanguage(String? language) {
    if (language == null || language.isEmpty) {
      locale.value = const Locale('en', 'US');
      Get.updateLocale(const Locale('en', 'US'));
      CacheService.instance.changeLanguage('en');
    } else if (language == 'bn') {
      locale.value = const Locale('bn', '');
      Get.updateLocale(const Locale('bn', ''));
    } else if (language == 'en') {
      locale.value = const Locale('en', 'US');
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
