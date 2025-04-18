import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/local_data/cache_service.dart';
import '../../model/response_model/UserModel.dart';
import '../service/api/api_services.dart';
import '../service/error_handlers/error_handler.dart';
import '../service/local_data/app_store_imp.dart';

class DataController extends GetxController {
  bool _isInit = false;
  late final ApiServices _apiServices;
  late final ErrorHandler _errorHandler;
  late final AppStorageImp localData;

  DataController() {
    localData = Get.put(AppStorageImp());
    _apiServices = Get.put(ApiServices());
  }

  @override
  void onInit() {
    super.onInit();
    initApp();
  }

  Future<void> initApp() async {
    if (_isInit) return;
    await startupTasks();
    _isInit = true;
  }

  Future<void> startupTasks() async {
    //await localData.initApp();
    await CacheService.init();
    _errorHandler = ErrorHandler();
    await _initTheme();
  }

  _initTheme() async {
    final theme = await CacheService.instance.retrieveTheme();
    if (theme == "light") {
      Get.changeThemeMode(ThemeMode.light);
    } else if (theme == "dark") {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  Future<bool?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel? t;
      var s = await _errorHandler.errorHandler(function: () async {
        t = await _apiServices.login(email: email, password: password);
      });
      if (s.isSuccess && t?.accessToken != null) {
        await CacheService.instance.storeBearerToken(t!.accessToken!);
        await CacheService.instance.setUserData(t!);

        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
}
