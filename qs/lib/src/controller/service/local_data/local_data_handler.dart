import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:photos/src/model/app_model.dart/local_data_model.dart';
import 'package:photos/src/model/response_model/UserModel.dart';

class LocalDataHandler extends GetxController {
  late final GetStorage box;
  final String _userDataKey = "userData";
  LocalDataModel localData = LocalDataModel();
   

  Future<void> initApp() async {
    await GetStorage.init();
    box = GetStorage();
    var r = box.read(_userDataKey);
   try {
     if (r != null) {
       localData = LocalDataModel.fromJson(r);
     }
   } catch (e) {
     box.erase();
   }

  }
  
  void setUserData(UserModel userData) {
    localData = localData.copyWith(userData: userData);
    box.write(_userDataKey, localData.toJson());
  } 


}
