import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photos/src/controller/service/api/api_services.dart';
import 'package:photos/src/controller/service/api/rest_client.dart';
import 'package:photos/src/controller/service/error_handlers/error_handler.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';
import 'package:photos/src/controller/service/local_data/app_store_imp.dart';
import '../data_controller/data_controller.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    await GetStorage.init();
    getIt.registerSingleton<AppStorageI>(AppStorageImp());
    await getIt<AppStorageI>().initApp();
    getIt.registerSingleton<RestClient>(RestClient());
    getIt.registerSingleton<ApiServices>(ApiServices());
    getIt.registerLazySingleton<ErrorHandler>(() => ErrorHandler());
    getIt.registerLazySingleton<DataController>(() => DataController());
  }
}
