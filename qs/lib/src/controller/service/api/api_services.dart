import 'dart:convert';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/api/api_end_points.dart';
import 'package:photos/src/controller/service/api/rest_client.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:photos/src/model/response_model/UserModel.dart';


class ApiServices extends GetxController {
  late final RestClient _httpCall;
  ApiServices() : _httpCall = RestClient();

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpCall.post(
        ApiEndPoints.signIn,
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      devPrint(e.toString());
    }
    return null;
  }
}
