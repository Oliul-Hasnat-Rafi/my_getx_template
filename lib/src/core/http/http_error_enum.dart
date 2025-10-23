// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, sort_constructors_first

/// HTTP Error enum
enum HTTPErrorEnum {
  //! ------------------------------------------------------ Success or no error
  done(
    errorMessage: 'Operation completed.',
    errorCode: 200,
  ),

  //! ------------------------------------------------------- Client-side errors
  badRequest(
    errorMessage: 'Invalid request. Check your input.',
    errorCode: 400,
  ),
  unauthorized(
    errorMessage: 'Unauthorized. Login required.',
    errorCode: 401,
  ),
  forbidden(
    errorMessage: 'Access denied.',
    errorCode: 403,
  ),
  notFound(
    errorMessage: 'Resource not found.',
    errorCode: 404,
  ),
  methodNotAllowed(
    errorMessage: 'Method not allowed.',
    errorCode: 405,
  ),
  requestTimeOut(
    errorMessage: 'Request timed out.',
    errorCode: 408,
  ),
  conflict(
    errorMessage: 'Resource conflict.',
    errorCode: 409,
  ),

  //! ------------------------------------------------------- Server-side errors
  internalServerError(
    errorMessage: 'Server error. Try later.',
    errorCode: 500,
  ),
  notImplemented(
    errorMessage: 'Feature not available.',
    errorCode: 501,
  ),
  badGateway(
    errorMessage: 'Bad gateway response.',
    errorCode: 502,
  ),
  serviceUnavailable(
    errorMessage: 'Service unavailable.',
    errorCode: 503,
  ),
  gatewayTimeout(
    errorMessage: 'Gateway timeout. Try later.',
    errorCode: 504,
  ),

  //! --------------------------------------------- Connection or network errors
  socketException(
    errorMessage: 'No internet connection.',
  ),
  connectionReset(
    errorMessage: 'Connection was reset.',
  ),
  dnsLookupFailed(
    errorMessage: 'DNS lookup failed.',
  ),

  //! ------------------------------------------- Custom or uncategorized errors
  unknown(
    errorMessage: 'Unknown error occurred.',
  ),
  parseError(
    errorMessage: 'Response parsing failed.',
  ),
  apiLimitExceeded(
    errorMessage: 'API limit exceeded. Try later.',
    errorCode: 429,
  ),
  dataCorruption(
    errorMessage: 'Received data corrupted.',
  ),
  unsupportedMediaType(
    errorMessage: 'Content type not supported.',
    errorCode: 415,
  ),
  preconditionFailed(
    errorMessage: 'Precondition failed.',
    errorCode: 412,
  ),
  ;

  final String errorMessage;
  final int? errorCode;

  /// HTTP error enum initializer
  const HTTPErrorEnum({required this.errorMessage, this.errorCode});
}
