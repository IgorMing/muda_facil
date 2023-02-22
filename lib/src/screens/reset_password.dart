import 'package:flutter/material.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/services/auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthLayout(
        title: 'Reset your password',
        onPress: (email, _) => AuthService.resetPasswordByEmail(email),
        buttonText: 'Reset',
        hidePasswordField: true,
        hasSuccessSnackbar: true,
      ),
    );
  }
}
