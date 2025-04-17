import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:photos/src/controller/service/api/http_call.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:photos/src/model/response_model/UserModel.dart';

import '../../../../components.dart';
import '../../../model/response_model/photo_screen_response_model.dart';

class ApiServices extends GetxController {
  late final HttpCall _httpCall;
  ApiServices() : _httpCall = HttpCall();

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpCall.post(
        'auth/login',
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );

      return UserModel.fromJson(
        jsonDecode(response.body),
      );
    } catch (e) {
      devPrint(e.toString());
    }
    return null;
  }
  
}
