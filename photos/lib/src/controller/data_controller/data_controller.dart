import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../model/response_model/photo_screen_response_model.dart';
import '../service/api/api_services.dart';
import '../service/error_handlers/error_handler.dart';
import '../service/local_data/local_data_handler.dart';

class DataController extends GetxController {
  bool _isInit = false;
  late final ApiServices _apiServices;
  late final ErrorHandler _errorHandler;
    late final LocalDataHandler localData = Get.put(LocalDataHandler());


  Future<void> initApp() async {
    if (_isInit) return;
    await startupTasks();
    _isInit = true;
  }

  Future<void> startupTasks() async {
    _apiServices = Get.put(ApiServices());
    localData.initApp();
    _errorHandler = ErrorHandler();
  }

  Future<List<PhotoScreenResponseModel>> getPhotos({required int perPage, required int currentPage}) async {
    if (!_isInit) {
      await initApp();
    }
    List<PhotoScreenResponseModel> res = [];
    await _errorHandler.errorHandler(function: () async => res = await _apiServices.getPhotos(perPage: perPage, currentPage: currentPage));
    return res;
  }
  Future<Uint8List?> photoDownload( String photoUrl) async {
    Uint8List? res;
    await _errorHandler.errorHandler(function: () async => res = await _apiServices.getPhotoDownload(photoUrl));
    return res;
  }
}
