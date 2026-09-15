import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Authenticated application user (domain entity).
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    String? avatarUrl,
    required String currency,
    required String locale,
    required bool isActive,
  }) = _User;
}
