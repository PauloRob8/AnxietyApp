import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage() : super();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String _animationType = 'idle';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _makeTeddyAnimation(),
              _makeTextFields(),
              _makeLoginButton(),
              _makeSignUpText(),
            ],
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

  Padding _makeTextFields() => Padding(
        padding: const EdgeInsets.only(
          right: 15.0,
          left: 15.0,
          bottom: 10.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
                  decoration: InputDecoration(hintText: 'seu.email@gmail.com'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  focusNode: _emailNode,
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
          onPressed: () {},
          child: Text('LOGAR'),
        ),
      );

  Padding _makeSignUpText() => Padding(
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
      );
}
