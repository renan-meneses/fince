import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/authenticate_with_biometrics.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import 'auth_state.dart';

/// Coordinates the auth session state.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required Login login,
    required Register register,
    required Logout logout,
    required ForgotPassword forgotPassword,
    required GetCurrentUser getCurrentUser,
    required AuthenticateWithBiometrics authenticateWithBiometrics,
  })  : _login = login,
        _register = register,
        _logout = logout,
        _forgotPassword = forgotPassword,
        _getCurrentUser = getCurrentUser,
        _authenticateWithBiometrics = authenticateWithBiometrics,
        super(const AuthState.initial());

  final Login _login;
  final Register _register;
  final Logout _logout;
  final ForgotPassword _forgotPassword;
  final GetCurrentUser _getCurrentUser;
  final AuthenticateWithBiometrics _authenticateWithBiometrics;

  bool get isAuthenticated => state is AuthAuthenticated;

  /// Bumped on every state change so the router can re-evaluate redirects.
  final ValueNotifier<int> sessionRevision = ValueNotifier(0);

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    sessionRevision.value++;
  }

  /// Restores any persisted session at startup.
  Future<void> init() async {
    try {
      final user = await _getCurrentUser();
      emit(
        user == null
            ? const AuthState.unauthenticated()
            : AuthState.authenticated(user),
      );
    } on Failure catch (failure) {
      emit(AuthState.failure(failure));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    try {
      final user = await _login(email: email, password: password);
      emit(AuthState.authenticated(user));
    } on Failure catch (failure) {
      emit(AuthState.failure(failure));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    try {
      final user = await _register(name: name, email: email, password: password);
      emit(AuthState.authenticated(user));
    } on Failure catch (failure) {
      emit(AuthState.failure(failure));
    }
  }

  Future<void> logout() async {
    await _logout();
    emit(const AuthState.unauthenticated());
  }

  Future<void> forgotPassword(String email) async {
    emit(const AuthState.loading());
    try {
      await _forgotPassword(email);
      emit(const AuthState.unauthenticated());
    } on Failure catch (failure) {
      emit(AuthState.failure(failure));
    }
  }

  Future<bool> authenticateWithBiometrics() =>
      _authenticateWithBiometrics();

  void clearFailure() => emit(const AuthState.unauthenticated());
}
