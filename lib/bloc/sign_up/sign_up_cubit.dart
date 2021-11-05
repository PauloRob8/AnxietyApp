import 'package:anxiety_app/bloc/sign_up/sign_up_state.dart';
import 'package:anxiety_app/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    AuthService? authService,
  })  : _authService = authService ?? AuthService(),
        super(SignUpState.initial());

  final AuthService _authService;

  Future<void> onSignUp({
    required String email,
    required String password,
  }) async {
    emit(SignUpState.loading());
    try {
      final user = await _authService.registerUser(email, password);

      emit(SignUpState.success(userId: user.user!.uid));
    } on Exception catch (error) {
      _onError(error);
    }
  }

  void _onError(dynamic error) {
    print(error);
  }
}
