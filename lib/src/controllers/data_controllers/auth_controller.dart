import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/data/app_models/user_model.dart';
import '../../utils/dev_functions/dev_print.dart';
import '../../views/screens/splash_screen/splash_screen.dart';

/// Handles user authentication status. This will not use to call Login API or
/// similar types of operations
class AuthController extends GetxController {
  bool _isInit = false;
  static const String _localeKey = 'AuthController';
  final GetStorage _storage = GetStorage();

  Future<void> get ____init async {
    if (_isInit) return;
    await GetStorage.init();
    await _readUserData();
    user.listen((UserModel? _) => _userTask());
    _isInit = true;
  }

  Future<void> _readUserData() async {
    try {
      String data = _storage.read(_localeKey) ?? '';
      if (data.isNotEmpty) {
        user.value = UserModel.fromJson(data);
        devPrint(
          user.value.toString(),
          heading: 'AuthController',
          color: DevPrintColorEnum.green,
        );
      }
    } catch (e) {
      devPrint(
        'Unable to load UserData. Resetting userData.\nError: $e',
        heading: 'AuthController',
        color: DevPrintColorEnum.red,
      );
      user.value = null;
    }
  }

  /// Get SplashScreenController GetxController
  static AuthController get find => Get.find();

  /// User model
  final Rxn<UserModel> user = Rxn<UserModel>();

  /// Authentication initialing function. This will be called from splash screen
  /// controller
  Future<void> init() async {
    await ____init;
    await Future<void>.delayed(const Duration(seconds: 3));
  }

  _userTask() async {
    devPrint(
      'UserData: ${user.value?.toString()}',
      heading: 'AuthController',
      color: DevPrintColorEnum.black,
    );
    if (user.value == null) {
      await _storage.erase();
      if (_isInit) Get.offAll(() => const SplashScreen());
    } else {
      await _storage.write(_localeKey, user.value!.toJson());
    }
  }
}
