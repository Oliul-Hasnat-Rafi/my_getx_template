import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';
import 'package:photos/src/model/app_model.dart/local_data_model.dart';
import 'package:photos/src/model/response_model/UserModel.dart';

class AppStorageImp extends GetxController implements AppStorageI {
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

  @override
  Future<void> changeTheme(ThemeMode themeMode) {
    // TODO: implement changeTheme
    throw UnimplementedError();
  }

  @override
  Future<void> clearCredentials() {
    // TODO: implement clearCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> clearToken() {
    // TODO: implement clearToken
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> retrieveCredentials() {
    // TODO: implement retrieveCredentials
    throw UnimplementedError();
  }

  @override
  Future<String?> retrieveTheme() {
    // TODO: implement retrieveTheme
    throw UnimplementedError();
  }

  @override
  Future<void> storeBearerToken(String token) async {
    localData = localData.copyWith(
      userData: localData.userData.value.copyWith(
        accessToken: token,
      ),
    );
    await box.write(_userDataKey, localData.toJson());
  }

  @override
  Future<String?> retrieveBearerToken() async {
    return localData.userData.value.accessToken;
  }

  @override
  Future<void> storeCredentials(Map<String, dynamic> credentials) {
    // TODO: implement storeCredentials
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUserData() {
    return Future.value(localData.userData.value);
  }

  @override
  Future<void> setUserData(UserModel userData) async {
    localData = localData.copyWith(userData: userData);
    box.write(_userDataKey, localData.toJson());
  }
}
