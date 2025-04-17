import 'package:flutter/material.dart';

import '../../../model/response_model/UserModel.dart';

abstract class AppStorageI {
  Future<void> storeBearerToken(String token);

  Future<String?> retrieveBearerToken();
  Future<void> storeCredentials(Map<String, dynamic> credentials);

  Future<Map<String, dynamic>?> retrieveCredentials();

  Future<void> clearCredentials();

  Future<void> clearToken();

  Future<void> changeTheme(ThemeMode themeMode);

  Future<String?> retrieveTheme();

  Future<void> setUserData(UserModel userModel);
  Future<UserModel?> getUserData();
}
