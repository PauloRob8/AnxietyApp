enum SignUpError {
  none,
}

class SignUpState {
  SignUpState({
    this.isLoading,
    this.userdId,
    this.errorType,
  });

  final bool? isLoading;
  final String? userdId;
  final SignUpError? errorType;

  factory SignUpState.initial() => SignUpState(
        isLoading: false,
        userdId: null,
        errorType: SignUpError.none,
      );

  factory SignUpState.loading() => SignUpState(
        isLoading: false,
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
