import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/controllers/app_user.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class SignupScreen extends ConsumerWidget {
  final Function() onClickedSignIn;

  const SignupScreen({super.key, required this.onClickedSignIn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AuthLayout(
        title: 'Criar conta',
        onPress: (String email, String password) =>
            ref.read(appUserProvider.notifier).signUp(email, password),
        buttonText: 'Criar conta',
        extra: LinkText(
          onTap: onClickedSignIn,
          message: 'Já tem uma conta?',
          link: 'Entre',
        ),
      ),
    );
  }
}
