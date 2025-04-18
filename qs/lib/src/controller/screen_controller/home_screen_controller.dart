import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/local_data/cache_service.dart';

class HomeScreenController extends GetxController {
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initTheme();
  }

  Future<void> _initTheme() async {
    final theme = await CacheService.instance.retrieveTheme();
    isDarkMode.value = theme == 'dark';
  }

  Future<void> toggleTheme() async {
    await _initTheme();
    isDarkMode.toggle();

    if (isDarkMode.value) {
      CacheService.instance.changeTheme(ThemeMode.dark);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      CacheService.instance.changeTheme(ThemeMode.light);
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}
