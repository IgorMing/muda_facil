import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/reset_password.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/string_api.dart';
import 'package:muda_facil/src/utils/ui.dart';

class AuthLayout extends StatefulWidget {
  final Function onPress;
  final String buttonText;
  final String title;
  final Widget? extra;
  final bool? hidePasswordField;
  final bool? hasSuccessSnackbar;
  final bool hasLogo;
  final bool hasForgotPassButton;

  const AuthLayout({
    super.key,
    required this.onPress,
    required this.buttonText,
    this.extra,
    this.hidePasswordField,
    this.hasSuccessSnackbar,
    this.hasForgotPassButton = false,
    required this.title,
    this.hasLogo = true,
  });

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late bool _visiblePassword;

  @override
  void initState() {
    _emailController.text = kDebugMode ? 'igor.ming@gmail.com' : '';
    _passwordController.text = kDebugMode ? 'Igor1993' : '';
    _visiblePassword = false;

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double radius = 30.0;

    return Stack(
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            image: widget.hasLogo
                ? const DecorationImage(
                    image: AssetImage('assets/icon.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 1.5,
              vertical: kDefaultPadding,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              color: Colors.white,
            ),
            width: size.width,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: kDefaultPadding * 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: kPrimaryColor)),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  TextFormField(
                    controller: _emailController,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'O email está vazio';
                      }

                      if (!EmailValidator.validate(value)) {
                        return 'Email inválido';
                      }

                      return null;
                    },
                  ),
                  Visibility(
                    visible: !(widget.hidePasswordField == true),
                    child: TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        suffixIcon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: IconButton(
                            icon: Icon(
                              _visiblePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _visiblePassword = !_visiblePassword;
                              });
                            },
                            key: ValueKey<bool>(_visiblePassword),
                          ),
                        ),
                      ),
                      obscureText: !_visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'A senha está vazia';
                        }

                        if (!value.isValidPassword) {
                          return 'A senha tem que ter pelo menos 6 caracteres';
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 1.5),
                  Visibility(
                    visible: widget.hasForgotPassButton,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Esqueceu sua senha?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onPressButton();
                      }
                    },
                    label: Text(widget.buttonText),
                    icon: const Icon(
                      Icons.lock_open,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  widget.extra ?? const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future onPressButton() async {
    try {
      if (_formKey.currentState!.validate()) {
        await widget.onPress(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (err) {
      UIUtils.of(context).showSnackBar(err.message ?? kDefaultErrorMessage);
    } on Exception {
      UIUtils.of(context).showSnackBar(kDefaultErrorMessage);
    }
  }
}
