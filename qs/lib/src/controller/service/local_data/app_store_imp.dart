import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';
import 'package:photos/src/model/app_model.dart/local_data_model.dart';
import 'package:photos/src/model/response_model/user_response_model.dart';

class AppStorageImp implements AppStorageI {
  GetStorage? _box;
  final String _userDataKey = "userData";
  final String _userDataToken = "userToken";
  final String _themeMode = "themeMode";
  final String _languageType = "languageType";
  LocalDataModel localData = LocalDataModel();

  AppStorageImp();

  @override
  Future<void> initApp() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  Future<GetStorage> _ensureBox() async {
    if (_box == null) {
      await initApp();
    }
    return _box!;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    final box = await _ensureBox();
    await box.write(key, value);
  }

  @override
  Future<dynamic> read(String key) async {
    try {
      final box = await _ensureBox();
      return box.read(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeBearerToken(String token) async {
    localData = localData.copyWith(
      userData: localData.userData.value.copyWith(
        accessToken: token,
      ),
    );
    final box = await _ensureBox();
    await box.write(_userDataToken, token);
  }

  @override
  Future<String?> retrieveBearerToken() async {
    try {
      final box = await _ensureBox();
      return box.read<String>(_userDataToken);
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
    final box = await _ensureBox();
    await box.remove(_userDataToken);
  }

  @override
  Future<void> setUserData(UserModel userData) async {
    localData = localData.copyWith(userData: userData);
    final box = await _ensureBox();
    await box.write(_userDataKey, userData.toJson());
  }

  @override
  Future<UserModel?> getUserData() async {
    try {
      final box = await _ensureBox();
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
  Future<void> changeTheme(ThemeMode themeMode) async {
    localData = localData.copyWith(
      appData: localData.appData.value.copyWith(
        appTheme: themeMode.name,
      ),
    );
    final box = await _ensureBox();
    await box.write(_themeMode, themeMode.name);
  }

  @override
  Future<String?> retrieveTheme() async {
    try {
      final box = await _ensureBox();
      return box.read<String>(_themeMode);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeCredentials(Map<String, dynamic> credentials) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> retrieveCredentials() {
    throw UnimplementedError();
  }

  @override
  Future<void> clearCredentials() {
    throw UnimplementedError();
  }

  @override
  Future<void> changeLanguage(String languageType) async {
    localData = localData.copyWith(
      appData: localData.appData.value.copyWith(
        appLanguage: languageType,
      ),
    );
    final box = await _ensureBox();
    await box.write(_languageType, languageType);
  }

  @override
  Future<String?> retrieveLanguage() async {
    try {
      final box = await _ensureBox();
      return box.read<String>(_languageType);
    } catch (e) {
      return null;
    }
  }
}