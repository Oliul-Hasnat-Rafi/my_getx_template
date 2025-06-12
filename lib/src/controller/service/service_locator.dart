import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/screen_controller/auth_screen_controller.dart';
import 'package:photos/src/controller/screen_controller/base_controller.dart/base_controller.dart';
import 'package:photos/src/controller/service/api/api_services.dart';
import 'package:photos/src/controller/service/api/rest_client.dart';
import 'package:photos/src/controller/service/error_handlers/error_handler.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';
import 'package:photos/src/controller/service/local_data/app_store_imp.dart';
import '../data_controller/data_controller.dart';
import '../screen_controller/home_screen_controller.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    try {
      getIt.registerSingleton<AppStorageI>(AppStorageImp());
      await getIt<AppStorageI>().initApp();

      getIt.registerSingleton<RestClient>(RestClient());
      getIt.registerSingleton<ApiServices>(ApiServices());
      getIt.registerLazySingleton<ErrorHandler>(() => ErrorHandler());
      getIt.registerFactory<DataController>(() => DataController());
      getIt.registerFactory<BaseController>(() => BaseController());
      await getIt<BaseController>().init();
      getIt.registerSingleton<AuthScreenController>(AuthScreenController());
     await  getIt<AuthScreenController>().initData();
      getIt.registerFactory<HomeScreenController>(() => HomeScreenController());
    } catch (e) {
      rethrow;
    }
  }
}
