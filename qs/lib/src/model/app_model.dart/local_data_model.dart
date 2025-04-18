import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:photos/src/model/app_model.dart/app_model.dart';
import 'package:photos/src/model/response_model/UserModel.dart';

class LocalDataModel {
  final Rx<UserModel> userData;
  final Rx<AppModel> appData;
  LocalDataModel({
    UserModel? userData,
    AppModel? appData,
  })  : userData = Rx(userData ?? UserModel()),
        appData = Rx(appData ?? AppModel());

  LocalDataModel copyWith({
    UserModel? userData,
    AppModel? appData,
  }) {
    return LocalDataModel(
      userData: userData ?? this.userData.value,
      appData: appData ?? this.appData.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userData': userData.value.toJson(),
      'appData': appData.value.toJson(),
    };
  }

  factory LocalDataModel.fromJson(Map<String, dynamic> json) {
    return LocalDataModel(
      userData: UserModel.fromJson(json['userData']),
      appData: AppModel.fromJson(json['appData']),
    );
  }
}
