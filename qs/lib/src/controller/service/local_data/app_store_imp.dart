import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';
import 'package:photos/src/model/app_model.dart/local_data_model.dart';
import 'package:photos/src/model/response_model/UserModel.dart';

class AppStorageImp implements AppStorageI {
  late final GetStorage box;
  final String _userDataKey = "userData";
  final String _userDataToken = "userToken";
  final String _themeMode = "themeMode";
  LocalDataModel localData = LocalDataModel();

  Future<void> initApp() async {
    await GetStorage.init();
    box = GetStorage();
  }

  @override
  Future<void> storeBearerToken(String token) async {
    localData = localData.copyWith(
      userData: localData.userData.value.copyWith(
        accessToken: token,
      ),
    );
    await box.write(_userDataToken, token);
  }

  @override
  Future<String?> retrieveBearerToken() async {
    try {
      final storedToken = box.read<String>(_userDataToken);
      return storedToken;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearToken() async {
    localData = localData.copyWith(
      userData: localData.userData.value.copyWith(
        accessToken: null,
      ),
    );
    await box.remove(_userDataToken);
  }

  @override
  Future<void> setUserData(UserModel userData) async {
    localData = localData.copyWith(userData: userData);
    await box.write(_userDataKey, userData.toJson());
  }

  @override
  Future<UserModel?> getUserData() async {
    try {
      final Map<String, dynamic>? userData = box.read<Map<String, dynamic>>(_userDataKey);
      if (userData != null) {
        return UserModel.fromJson(userData);
      }
      return localData.userData.value;
    } catch (e) {
      return localData.userData.value;
    }
  }

  @override
  Future<void> changeTheme(ThemeMode themeMode) async{
    localData = localData.copyWith(
      appData: localData.appData.value.copyWith(
        appTheme: themeMode.name,
      ),
    );
  await  box.write(_themeMode, themeMode.name);
  
  }

  @override
  Future<String?> retrieveTheme()async {
    try {
      final storedTheme = box.read<String>(_themeMode);
      return storedTheme;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeCredentials(Map<String, dynamic> credentials) {
    // TODO: implement storeCredentials
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> retrieveCredentials() {
    // TODO: implement retrieveCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> clearCredentials() {
    // TODO: implement clearCredentials
    throw UnimplementedError();
  }
}
