import 'package:get/get.dart';
import 'package:photos/src/controller/service/local_data/cache_service.dart';
import 'package:photos/src/model/response_model/product_response_model.dart';
import '../../model/response_model/user_response_model.dart';
import '../service/api/api_services.dart';
import '../service/error_handlers/error_handler.dart';
import '../service/local_data/app_store.dart';
import '../service/local_data/app_store_imp.dart';

class DataController extends GetxController {
  bool _isInit = false;
  late final ApiServices _apiServices;
  late final ErrorHandler _errorHandler;
  late final AppStorageI localData;

  DataController() {
    localData = Get.put(AppStorageImp());
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
    await CacheService.init();
    _errorHandler = ErrorHandler();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel? user;
      final result = await _errorHandler.errorHandler(function: () async {
        user = await _apiServices.login(email: email, password: password);
      });
      if (result.isSuccess && user?.accessToken != null) {
        await CacheService.instance.storeBearerToken(user!.accessToken!);
        await CacheService.instance.setUserData(user!);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<List<Product>> getProduct() async {
    try {
      List<Product>? products;
      await _errorHandler.errorHandler(function: () async {
        products = await _apiServices.getProduct();
      });
      if (products != null) {
        return products!;
      } else {
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      throw Exception("Error fetching product: $e");
    }
  }
}
