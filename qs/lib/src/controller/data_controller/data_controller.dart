import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/response_model/photo_screen_response_model.dart';
import '../service/api/api_services.dart';
import '../service/error_handlers/error_handler.dart';
import '../service/local_data/local_data_handler.dart';

class DataController extends GetxController {
  bool _isInit = false;
  late final ApiServices _apiServices;
  late final ErrorHandler _errorHandler;
  late final LocalDataHandler localData = Get.put(LocalDataHandler());

  Future<void> initApp() async {
    if (_isInit) return;
    await startupTasks();

    _isInit = true;
  }

  Future<void> startupTasks() async {
    _apiServices = Get.put(ApiServices());
    localData.initApp();
    _errorHandler = ErrorHandler();
    isLogin;
  }

  Future<bool> get isLogin async {
    return localData.localData.userData.value.accessToken!.isNotEmpty;
  }

  Future<bool?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _errorHandler.errorHandler(function: () async {
        return await _apiServices.login(email: email, password: password);
      }).then((value) => value.isSuccess);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
    return false;
  }
  // Future<bool?> register({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await _apiServices.register(name: name, email: email, password: password);
  //     if (response != null) {
  //       localData.setUserData(response);
  //       return true;
  //     }
  //   } catch (e) {
  //     _errorHandler.handleError(e);
  //   }
  //   return false;
  // }
}
