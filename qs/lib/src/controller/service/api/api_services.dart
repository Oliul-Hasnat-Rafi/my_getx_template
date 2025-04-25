import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/service/api/api_end_points.dart';
import 'package:photos/src/controller/service/api/rest_client.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:photos/src/model/response_model/product_response_model.dart';
import 'package:photos/src/model/response_model/user_response_model.dart';

class ApiServices extends GetxController {
  final RestClient _httpCall;

  ApiServices({RestClient? httpCall}) : _httpCall = httpCall ?? GetIt.instance<RestClient>();

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
      devPrint("ApiServices: Login error: $e");
      rethrow;
    }
  }

  Future<List<Product>?> getProduct() async {
    try {
      final response = await _httpCall.get(
        ApiEndPoints.products,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        devPrint('ApiServices: Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      devPrint("ApiServices: Get product error: $e");
      rethrow;
    }
  }
}
