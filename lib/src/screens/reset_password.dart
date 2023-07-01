import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthLayout(
        title: 'Redefinir senha',
        onPress: (email, _) =>
            ref.read(appUserProvider.notifier).resetPassword(email),
        buttonText: 'Reset',
        hidePasswordField: true,
        hasSuccessSnackbar: true,
      ),
    );
  }
}
