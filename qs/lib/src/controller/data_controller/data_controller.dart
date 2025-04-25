import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/service/api/api_services.dart';
import 'package:photos/src/controller/service/error_handlers/error_handler.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';
import 'package:photos/src/model/response_model/product_response_model.dart';
import '../../model/response_model/user_response_model.dart';

class DataController extends GetxController {
  bool _isInit = false;
  final ApiServices _apiServices;
  final ErrorHandler _errorHandler;
  final AppStorageI _localData;

  DataController({
    ApiServices? apiServices,
    ErrorHandler? errorHandler,
    AppStorageI? localData,
  })  : _apiServices = apiServices ?? GetIt.instance<ApiServices>(),
        _errorHandler = errorHandler ?? GetIt.instance<ErrorHandler>(),
        _localData = localData ?? GetIt.instance<AppStorageI>();

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
    // Dependencies are initialized in ServiceLocator.setup()
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
        await _localData.storeBearerToken(user!.accessToken!);
        await _localData.setUserData(user!);
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
