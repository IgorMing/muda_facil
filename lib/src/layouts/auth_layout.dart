import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/string_api.dart';
import 'package:muda_facil/src/utils/ui.dart';

class AuthLayout extends StatefulWidget {
  final Function onPress;
  final String buttonText;
  final Widget? extra;
  final bool? hidePasswordField;
  final bool? hasSuccessSnackbar;

  const AuthLayout({
    super.key,
    required this.onPress,
    required this.buttonText,
    this.extra,
    this.hidePasswordField,
    this.hasSuccessSnackbar,
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            UIUtils.of(context).isDarkmode()
                ? Colors.blueGrey
                : Theme.of(context).colorScheme.primary,
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding * 4),
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
                    return 'The email is empty';
                  }

                  if (!EmailValidator.validate(value)) {
                    return 'Invalid email address';
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
                    labelText: 'Password',
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
                      return 'The password is empty';
                    }

                    if (!value.isValidPassword) {
                      return 'The password must have at least 6 characters';
                    }

                    return null;
                  },
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
    );
  }

  Future onPressButton() async {
    bool hasError = false;

    UIUtils.of(context).showLoaderDialog(() async {
      try {
        if (_formKey.currentState!.validate()) {
          await widget.onPress(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
        }
      } on FirebaseAuthException catch (err) {
        hasError = true;
        UIUtils.of(context).showSnackBar(err.message ?? kDefaultErrorMessage);
      } finally {
        if (widget.hasSuccessSnackbar == true && !hasError) {
          UIUtils.of(context).showSnackBar(
            'Um email foi enviado para resetar sua senha',
            success: true,
          );
        }
      }
    });
  }
}
