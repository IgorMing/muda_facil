import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({super.key, required this.onClickedSignUp});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        onPress: (email, password) =>
            FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        buttonText: 'Sign in',
        linkText: LinkText(
          onTap: widget.onClickedSignUp,
          message: 'No Account?',
          link: 'Sign Up',
        ),
      ),
    );
  }
}
