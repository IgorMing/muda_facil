import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/utils/ui.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthLayout(
        hasLogo: false,
        title: 'Redefinir senha',
        onPress: (email, _) {
          ref.read(appUserProvider.notifier).resetPassword(email);

          UIUtils.of(context).showSnackBar(
            'Um email foi enviado para resetar sua senha',
            success: true,
          );
        },
        buttonText: 'Redefinir',
        hidePasswordField: true,
        hasSuccessSnackbar: true,
      ),
    );
  }
}
