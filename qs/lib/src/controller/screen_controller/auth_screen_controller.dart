import 'package:get/get.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';
import 'package:photos/src/controller/service/local_data/cache_service.dart';
import '../../view/home/home_screen.dart';

class AuthScreenController extends GetxController {
  final DataController dataController = Get.find<DataController>();
  final RxBool isLogin = true.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    isLoading.value = true;
    try {
      final String? token = await CacheService.instance.retrieveBearerToken();
      if (token != null && token.isNotEmpty) {
        Get.off(
          () => const HomeScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool?> handleSubmit({
    String? name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      if (isLogin.value) {
        bool? loginResult = await dataController.login(
          email: email,
          password: password,
        );

        if (loginResult == true) {
          //    showSnackBarMessage(AppContext.context, "Login ", SnackBarMessageType.success);
          Get.off(
            () => const HomeScreen(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
          );
          return true;
        } else {
          // showSnackBarMessage(AppContext.context, "Login Failed ", SnackBarMessageType.failure);
          return false;
        }
      } else {
        // Registration flow (uncomment when ready)
        // if (!name.isNullOrEmpty && email.isNotEmpty && password.isNotEmpty) {
        //   bool? registerResult = await dataController.register(
        //     name: name!,
        //     email: email,
        //     password: password,
        //   );
        //
        //   if (registerResult == true) {
        //     Get.off(
        //       () => const HomeScreen(),
        //       transition: Transition.rightToLeft,
        //       duration: const Duration(milliseconds: 500),
        //     );
        //     return true;
        //   }
        // }
        //showSnackBarMessage(AppContext.context, "Registration is Failed", SnackBarMessageType.failure);
        return false;
      }
    } catch (e) {
      //showSnackBarMessage(AppContext.context, "Authentication failed: ${e.toString()}", SnackBarMessageType.failure);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void toggleLoginSignup() {
    isLogin.value = !isLogin.value;
  }
}
