part of 'http_repository.dart';

const Duration _apiCallTimeOut = Duration(seconds: 30);
const DevPrintColorEnum _color = DevPrintColorEnum.magenta;
const String _tab = '\t';

/// Http Client for calling API
class _HttpClient {
  /// Constructor
  _HttpClient() {
    // Initialize default headers
    _dio.options.headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    // Set default timeout
    _dio.options.connectTimeout = _apiCallTimeOut;
    _dio.options.receiveTimeout = _apiCallTimeOut;

    // Add interceptor to catch cookies
    _dio.options.validateStatus = (int? status) => true;
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onResponse: (
          dio.Response<dynamic> response,
          dio.ResponseInterceptorHandler handler,
        ) {
          if (response.headers.map['set-cookie'] != null &&
              response.headers.map['set-cookie']!.isNotEmpty) {
            _cookie =
                response.headers.map['set-cookie']![0].split(';')[0].trim();
          }
          return handler.next(response);
        },
      ),
    );
  }
  final AuthController _controller = AuthController.find;
  final dio.Dio _dio = dio.Dio();

  String _cookie = '';

  String get _getToken {
    String token = _controller.user.value?.token ?? '';
    if (token.isEmpty) return '';
    return 'Bearer $token';
  }

  String get _baseLink => Environment.apiBaseUrl;

  /// Get request
  Future<dio.Response<Map<String, dynamic>>> get(
    String url, {
    String? token,
    Map<String, String>? headerParameter,
    Map<String, String>? additionalHeaderParameter,
    bool addCookie = false,
    String? customBaseLink,
  }) async {
    if (kDebugMode) showToast(title: null, message: url);

    final dio.Options options = dio.Options(headers: <String, String>{});

    if (headerParameter != null) {
      options.headers?.addAll(headerParameter);
    }

    if (additionalHeaderParameter != null) {
      options.headers?.addAll(additionalHeaderParameter);
    }

    if ((token) != null || _getToken.isNotEmpty) {
      options.headers?[HttpHeaders.authorizationHeader] = token ?? _getToken;
    }

    if (addCookie && _cookie.isNotEmpty) {
      options.headers?['Cookie'] = _cookie;
    }

    String sendLink = (customBaseLink ?? _baseLink) + url;

    _printReport(
      isGet: true,
      isResponse: false,
      sendLink: sendLink,
    );

    final dio.Response<Map<String, dynamic>> response = await _dio.get(
      sendLink,
      options: options,
    );

    _printReport(
      isGet: true,
      isResponse: true,
      sendLink: sendLink,
      response: response,
    );

    return response;
  }

  /// Post request
  Future<dio.Response<Map<String, dynamic>>> post(
    String url, {
    bool isAuthServer = false,
    String? token,
    Map<String, String>? headerParameter,
    Map<String, String>? additionalHeaderParameter,
    bool addCookie = false,
    Object? body,
    String? customBaseLink,
    bool doEncode = true,
    bool isNavService = false,
  }) async {
    if (kDebugMode) showToast(title: null, message: url);

    final dio.Options options = dio.Options(headers: <String, String>{});

    if (headerParameter != null) {
      options.headers?.addAll(headerParameter);
    }

    if (additionalHeaderParameter != null) {
      options.headers?.addAll(additionalHeaderParameter);
    }

    if ((token) != null || _getToken.isNotEmpty) {
      options.headers?[HttpHeaders.authorizationHeader] = token ?? _getToken;
    }

    if (addCookie && _cookie.isNotEmpty) {
      options.headers?['Cookie'] = _cookie;
    }

    String? processedBody;
    if (body != null) {
      if (doEncode && body is Map<String, dynamic>) {
        processedBody = jsonEncode(body);
      } else {
        processedBody = body.toString();
      }
    }

    String sendLink = (customBaseLink ?? _baseLink) + url;
    _printReport(
      isGet: false,
      isResponse: false,
      sendLink: sendLink,
      processedBody: processedBody,
    );

    final dio.Response<Map<String, dynamic>> response = await _dio.post(
      sendLink,
      data: processedBody,
      options: options,
    );

    _printReport(
      isGet: false,
      isResponse: true,
      sendLink: sendLink,
      processedBody: processedBody,
      response: response,
    );

    return response;
  }

  String _getHeader(dio.Response<Map<String, dynamic>>? response) {
    if (response == null) return '';

    final dio.Headers headers = response.headers;
    String header = '';
    for (final MapEntry<String, List<String>> entry in headers.map.entries) {
      header += '${entry.key}: ${entry.value}\t';
    }
    return header;
  }

  void _printReport({
    required String sendLink,
    dio.Response<Map<String, dynamic>>? response,
    String? processedBody,
    required bool isGet,
    required bool isResponse,
  }) {
    //! URL
    String printString = 'Url: $_tab$sendLink';

    //! Response
    if (response != null) {
      printString = '''$printString (${response.statusCode})
Header: $_tab${_getHeader(response)}''';
    }

    //! Body
    if (processedBody != null && processedBody != '{}') {
      printString = '''$printString
Body: $_tab$processedBody''';
    }

    //! Data
    if (response != null &&
        response.data != null &&
        response.data!.isNotEmpty) {
      printString = '''$printString
Data: $_tab${response.data.toString()}''';
    }

    String heading = 'HttpCall:';
    heading = '$heading ${isGet ? 'GET' : 'POST'}';
    heading = '$heading - ${isResponse ? 'Response' : 'Requesting'}';

    devPrint(printString, heading: heading, color: _color);
  }
}
