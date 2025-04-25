import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';

class BaseController extends GetxController {
  final Rx<Locale> locale = Get.locale?.obs ?? Rx<Locale>(const Locale('en'));
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final AppStorageI _appStorage;

  BaseController({AppStorageI? appStorage})
      : _appStorage = appStorage ?? GetIt.instance<AppStorageI>();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    final storedTheme = await _appStorage.retrieveTheme();
    if (storedTheme != null) {
      themeMode.value = ThemeMode.values.firstWhere(
        (mode) => mode.name == storedTheme,
        orElse: () => ThemeMode.system,
      );
    }

    final storedLanguage = await _appStorage.retrieveLanguage();
    if (storedLanguage != null) {
      locale.value = Locale(storedLanguage);
      Get.updateLocale(locale.value);
    }
  }

  void changeLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    _appStorage.changeLanguage(newLocale.languageCode);
  }

  void changeTheme(ThemeMode newTheme) {
    themeMode.value = newTheme;
    _appStorage.changeTheme(newTheme);
  }
}