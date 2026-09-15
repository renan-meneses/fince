import 'failure.dart';

/// Produces user-friendly, localized-lean messages for failures.
///
/// Messages are kept free of secrets and technical details (no stack traces,
/// no tokens, no raw account data). Full localization can be layered on later
/// by keying off [Failure.code] instead of the message literals here.
String userMessageFor(Object error) {
  return switch (error) {
    NetworkFailure() =>
      'Sem conexão com a internet. Tente novamente em instantes.',
    AuthenticationFailure() => 'Sessão expirada. Entre novamente.',
    ValidationFailure(:final message) => message ?? 'Dados inválidos.',
    DatabaseFailure() =>
      'Não foi possível acessar os dados locais. Tente novamente.',
    UnknownFailure() => 'Algo deu errado. Tente novamente.',
    _ => 'Algo deu errado. Tente novamente.',
  };
}
