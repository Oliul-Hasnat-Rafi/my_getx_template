part of '../../../views/screens/splash_screen/splash_screen.dart';

/// [_SplashScreenController] class
class _SplashScreenController extends GetxController {
  /// Get [_SplashScreenController] GetxController
  // static _SplashScreenController get find => Get.find();

  bool __isSplashScreenShown = false;
  bool __isInitialized = false;

  /// [_SplashScreenController] init function
  /// This function will be called from splash screen
  /// This will initialize all the necessary controllers
  Future<void> init() async {
    _splashScreenShow();
    _initializeControllers();
  }

  Future<void> _splashScreenShow() async {
    await Future<void>.delayed(defaultSplashScreenShowDuration);
    __isSplashScreenShown = true;
    __gotoNextScreen();
  }

  Future<void> _initializeControllers() async {
    //! -------------------------------------------- Initialize controllers here
    await AppDataController.find.init();
    await AuthController.find.init();

    __isInitialized = true;
    __gotoNextScreen();
  }

  void __gotoNextScreen() {
    if (!__isSplashScreenShown || !__isInitialized) return;

    // ---------------------------------------------------- Route to next screen
    if (AuthController.find.user.value == null) {
      Get.offAll(() => const AuthenticationWrapperScreen());
    } else {
      Get.offAll(() => const DashboardWrapperScreen());
    }
  }
}
