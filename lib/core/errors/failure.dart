/// Domain-level failures.
///
/// Infrastructure exceptions are mapped into these (see [mapExceptionToFailure])
/// so that the domain and presentation layers never depend on concrete
/// exceptions thrown by Dio, sqlite3, or the framework.
sealed class Failure implements Exception {
  const Failure({this.message, this.code});

  /// Optional human-readable context (never contains secrets).
  final String? message;

  /// Optional stable machine code for the failure kind.
  final String? code;

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.code});
}

final class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message, super.code});
}

final class ValidationFailure extends Failure {
  const ValidationFailure({super.message, super.code, this.fieldErrors});

  /// Field-level validation errors, e.g. `{"email": "invalid format"}`.
  final Map<String, String>? fieldErrors;
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message, super.code});
}

final class UnknownFailure extends Failure {
  const UnknownFailure({super.message, super.code});
}
