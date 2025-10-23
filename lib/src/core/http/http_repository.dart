import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import '../../controllers/data_controllers/auth_controller.dart';
import '../../utils/dev_functions/dev_print.dart';
import '../../utils/user_message/snackbar.dart';
import '../environment/environment.dart';
import 'http_error_enum.dart';

part 'http_client.dart';
part 'http_error_handler.dart';

/// Base class for HTTP repositories
///
/// [httpClient] for HTTP requests
///
/// [errorHandler] for handling HTTP errors
abstract class HttpRepository {
  /// Base class for HTTP repositories
  ///
  /// Add `import 'package:dio/dio.dart' as dio;`
  final _HttpClient httpClient = _HttpClient();

  /// Error handler for HTTP requests
  final _HttpErrorHandler errorHandler = _HttpErrorHandler();
}
