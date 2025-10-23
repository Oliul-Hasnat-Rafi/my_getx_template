import 'package:get_storage/get_storage.dart';

/// This class is used to handle [BaseUseCase].
///
/// This can be used for saving and reading simple local values.
///
/// [saveData] to save Data
///
/// [readData] to read Data
abstract class BaseUseCase {
  static bool _isInit = false;
  static final GetStorage _storage = GetStorage();

  static Future<void> get ____init async {
    if (_isInit) return;
    await GetStorage.init();
    _isInit = true;
  }

  /// Save Data
  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await ____init;
    await _storage.write(key, value);
  }

  /// Read Data
  static Future<String?> readData({
    required String key,
  }) async {
    await ____init;
    return _storage.read<String>(key);
  }
}
