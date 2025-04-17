import 'package:get/get.dart';
import '../../model/response_model/UserModel.dart';
import '../service/api/api_services.dart';
import '../service/error_handlers/error_handler.dart';
import '../service/local_data/local_data_handler.dart';

class DataController extends GetxController {
  bool _isInit = false;
  late final ApiServices _apiServices;
  late final ErrorHandler _errorHandler;
  late final LocalDataHandler localData;

  DataController() {
    localData = Get.put(LocalDataHandler());
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
    await localData.initApp();
    _errorHandler = ErrorHandler();
  }

  get isLogin async {
    return localData.localData.userData.value.accessToken != null && localData.localData.userData.value.accessToken!.isNotEmpty;
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
        localData.setUserData(t!);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
}
