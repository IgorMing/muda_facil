import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/controllers/auth_controller.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/screens/signup.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AuthLayout(
        title: 'Login',
        hasForgotPassButton: true,
        onPress: (email, password) async {
          await ref
              .read(authControllerProvider.notifier)
              .signInByEmailAndPassword(email, password);
        },
        buttonText: 'Entrar',
        extra: Column(
          children: [
            LinkText(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const SignupScreen(),
                ));
              },
              message: 'Não tem cadastro?',
              link: 'Crie agora',
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const ResetPasswordScreen(),
            //       ),
            //     );
            //   },
            //   child: Text(
            //     'Esqueceu sua senha?',
            //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //         decoration: TextDecoration.underline, color: kPrimaryColor),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
