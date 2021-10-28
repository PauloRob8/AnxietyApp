import 'package:meta/meta.dart';

abstract class LoginState {
  LoginState(
    this.isLoading,
    this.userdId,
  );

  final bool? isLoading;
  final String? userdId;
}

class LoginInitial extends LoginState {
  LoginInitial() : super(false, '');
}

class LoginLoading extends LoginState {
  LoginLoading(this.isLoading) : super(isLoading, '');

  final bool isLoading;
}
