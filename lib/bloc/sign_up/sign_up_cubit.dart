import 'package:anxiety_app/bloc/sign_up/sign_up_state.dart';
import 'package:anxiety_app/network/hasura_connector.dart';
import 'package:anxiety_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    AuthService? authService,
    HasuraConnector? connector,
  })  : _authService = authService ?? AuthService(),
        _connector = connector ?? HasuraConnector(),
        super(SignUpState.initial());

  final AuthService _authService;
  final HasuraConnector _connector;

  void onValidateFields({
    required String email,
    required String confirmEmail,
    required String password,
  }) {
    if (email.isEmpty) {
      emit(SignUpState.error(errorType: SignUpError.emptyEmail));
    } else if (confirmEmail.isEmpty) {
      emit(SignUpState.error(errorType: SignUpError.emptyConfirmEmail));
    } else if (password.isEmpty) {
      emit(SignUpState.error(errorType: SignUpError.emptyPassword));
    } else if (email != confirmEmail) {
      emit(SignUpState.error(errorType: SignUpError.fieldsDoestMatch));
    } else {
      onSignUp(email: confirmEmail, password: password);
    }
  }

  Future<void> onSignUp({
    required String email,
    required String password,
  }) async {
    emit(SignUpState.loading());
    try {
      final user = await _authService.registerUser(email, password);

      await _connector.addUserToDatabase(
        email: user.user!.email,
        userId: user.user!.uid,
      );

      emit(SignUpState.success(userId: user.user!.uid));
    } on FirebaseAuthException catch (error) {
      _onError(error);
    }
  }

  void _onError(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        emit(SignUpState.error(errorType: SignUpError.emailInUse));
        break;
      case 'invalid-email':
        emit(SignUpState.error(errorType: SignUpError.invalidEmail));
        break;
      case 'weak-password':
        emit(SignUpState.error(errorType: SignUpError.weakPassword));
        break;
      default:
    }
  }
}
