import 'package:get/get.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';

import '../../view/home/home_screen.dart';

class AuthScreenController extends GetxController {
  final DataController dataController = Get.put(DataController());
  final RxBool isLogin = false.obs;
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool?> handleSubmit({
    String? name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      if (isLogin.value) {
        var s = await dataController.login(email: email, password: password);
        if (s != null) {
          Get.off(
            () => const HomeScreen(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
          );
        } else {
          return false;
        }
      } else {
        // return await dataController.register(
        //   name: name ?? '',
        //   email: email,
        //   password: password,
        // );
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void toggleLoginSignup() {
    isLogin.value = !isLogin.value;
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
