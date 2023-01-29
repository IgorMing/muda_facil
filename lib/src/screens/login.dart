import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/app.dart';
import 'package:muda_facil/src/utils/string_api.dart';
import 'package:muda_facil/src/widgets/link_text.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({super.key, required this.onClickedSignUp});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'igor.ming@gmail.com';
    _passwordController.text = 'Igor1993';
    super.initState();
  }

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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

                  if (!value.isValidEmail) {
                    return 'Invalid email address';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
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
                error,
                style: const TextStyle(color: Colors.red),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signIn();
                  }
                },
                label: const Text('Sign in'),
                icon: const Icon(
                  Icons.lock_open,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              LinkText(
                onTap: widget.onClickedSignUp,
                message: 'No Account?',
                link: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
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
          error = message;
        });
      });
    } finally {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
