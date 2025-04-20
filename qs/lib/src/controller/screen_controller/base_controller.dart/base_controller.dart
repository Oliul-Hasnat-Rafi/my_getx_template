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
    if (theme != null) {
      _initializedTheme(theme);
    } else {
      themeMode.value = ThemeMode.system;
    }
    _initializedLanguage(language);
  }

  Future<void> toggleTheme() async {
    final theme = await CacheService.instance.retrieveTheme();

    ThemeMode newThemeMode = theme == ThemeMode.light.name ? ThemeMode.dark : ThemeMode.light;
    await CacheService.instance.changeTheme(newThemeMode);
    _initializedTheme(newThemeMode.name);
    update();
  }

  void changeLanguage(Locale newLocale) {
    locale.value = newLocale;
    CacheService.instance.changeLanguage(locale.value.languageCode);
    Get.updateLocale(newLocale);
  }

  void _initializedTheme(String theme) {
    if (ThemeMode.dark.name == theme) {
      themeMode.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    } else if (ThemeMode.light.name == theme) {
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
