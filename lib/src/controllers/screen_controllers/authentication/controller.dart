// ignore_for_file: public_member_api_docs

part of '../../../views/screens/authentication/authentication_wrapper_screen.dart';

/// Handles authentication screens
class _AuthenticationScreenController extends GetxController {
  /// Get [_AuthenticationScreenController] GetxController
  static _AuthenticationScreenController get find => Get.find();

  final RxnBool isLogin = RxnBool(true);
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final RxBool isExcepted = false.obs;

  final _AuthenticationScreenUseCase _useCase = _AuthenticationScreenUseCase();

  @override
  void onClose() {
    super.onClose();
    emailC.dispose();
    passwordC.dispose();
  }

  List<void Function()> get devFunctions => <void Function()>[
        /// store email and password for quick login
        () {
          emailC.text = 'rafi.dpl@gmail.com';
          passwordC.text = 'Singup@1234';
        },
      ];

  resetLogin() {}

  Future<bool> requestLoginSignup() async {
    if (isLogin.value != null && !isExcepted.value) {
      showToast(message: TextEnum.pleaseCheckBox.tr);
      return false;
    }

    if (isLogin.value == true) {
      return _useCase.login(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
      );
    }

    if (isLogin.value == false) {
      return _useCase.signup(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
      );
    }

    return _useCase.resetPassword(
      email: emailC.text.trim(),
    );
  }

  Future<void> requestSuccess(bool? isSuccess) async {
    if (isSuccess != true) return;

    if (isLogin.value == null) {
      isLogin.value = true;
      return;
    }

    final AuthController authController = AuthController.find;

    final UserModel? user = authController.user.value;
    if (user == null) return;

    Get.offAll(() => const DashboardWrapperScreen());
  }

  Future<bool> googleSignIn() async {
    if (isLogin.value != null && !isExcepted.value) {
      showToast(message: 'Please check the box');
      return false;
    }
    // return await _controller.googleSignIn();
    return true;
  }
}
