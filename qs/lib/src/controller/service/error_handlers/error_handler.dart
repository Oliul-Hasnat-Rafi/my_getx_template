import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/error_handlers/app_exceptions.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:tuple/tuple.dart';
import '../../data_controller/data_controller.dart';
import '../api/api_services.dart';

class ErrorHandler {
  late final DataController controller;
  late final ApiServices apiServices;
  bool showErrorSnack = true;
  ErrorHandler() {
    controller = Get.find();
    apiServices = Get.find();
  }

  Future<ResponseModel> errorHandler({bool showError = true, required Future Function() function, bool isAuthService = false}) async {
   

    
    Tuple2<ErrorType, int?> res = await _errorHandler(
      showError: showError,
      function: () async => await function(),
      isAuthService: isAuthService,
    );

    //! -------------------------------------------------------------------------------------------- Refreshing token
    if (res.item1 == ErrorType.invalidUser) {
      if (showError) InvalidUser();
    
    }

    return ResponseModel(isSuccess: res.item1 == ErrorType.done, statusCode: res.item2 ?? -1);

    // await function();
    // return ResponseModel(isSuccess: true, statusCode: 200);
  }


  Future<Tuple2<ErrorType, int?>> _errorHandler({bool showError = true, required Function function, required bool isAuthService}) async {
    try {
      await function();
      showErrorSnack = true;
      return const Tuple2(ErrorType.done, null); // !  --------------------------------------------- Done
    } on SocketException {
      if (kDebugMode) print("ErrorHandler: SocketException");
      if (showError && showErrorSnack) InternetException();
      showErrorSnack = false;
      return const Tuple2(ErrorType.internetException, null); //! ---------------------------------- InternetException
    } on TimeoutException {
      if (kDebugMode) print("ErrorHandler: TimeoutException");
      if (showError && showErrorSnack) RequestTimeOutException();
      showErrorSnack = false;
      return const Tuple2(ErrorType.requestTimeOut, null); //! ------------------------------------- TimeoutException
    } on FormatException {
      if (kDebugMode) print("ErrorHandler: FormatException");
      if (showError && showErrorSnack) FormatException();
      showErrorSnack = false;
      return const Tuple2(ErrorType.requestTimeOut, null); //! ------------------------------------- FormatException
    } catch (e) {
     devPrint( "ErrorHandler: ${e.toString()}");
      if (e is! http.Response) {
        if (kDebugMode) print("ErrorHandler: ${e.toString()}");
        if (showError && showErrorSnack) CustomException();
        showErrorSnack = false;
        return const Tuple2(ErrorType.customException, null); //! ------------------------------------------- CustomException
      }
      if (e.statusCode == 401) {
        if (kDebugMode) print("ErrorHandler: InvalidUser");
        return Tuple2(ErrorType.invalidUser, e.statusCode); //! -------------------------------------- InvalidUser
      }

      if (e.statusCode == 321 && isAuthService) return Tuple2(ErrorType.done, e.statusCode); //! ------------------------------------------- OTP Request
      if (e.statusCode == 322 && isAuthService) return Tuple2(ErrorType.done, e.statusCode); //! ------------------------------------------- OTP Request
      if (e.statusCode == 323 && isAuthService) return Tuple2(ErrorType.done, e.statusCode); //! ------------------------------------------- OTP Request

      if (kDebugMode) print("ErrorHandler: CustomException");

      String message = "";
      try {
        message = jsonDecode(e.body)['error'] ?? "";
      } catch (_) {}

      // if (message.isNotEmpty) message = "Error Message: $message";
      if (showError && showErrorSnack) CustomException(message: message.isEmpty ? "Unexpected error. Please contact the support team." : message, response: "Error code: ${e.statusCode}");
      showErrorSnack = false;
      return Tuple2(ErrorType.customException, e.statusCode); //! ---------------------------------------- CustomException
    }
  }
}

enum ErrorType {
  done,
  internetException,
  requestTimeOut,
  invalidUser,
  customException
}

class ResponseModel {
  final bool isSuccess;
  final int statusCode;

  ResponseModel({required this.isSuccess, this.statusCode = -1});
}
