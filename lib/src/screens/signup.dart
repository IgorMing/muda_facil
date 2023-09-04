import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/controllers/auth_controller.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AuthLayout(
        title: 'Criar conta',
        onPress: (String email, String password) => ref
            .read(authControllerProvider.notifier)
            .signUpByEmailAndPassword(email, password),
        buttonText: 'Criar conta',
        extra: LinkText(
          onTap: () {
            Navigator.of(context).pop();
          },
          message: 'Já tem uma conta?',
          link: 'Entre',
        ),
      ),
    );
  }
}
