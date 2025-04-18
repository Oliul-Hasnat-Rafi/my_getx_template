import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user_message/snackbar.dart';

abstract class AppExceptions {
  final String prefix;
  final String message;

  AppExceptions({this.prefix = "", this.message = ""}) {
    showSnackBar(
      title: prefix,
      message: message,
      icon: Icon(Icons.error, color: Get.theme.colorScheme.error),
    );
  }
}

//! InternetException
class InternetException extends AppExceptions {
  InternetException({String? message}) : super(prefix: "Error", message: "No Internet Connection. ${message ?? ""}");
}

//! RequestTimeOut
class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException({String? message}) : super(prefix: "Error", message: "Request timeout. ${message ?? ""}");
}

//! RequestTimeOut
class FormatException extends AppExceptions {
  FormatException({String? message}) : super(prefix: "Error", message: message ?? "Something went wrong. Please contact to the support team or try again later.");
}

//! InvalidUser
class InvalidUser extends AppExceptions {
  InvalidUser({String? message}) : super(prefix: "Error", message: "Invalid user. ${message ?? ""}");
}

//! CustomException
class CustomException extends AppExceptions {
  CustomException({String? message, String? response}) : super(prefix: "Error", message: "${message ?? "Something went wrong. Please contact to the support team or try again later."}${response == null ? "" : "\n$response"}");
}
