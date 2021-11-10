import 'package:anxiety_app/bloc/login/login_cubit.dart';
import 'package:anxiety_app/bloc/login/login_state.dart';
import 'package:anxiety_app/pages/home_page.dart';
import 'package:anxiety_app/pages/login_sign_up/sign_up_page.dart';
import 'package:anxiety_app/widgets/teddy/teddy_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage() : super();

  static PageRoute<dynamic> route() => MaterialPageRoute(
        builder: (context) => LoginPage(),
      );

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LoginCubit get cubit => context.read<LoginCubit>();

  String _animationType = 'idle';
  bool isSignUp = false;

  final _teddyController = TeddyController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  String? _emailErrorText;
  String? _passwordErrorText;

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
    return BlocConsumer<LoginCubit, LoginState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, LoginState state) {
    if (state.userdId != null) {
      _teddyController.play('success');
      Future.delayed(Duration(seconds: 2)).whenComplete(
        () => Navigator.of(context).pushReplacement(HomePage.route(
          userId: state.userdId,
        )),
      );
    } else if (state.errorType == LoginError.invalidEmail) {
      _teddyController.play('fail');
      ScaffoldMessenger.of(context)
          .showSnackBar(_snackBar('O email informado não está cadastrado!'));
    } else if (state.errorType == LoginError.invalidPassword) {
      _teddyController.play('fail');
      ScaffoldMessenger.of(context).showSnackBar(_snackBar('Senha incorreta!'));
    } else if (state.errorType == LoginError.userNotFound) {
      _teddyController.play('fail');
      ScaffoldMessenger.of(context).showSnackBar(
        _snackBar('O login informado não está cadastrado!'),
      );
    }
  }

  Widget _builder(BuildContext context, LoginState state) {
    _makeErrorTexts(state);
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue[100],
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _makeTeddyAnimation(),
                _makeTextFields(),
                _makeLoginButton(state),
                _makeSignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _makeErrorTexts(LoginState state) {
    if (state.errorType == LoginError.emptyEmail) {
      _emailErrorText = 'Ops! Parece que você esqueceu de inserir o email';
    } else {
      _emailErrorText = null;
    }

    if (state.errorType == LoginError.emptyPassword) {
      _passwordErrorText = 'Ops! Parece que você esqueceu de inserir a senha';
    } else {
      _passwordErrorText = null;
    }
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
                  controller: _teddyController,
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

  Form _makeTextFields() => Form(
        child: Padding(
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
                    decoration: InputDecoration(
                      hintText: 'seu.email@gmail.com',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      errorText: _emailErrorText,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    focusNode: _emailNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'senha',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      errorText: _passwordErrorText,
                    ),
                    controller: _passwordController,
                    focusNode: _passwordNode,
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Container _makeLoginButton(LoginState state) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            _emailNode.unfocus();
            _passwordNode.unfocus();
            cubit.valiadeUserCredentials(
              email: _emailController.text,
              password: _passwordController.text,
            );
          },
          child: state.isLoading
              ? SpinKitThreeBounce(
                  size: 25.0,
                  color: Colors.white,
                )
              : Text('LOGAR'),
        ),
      );

  GestureDetector _makeSignUpText() => GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(SignUpPage.route());
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: RichText(
            text: TextSpan(
              text: 'Ainda não tem um login ? ',
              style: TextStyle(color: Colors.blue),
              children: [
                TextSpan(
                  text: 'Registre-se agora!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  SnackBar _snackBar(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      elevation: 2.0,
    );
  }
}
