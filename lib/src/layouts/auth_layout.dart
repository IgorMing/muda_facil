import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/app.dart';
import 'package:muda_facil/src/utils/string_api.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class AuthLayout extends StatefulWidget {
  final Function onPress;
  final String buttonText;
  final LinkText? linkText;
  final String title;

  const AuthLayout({
    super.key,
    required this.title,
    required this.onPress,
    required this.buttonText,
    this.linkText,
  });

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String _error;
  late bool _visiblePassword;

  @override
  void initState() {
    _emailController.text = 'igor.ming@gmail.com';
    _passwordController.text = 'Igor1993';
    _error = '';
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
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Colors.white70,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
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
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
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
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    _error,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
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
                  const SizedBox(
                    height: 12,
                  ),
                  widget.linkText!
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future onPressButton() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      if (_formKey.currentState!.validate()) {
        await widget.onPress(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (err) {
      setState(() {
        final String message;
        switch (err.code) {
          case 'user-not-found':
          case 'wrong-password':
            message = 'Email and/or password must be wrong';
            break;
          default:
            message = 'Unexpected error';
        }

        setState(() {
          _error = message;
        });
      });
    } finally {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
