import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/api/api_end_points.dart';
import '../functions/dev_print.dart';
import '../local_data/app_store_imp.dart';
import '../user_message/snackbar.dart';

class RestClient {
  late dio.Dio _dio;
  String _cookie = "";

  final Duration _timeout = const Duration(seconds: 30);
  final Map<String, String> _defaultHeaders = {
    "Content-Type": "application/json",
    "TimeZone": DateTime.now().toLocal().timeZoneOffset.toString(),
    "Accept": "/",
  };

  RestClient() {
    dio.BaseOptions options = dio.BaseOptions(
      baseUrl: ApiEndPoints.baseLink,
      connectTimeout: _timeout,
      receiveTimeout: const Duration(seconds: 3000),
      headers: _defaultHeaders,
    );
    _dio = dio.Dio(options);
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onResponse: (response, handler) {
          if (response.headers.map.containsKey('set-cookie')) {
            List<String> cookies = response.headers.map['set-cookie'] ?? [];
            if (cookies.isNotEmpty) {
              _cookie = cookies.first.split(";")[0].trim();
              devPrint("Cookie set: $_cookie");
            }
          }
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          if (dioError.type == dio.DioExceptionType.connectionError || dioError.type == dio.DioExceptionType.connectionTimeout) {
            try {
              final res = await _getOfflineData(
                dioError.requestOptions.path,
                dioError.requestOptions.data,
              );
              if (res != null) {
                return handler.resolve(res);
              }
            } catch (error) {
              devPrint("Unable to fetch offline data: $error");
            }
          }
          return handler.next(dioError);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(dio.LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  Future<void> _saveResponseToStorage(String url, dynamic body, dio.Response response) async {
    final AppStorageImp localData = Get.put(AppStorageImp());
    final String key = "${url.hashCode}_${body == null ? "" : body.hashCode}";

    try {
      final Map<String, dynamic> responseData = {
        'statusCode': response.statusCode,
        'data': response.data,
        'headers': response.headers.map.map((k, v) => MapEntry(k, v.join(';'))),
      };

      localData.box.write(key, json.encode(responseData));
      devPrint("RestClient: Saved data for $url");
    } catch (e) {
      devPrint("RestClient: Failed to save data for $url. Error: $e");
    }
  }

  Future<dio.Response<dynamic>?> _getOfflineData(String url, dynamic body) async {
    final AppStorageImp localData = Get.put(AppStorageImp());
    final String key = "${url.hashCode}_${body == null ? "" : body.hashCode}";

    String? cachedData = localData.box.read(key);
    if (cachedData == null) return null;

    Map<String, dynamic> mapTemp = json.decode(cachedData);

    if (showOfflineToast) {
      showToast(message: "Offline mode");
      showOfflineToast = false;
    }

    return dio.Response(
      requestOptions: dio.RequestOptions(path: url),
      statusCode: mapTemp['statusCode'],
      data: mapTemp['data'],
      headers: dio.Headers.fromMap(
        Map<String, List<String>>.from(
          (mapTemp['headers'] as Map).map((k, v) => MapEntry(k, [
                v.toString()
              ])),
        ),
      ),
    );
  }

  bool showOfflineToast = true;

  Future<dio.Response<dynamic>> get(String url, {String token = '', bool isImageUrl = false, Map<String, String>? headerParameter, int? timeout, bool addCookie = false}) async {
    final dio.Options options = dio.Options(
      headers: _buildHeaders(token, headerParameter, addCookie),
      sendTimeout: timeout != null ? Duration(seconds: timeout) : _timeout,
    );

    final String sendLink = isImageUrl ? url : url;
    devPrint("RestClient: Requesting: GET ----- $sendLink");

    try {
      final response = await _dio.get(
        sendLink,
        options: options,
      );

      await _saveResponseToStorage(sendLink, null, response);

      devPrint("RestClient: Response: GET ----- $sendLink ----- Status Code: ${response.statusCode} ----- Data: ${response.data}");

      showOfflineToast = true;
      return response;
    } catch (e) {
      devPrint("RestClient: GET Error: $e");
      rethrow;
    }
  }

  Future<dio.Response<dynamic>> post(String url, {String token = '', Map<String, String>? headerParameter, Object? body, int? requestTimeout, bool addCookie = false}) async {
    final dio.Options options = dio.Options(
      headers: _buildHeaders(token, headerParameter, addCookie),
      sendTimeout: requestTimeout != null ? Duration(seconds: requestTimeout) : _timeout,
    );

    final String sendLink = url;
    if (kDebugMode) {
      devPrint("RestClient: Requesting: POST ----- $sendLink ----- $body");
      showToast(message: sendLink);
    }

    try {
      final response = await _dio.post(
        sendLink,
        data: body,
        options: options,
      );

      await _saveResponseToStorage(sendLink, body, response);

      if (kDebugMode) {
        devPrint("RestClient: Response: POST ----- $sendLink ----- Status Code: ${response.statusCode} ----- Data: ${response.data}");
      }

      showOfflineToast = true;
      return response;
    } catch (e) {
      devPrint("RestClient: POST Error: $e");
      rethrow;
    }
  }

  Map<String, dynamic> _buildHeaders(String token, Map<String, String>? headerParameter, bool addCookie) {
    final Map<String, dynamic> headers = {};
    headers.addAll(headerParameter ?? _defaultHeaders);

    if (token.isNotEmpty) {
      headers.addAll({
        "Authorization": token
      });
    }

    if (addCookie && _cookie.isNotEmpty) {
      headers.addAll({
        'Cookie': _cookie
      });
    }

    return headers;
  }
}
