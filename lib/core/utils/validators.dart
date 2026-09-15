/// Pure validation helpers returning a message on failure, `null` when valid.
/// They contain no framework dependencies and are trivially unit-testable.
String? validateRequired(String? value, [String field = 'Campo']) {
  if (value == null || value.trim().isEmpty) {
    return '$field é obrigatório.';
  }
  return null;
}

String? validateEmail(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Informe o e-mail.';
  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!emailRegex.hasMatch(v)) return 'E-mail inválido.';
  return null;
}

String? validatePassword(String? value) {
  final v = value ?? '';
  if (v.isEmpty) return 'Informe a senha.';
  if (v.length < 8) return 'A senha deve ter ao menos 8 caracteres.';
  return null;
}

String? validateAmount(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Informe o valor.';
  try {
    final minorUnits = parseMoneyInputForValidation(v);
    if (minorUnits <= 0) return 'O valor deve ser maior que zero.';
  } on Exception {
    return 'Valor inválido.';
  }
  return null;
}

/// Lightweight parse for validation (keeps `validators.dart` free of Money's
/// full API surface).
int parseMoneyInputForValidation(String input) {
  final trimmed = input.trim().replaceAll(RegExp(r'[^0-9,\-]'), '');
  final negative = trimmed.startsWith('-');
  final normalized = trimmed.replaceAll(',', '.').replaceAll('-', '');
  if (normalized.isEmpty) throw const FormatException('invalid');
  final parts = normalized.split('.');
  final major = int.parse(parts.first.isEmpty ? '0' : parts.first);
  var minor = 0;
  if (parts.length > 1) {
    final frac = parts[1].padRight(2, '0').substring(0, 2);
    minor = int.parse(frac.isEmpty ? '0' : frac);
  }
  final value = major * 100 + minor;
  return negative ? -value : value;
}
