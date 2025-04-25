import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';
import '../../core/routes/routes.dart';
import '../service/local_data/app_store.dart' show AppStorageI;

class AuthScreenController extends GetxController {
  final DataController _dataController ;
  final AppStorageI _appStorage;
  final RxBool isLogin = true.obs;
  final RxBool isLoading = false.obs;

  AuthScreenController({
    DataController? dataController,
    AppStorageI? appStorage,
  })  : _appStorage = appStorage ?? GetIt.instance<AppStorageI>(),
        _dataController = dataController ?? GetIt.instance<DataController>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    try {
      final String? token = await _appStorage.retrieveBearerToken();
      if (token != null) {
        _navigatedToHome();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool?> handleSubmit({
    String? name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    try {
      if (isLogin.value) {
        bool? loginResult = await _dataController.login(
          email: email,
          password: password,
        );

        if (loginResult == true) {
          _navigatedToHome();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void toggleLoginSignup() {
    isLogin.value = !isLogin.value;
  }

  void _navigatedToHome() {
    Get.toNamed(Routes.home);
  }
}
