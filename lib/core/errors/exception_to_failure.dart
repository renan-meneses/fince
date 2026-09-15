import 'package:dio/dio.dart';

import 'failure.dart';

/// Maps infrastructure exceptions into domain-level [Failure]s.
///
/// This is the single translation point between the data layer and the domain
/// layer. Every repository implementation should funnel caught exceptions
/// through here (or return a [Failure] it already holds).
Failure mapExceptionToFailure(Object exception, {StackTrace? stackTrace}) {
  if (exception is Failure) {
    return exception;
  }

  if (exception is DioException) {
    return _fromDioException(exception);
  }

  if (exception is FormatException) {
    return const ValidationFailure(message: 'Invalid format');
  }

  return UnknownFailure(message: exception.toString());
}

Failure _fromDioException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const NetworkFailure(code: 'timeout', message: 'Request timed out');
    case DioExceptionType.connectionError:
      return const NetworkFailure(
        code: 'connection_error',
        message: 'Network connection error',
      );
    case DioExceptionType.badResponse:
      final statusCode = exception.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        return const AuthenticationFailure(
          code: 'unauthorized',
          message: 'Session expired or invalid',
        );
      }
      if (statusCode == 422) {
        return const ValidationFailure(
          code: 'validation',
          message: 'Invalid data submitted',
        );
      }
      return UnknownFailure(
        code: 'http_$statusCode',
        message: 'Server error ($statusCode)',
      );
    case DioExceptionType.badCertificate:
      return const NetworkFailure(
        code: 'bad_certificate',
        message: 'Invalid server certificate',
      );
    case DioExceptionType.cancel:
      return const NetworkFailure(code: 'cancelled', message: 'Request cancelled');
    case DioExceptionType.unknown:
      return const UnknownFailure(code: 'unknown', message: 'Unexpected error');
  }
}
