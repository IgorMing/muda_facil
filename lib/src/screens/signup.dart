import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignupScreen({super.key, required this.onClickedSignIn});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        onPress: (email, password) =>
            FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        buttonText: 'Sign up',
        linkText: LinkText(
          onTap: widget.onClickedSignIn,
          message: 'Already have an account?',
          link: 'Sign In',
        ),
      ),
    );
  }
}
