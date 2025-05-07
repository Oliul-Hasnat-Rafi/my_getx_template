
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:photos/src/controller/service/error_handlers/app_exceptions.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:tuple/tuple.dart';
import '../api/api_services.dart';

class ErrorHandler {
  //final ApiServices _apiServices;
  bool showErrorSnack = true;

  // ErrorHandler({ApiServices? apiServices})
  //     : _apiServices = apiServices ?? GetIt.instance<ApiServices>();

  Future<ResponseModel> errorHandler({
    bool showError = true,
    required Future Function() function,
    bool isAuthService = false,
  }) async {
    Tuple2<ErrorType, int?> res = await _errorHandler(
      showError: showError,
      function: () async => await function(),
      isAuthService: isAuthService,
    );

    if (res.item1 == ErrorType.invalidUser) {
      if (showError) InvalidUser();
    }

    return ResponseModel(isSuccess: res.item1 == ErrorType.done, statusCode: res.item2 ?? -1);
  }

  Future<Tuple2<ErrorType, int?>> _errorHandler({
    bool showError = true,
    required Function function,
    required bool isAuthService,
  }) async {
    try {
      await function();
      showErrorSnack = true;
      return const Tuple2(ErrorType.done, null);
    } on SocketException {
      if (kDebugMode) print("ErrorHandler: SocketException");
      if (showError && showErrorSnack) InternetException();
      showErrorSnack = false;
      return const Tuple2(ErrorType.internetException, null);
    } on TimeoutException {
      if (kDebugMode) print("ErrorHandler: TimeoutException");
      if (showError && showErrorSnack) RequestTimeOutException();
      showErrorSnack = false;
      return const Tuple2(ErrorType.requestTimeOut, null);
    } on FormatException {
      if (kDebugMode) print("ErrorHandler: FormatException");
      if (showError && showErrorSnack) FormatException();
      showErrorSnack = false;
      return const Tuple2(ErrorType.requestTimeOut, null);
    } catch (e) {
      devPrint("ErrorHandler: ${e.toString()}");
      if (e is! http.Response) {
        if (kDebugMode) print("ErrorHandler: ${e.toString()}");
        if (showError && showErrorSnack) CustomException();
        showErrorSnack = false;
        return const Tuple2(ErrorType.customException, null);
      }
      if (e.statusCode == 401) {
        if (kDebugMode) print("ErrorHandler: InvalidUser");
        return Tuple2(ErrorType.invalidUser, e.statusCode);
      }

      if (e.statusCode == 321 && isAuthService) return Tuple2(ErrorType.done, e.statusCode);
      if (e.statusCode == 322 && isAuthService) return Tuple2(ErrorType.done, e.statusCode);
      if (e.statusCode == 323 && isAuthService) return Tuple2(ErrorType.done, e.statusCode);

      if (kDebugMode) print("ErrorHandler: CustomException");

      String message = "";
      try {
        message = jsonDecode(e.body)['error'] ?? "";
      } catch (_) {}

      if (showError && showErrorSnack) {
        CustomException(
          message: message.isEmpty ? "Unexpected error. Please contact the support team." : message,
          response: "Error code: ${e.statusCode}",
        );
      }
      showErrorSnack = false;
      return Tuple2(ErrorType.customException, e.statusCode);
    }
  }
}

enum ErrorType {
  done,
  internetException,
  requestTimeOut,
  invalidUser,
  customException,
}

class ResponseModel {
  final bool isSuccess;
  final int statusCode;

  ResponseModel({required this.isSuccess, this.statusCode = -1});
}
