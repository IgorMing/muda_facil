import 'package:flutter/material.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/services/auth.dart';
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
        title: 'Create your account',
        onPress: (String email, String password) =>
            AuthService.signUpByEmailAndPassword(email, password),
        buttonText: 'Create account',
        extra: LinkText(
          onTap: widget.onClickedSignIn,
          message: 'Already have an account?',
          link: 'Sign In',
        ),
      ),
    );
  }
}
