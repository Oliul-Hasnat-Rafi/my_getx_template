part of 'http_repository.dart';

/// Class to handle HTTP errors
class _HttpErrorHandler {
  /// Handle HTTP errors
  Future<HTTPErrorEnum> errorHandler({
    bool showError = true,
    required Future<void> Function() function,
  }) async {
    HTTPErrorEnum? error;
    String serverMessage = '';
    String? message;

    //? Uncomment this snippet to block the errorHandler when tracking Error
    // await function();
    // return HTTPErrorEnum.done;
    //? ------------------------------------------------------------------------

    try {
      await function();
      return HTTPErrorEnum.done;
    } on dio.DioException catch (e) {
      error = _getErrorType(
        statusCode: e.response?.statusCode,
        dioException: e,
      );
      message = e.toString();
    } on TypeError catch (e) {
      error = HTTPErrorEnum.parseError;
      message = e.toString();
    } catch (e) {
      if (e is dio.Response) error = _getErrorType(statusCode: e.statusCode);
      if (e is String) serverMessage = e;

      message = e.toString();
    }

    final HTTPErrorEnum resultError = error ?? HTTPErrorEnum.unknown;

    if (showError) {
      showSnackBar(
        title: 'Error',
        message:
            serverMessage.isNotEmpty ? serverMessage : resultError.errorMessage,
        type: SnackBarType.error,
      );
    }

    devPrint(
      '''Error:\t${resultError.errorMessage}(${resultError.errorCode})
Data:\t$message''',
      heading: 'HttpErrorHandler',
      color: DevPrintColorEnum.red,
    );

    if (resultError == HTTPErrorEnum.unauthorized) {
      //! Logging out the user
      AuthController.find.user.value = null;
    }

    return resultError;
  }

  HTTPErrorEnum? _getErrorType({
    int? statusCode,
    dio.DioException? dioException,
  }) {
    HTTPErrorEnum? dio = __getDioException(dioException);
    if (dio != null) return dio;

    if (statusCode == null) return null;
    for (final HTTPErrorEnum error in HTTPErrorEnum.values) {
      if (error.errorCode == statusCode) {
        return error;
      }
    }
    return null;
  }

  HTTPErrorEnum? __getDioException(dio.DioException? e) {
    // DioException
    if (e == null) return null;

    if (e.type == dio.DioExceptionType.connectionError) {
      return HTTPErrorEnum.socketException;
    }

    return null;
  }
}
