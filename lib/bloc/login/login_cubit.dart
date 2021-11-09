import 'package:anxiety_app/bloc/login/login_state.dart';
import 'package:anxiety_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    AuthService? authService,
  })  : _authService = authService ?? AuthService(),
        super(LoginState.initial());

  final AuthService _authService;
  String? userId;

  void valiadeUserCredentials({
    required String email,
    required String password,
  }) {
    if (email.isEmpty) {
      emit(
        LoginState.error(errorType: LoginError.emptyEmail),
      );
    } else if (password.isEmpty) {
      emit(
        LoginState.error(errorType: LoginError.emptyPassword),
      );
    } else {
      _onLogin(
        email: email,
        password: password,
      );
    }
  }

  Future<void> _onLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginState.loading());
    try {
      final user = await _authService.loginUser(email, password);

      userId = user.user!.uid;

      emit(LoginState.success(userId: user.user!.uid));
    } on FirebaseAuthException catch (error) {
      _onError(error);
    }
  }

  void _onError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        emit(LoginState.error(errorType: LoginError.invalidEmail));
        break;
      case 'wrong-password':
        emit(LoginState.error(errorType: LoginError.invalidPassword));
        break;
      case 'user-not-found':
        emit(LoginState.error(errorType: LoginError.userNotFound));
        break;
      default:
    }
  }
}
