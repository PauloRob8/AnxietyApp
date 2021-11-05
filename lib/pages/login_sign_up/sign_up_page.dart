import 'package:anxiety_app/bloc/login/login_cubit.dart';
import 'package:anxiety_app/bloc/sign_up/sign_up_cubit.dart';
import 'package:anxiety_app/bloc/sign_up/sign_up_state.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage() : super();

  static PageRoute<dynamic> route() => MaterialPageRoute(
        builder: (context) => BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
          child: SignUpPage(),
        ),
      );

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  SignUpCubit get cubit => context.read<SignUpCubit>();

  String _animationType = 'idle';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _emailConfirmController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _emailConfirmNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  void initState() {
    this._passwordNode.addListener(() {
      if (this._passwordNode.hasFocus) {
        setState(() {
          this._animationType = 'hands_up';
        });
      } else {
        setState(() {
          this._animationType = 'hands_down';
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, SignUpState state) {}

  Widget _builder(BuildContext context, SignUpState state) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue[100],
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _makeTeddyAnimation(),
                _makeTextSignUpFields(),
                _makeLoginButton(),
                _makeBackButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _makeTeddyAnimation() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25.0,
          horizontal: 10.0,
        ),
        child: Container(
          height: 300.0,
          width: 300.0,
          child: CircleAvatar(
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlareActor(
                  'assets/Teddy.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: this._animationType,
                  callback: (currentAnimation) {
                    setState(() {
                      this._animationType = 'test';
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      );

  Padding _makeTextSignUpFields() => Padding(
        padding: const EdgeInsets.only(
          right: 15.0,
          left: 15.0,
          bottom: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2.0,
              color: Colors.white,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'digite seu email'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  focusNode: _emailNode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'confirme seu email'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailConfirmController,
                  focusNode: _emailConfirmNode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: 'senha'),
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
      );

  Container _makeLoginButton() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () => cubit.onSignUp(
            email: _emailConfirmController.text,
            password: _passwordController.text,
          ),
          child: Text(
            'REGISTRAR',
          ),
        ),
      );

  Container _makeBackButton() => Container(
        padding: const EdgeInsets.only(
          right: 25.0,
          left: 25.0,
          bottom: 20.0,
        ),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'VOLTAR',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      );
}
