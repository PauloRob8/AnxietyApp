import 'package:anxiety_app/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(initialState) : super(initialState);

  void onLogin({
    @required String? email,
    @required String? password,
  }) {}
}
