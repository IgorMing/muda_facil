import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/string_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (err) {
      setState(() {
        FirebaseAuthException fbErr = err as FirebaseAuthException;
        final String message;
        switch (fbErr.code) {
          case 'wrong-password':
          case 'user-not-found':
            message = 'Email and/or password must be wrong';
            break;
          default:
            message = 'Unexpected error';
        }

        setState(() {
          error = message;
        });
      });
    }
  }
}
