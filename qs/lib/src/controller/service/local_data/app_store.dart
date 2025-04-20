import 'package:flutter/material.dart';
import 'package:photos/src/model/response_model/user_response_model.dart';

abstract class AppStorageI {
  Future<void> write(String key, dynamic value);
  Future<dynamic> read(String key);
  Future<void> storeBearerToken(String token);
  Future<String?> retrieveBearerToken();
  Future<void> clearToken();
  Future<void> setUserData(UserModel userData);
  Future<UserModel?> getUserData();
  Future<void> changeTheme(ThemeMode themeMode);
  Future<String?> retrieveTheme();
  Future<void> storeCredentials(Map<String, dynamic> credentials);
  Future<Map<String, dynamic>?> retrieveCredentials();
  Future<void> clearCredentials();
  Future<void> changeLanguage(String languageType);
  Future<String?> retrieveLanguage();
}