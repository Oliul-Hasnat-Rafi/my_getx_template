import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/service/api/api_end_points.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:photos/src/controller/service/local_data/app_store.dart';

class RestClient {
  late dio.Dio _dio;
  String _cookie = "";
  final Duration _timeout = const Duration(seconds: 30);
  final Map<String, String> _defaultHeaders = {
    "Content-Type": "application/json",
    "TimeZone": DateTime.now().toLocal().timeZoneOffset.toString(),
    "Accept": "application/json",
  };
  late final AppStorageI _localData;

  RestClient() {
    dio.BaseOptions options = dio.BaseOptions(
      baseUrl: ApiEndPoints.baseLink,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: _defaultHeaders,
    );
    _dio = dio.Dio(options);

    _localData = GetIt.instance<AppStorageI>();

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
    final String key = _generateStorageKey(url, body);

    try {
      final Map<String, dynamic> responseData = {
        'statusCode': response.statusCode,
        'data': response.data,
        'headers': response.headers.map.map((k, v) => MapEntry(k, v.join(';'))),
      };

      await _localData.write(key, json.encode(responseData));
      devPrint("RestClient: Saved data for $url");
    } catch (e) {
      devPrint("RestClient: Failed to save data for $url. Error: $e");
    }
  }

  Future<dio.Response<dynamic>?> _getOfflineData(String url, dynamic body) async {
    final String key = _generateStorageKey(url, body);

    try {
      String? cachedData = await _localData.read(key);
      if (cachedData == null) return null;

      Map<String, dynamic> mapTemp = json.decode(cachedData);

      if (showOfflineToast) {
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
    } catch (e) {
      devPrint("RestClient: Failed to retrieve offline data for $url. Error: $e");
      return null;
    }
  }

  bool showOfflineToast = true;

  Future<dio.Response<dynamic>> get(
    String url, {
    String token = '',
    bool isImageUrl = false,
    Map<String, String>? headerParameter,
    int? timeout,
    bool addCookie = false,
  }) async {
    return _executeRequest(
      method: 'GET',
      url: url,
      token: token,
      headerParameter: headerParameter,
      timeout: timeout,
      addCookie: addCookie,
      isImageUrl: isImageUrl,
    );
  }

  Future<dio.Response<dynamic>> post(
    String url, {
    String token = '',
    Map<String, String>? headerParameter,
    Object? body,
    int? requestTimeout,
    bool addCookie = false,
  }) async {
    return _executeRequest(
      method: 'POST',
      url: url,
      token: token,
      headerParameter: headerParameter,
      timeout: requestTimeout,
      addCookie: addCookie,
      body: body,
    );
  }

  Future<dio.Response<dynamic>> _executeRequest({
    required String method,
    required String url,
    required String token,
    Map<String, String>? headerParameter,
    int? timeout,
    required bool addCookie,
    Object? body,
    bool isImageUrl = false,
  }) async {
    final dio.Options options = dio.Options(
      headers: _buildHeaders(token, headerParameter, addCookie),
      sendTimeout: timeout != null ? Duration(seconds: timeout) : _timeout,
    );

    final String sendLink = isImageUrl ? url : url;
    devPrint("RestClient: Requesting: $method ----- $sendLink${body != null ? ' ----- $body' : ''}");

    try {
      final response = await (method == 'GET' ? _dio.get(sendLink, options: options) : _dio.post(sendLink, data: body, options: options));

      await _saveResponseToStorage(sendLink, body, response);

      devPrint("RestClient: Response: $method ----- $sendLink ----- Status Code: ${response.statusCode} ----- Data: ${response.data}");

      showOfflineToast = true;
      return response;
    } catch (e) {
      devPrint("RestClient: $method Error: $e");
      rethrow;
    }
  }

  Map<String, String> _buildHeaders(String token, Map<String, String>? headerParameter, bool addCookie) {
    final Map<String, String> headers = {
      ...(headerParameter ?? _defaultHeaders)
    };

    if (token.isNotEmpty) {
      headers['Authorization'] = token;
    }

    if (addCookie && _cookie.isNotEmpty) {
      headers['Cookie'] = _cookie;
    }

    return headers;
  }

  String _generateStorageKey(String url, dynamic body) {
    return "$url${body != null ? '_${jsonEncode(body).hashCode}' : ''}";
  }
}
