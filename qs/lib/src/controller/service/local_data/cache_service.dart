import 'app_store.dart';
import 'app_store_imp.dart';

class CacheService {
  CacheService._internal();
  
  static late final AppStorageI _appStorage;
  
  static Future<void> init() async {
    _appStorage = AppStorageImp();
    if (_appStorage is AppStorageImp) {
      await (_appStorage as AppStorageImp).initApp();
    }
  }
  
  static AppStorageI get instance {
    return _appStorage;
  }
}
