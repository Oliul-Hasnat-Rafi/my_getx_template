import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Handles additional(Optional) app data
/// Optional Data like App Version
class AppDataController extends GetxController {
  bool _isInit = false;

  /// Get SplashScreenController GetxController
  static AppDataController get find => Get.find();

  /// Package information
  Rxn<PackageInfo> packageInformation = Rxn<PackageInfo>();

  /// App data initialing function. This will be called from splash screen
  /// controller
  Future<void> init() async {
    if (_isInit) return;

    packageInformation.value = await PackageInfo.fromPlatform();

    await Future<void>.delayed(const Duration(seconds: 3));
    _isInit = true;
  }
}
