import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';
import 'package:photos/src/controller/service/local_data/cache_service.dart';
import '../../core/routes/routes.dart';
import '../../core/utils/app_context.dart';

class AuthScreenController extends GetxController {
  final DataController dataController = Get.find<DataController>();
  final RxBool isLogin = true.obs;
  final RxBool isLoading = false.obs;

  AuthScreenController(BuildContext context) {
    AppContext.instantiate(context: context);
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    isLoading.value = true;
    try {
      final String? token = await CacheService.instance.retrieveBearerToken();
      if (token != null) {
        _navigateToHomeScreen();
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
        bool? loginResult = await dataController.login(
          email: email,
          password: password,
        );

        if (loginResult == true) {
          _navigateToHomeScreen();
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

  void _navigateToHomeScreen() {
    AppContext.context.goNamed(Routes.home);
  }
}
