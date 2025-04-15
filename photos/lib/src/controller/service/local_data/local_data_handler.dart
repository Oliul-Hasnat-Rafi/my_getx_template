import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


class LocalDataHandler extends GetxController {
late final GetStorage box;


   Future<void> initApp() async {
    await GetStorage.init();
    box = GetStorage();
    
  }
}