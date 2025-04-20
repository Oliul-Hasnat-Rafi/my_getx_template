import 'package:photos/src/core/utils/app_context.dart';
import 'package:photos/src/core/utils/utils.dart';

abstract class AppExceptions {
  final String prefix;
  final String message;

  AppExceptions({this.prefix = "", this.message = ""}) {
    showSnackBarMessage(AppContext.context, message, SnackBarMessageType.failure);
  }
}

class InternetException extends AppExceptions {
  InternetException({String? message}) : super(prefix: "Error", message: "No Internet Connection. ${message ?? ""}");
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException({String? message}) : super(prefix: "Error", message: "Request timeout. ${message ?? ""}");
}

class FormatException extends AppExceptions {
  FormatException({String? message}) : super(prefix: "Error", message: message ?? "Something went wrong. Please contact to the support team or try again later.");
}

class InvalidUser extends AppExceptions {
  InvalidUser({String? message}) : super(prefix: "Error", message: "Invalid user. ${message ?? ""}");
}

class CustomException extends AppExceptions {
  CustomException({String? message, String? response}) : super(prefix: "Error", message: "${message ?? "Something went wrong. Please contact to the support team or try again later."}${response == null ? "" : "\n$response"}");
}