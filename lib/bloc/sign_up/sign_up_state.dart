enum SignUpError {
  none,
  emptyEmail,
  emptyConfirmEmail,
  emptyPassword,
  fieldsDoestMatch,
  invalidEmail,
  emailInUse,
  weakPassword,
}

class SignUpState {
  SignUpState({
    required this.isLoading,
    required this.userdId,
    this.errorType,
  });

  final bool isLoading;
  final String? userdId;
  final SignUpError? errorType;

  factory SignUpState.initial() => SignUpState(
        isLoading: false,
        userdId: null,
        errorType: SignUpError.none,
      );

  factory SignUpState.loading() => SignUpState(
        isLoading: true,
        userdId: null,
        errorType: SignUpError.none,
      );

  factory SignUpState.success({
    required String userId,
  }) =>
      SignUpState(
        isLoading: false,
        userdId: userId,
        errorType: SignUpError.none,
      );

  factory SignUpState.error({
    required SignUpError errorType,
  }) =>
      SignUpState(
        isLoading: false,
        userdId: null,
        errorType: errorType,
      );
}
