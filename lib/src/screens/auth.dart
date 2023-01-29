import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/login.dart';
import 'package:muda_facil/src/screens/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginScreen(onClickedSignUp: toggle)
        : SignupScreen(onClickedSignIn: toggle);
  }

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
