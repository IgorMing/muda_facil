import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/layouts/auth_layout.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({super.key, required this.onClickedSignUp});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final AppUser notifier;

  @override
  void initState() {
    notifier = ref.read(appUserProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        title: 'Login',
        hasForgotPassButton: true,
        onPress: (email, password) async {
          await notifier.signIn(email, password);
        },
        buttonText: 'Entrar',
        extra: Column(
          children: [
            LinkText(
              onTap: widget.onClickedSignUp,
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
