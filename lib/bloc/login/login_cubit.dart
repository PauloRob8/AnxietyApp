import 'package:anxiety_app/bloc/login/login_state.dart';
import 'package:anxiety_app/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    AuthService? authService,
  })  : _authService = authService ?? AuthService(),
        super(LoginState.initial());

  final AuthService _authService;

  Future<void> onLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginState.loading());
    try {
      final user = await _authService.loginUser(email, password);

      emit(LoginState.success(userId: user.user!.uid));
    } on Exception catch (error) {
      _onError(error);
    }
  }

  void _onError(dynamic error) {
    print(error);
  }
}
