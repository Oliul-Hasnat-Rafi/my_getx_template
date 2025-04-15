import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:photos/src/model/response_model/UserModel.dart';

class LocalDataModel {
  final Rx<UserModel> userData;

  LocalDataModel({
    UserModel? userData,
  }) : userData = Rx<UserModel>(userData ?? UserModel());

  LocalDataModel copyWith({
    UserModel? userData,
  }) {
    return LocalDataModel(
      userData: userData ?? this.userData.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userData': userData.value.toJson(),
    };
  }

  factory LocalDataModel.fromJson(Map<String, dynamic> json) {
    return LocalDataModel(
      userData: UserModel.fromJson(json['userData']),
    );
  }
}
