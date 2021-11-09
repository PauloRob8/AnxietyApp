enum LoginError {
  none,
  emptyEmail,
  emptyPassword,
  invalidPassword,
  invalidEmail,
  userNotFound,
}

class LoginState {
  LoginState({
    required this.isLoading,
    required this.userdId,
    required this.errorType,
  });

  final bool isLoading;
  final String? userdId;
  final LoginError errorType;

  factory LoginState.initial() => LoginState(
        isLoading: false,
        userdId: null,
        errorType: LoginError.none,
      );

  factory LoginState.loading() => LoginState(
        isLoading: true,
        userdId: null,
        errorType: LoginError.none,
      );

  factory LoginState.success({
    required String userId,
  }) =>
      LoginState(
        isLoading: false,
        userdId: userId,
        errorType: LoginError.none,
      );

  factory LoginState.error({
    required LoginError errorType,
  }) =>
      LoginState(
        isLoading: false,
        userdId: null,
        errorType: errorType,
      );
}
