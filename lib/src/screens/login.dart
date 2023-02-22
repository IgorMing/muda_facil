import 'package:flutter/material.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/screens/reset_password.dart';
import 'package:muda_facil/src/services/auth.dart';
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
        title: 'Log in',
        onPress: (email, password) =>
            AuthService.signInByEmailAndPassword(email, password),
        buttonText: 'Log in',
        extra: Column(
          children: [
            LinkText(
              onTap: widget.onClickedSignUp,
              message: 'No Account?',
              link: 'Sign Up',
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot your password?',
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
