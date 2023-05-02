import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {super.key});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding * 2),
          child: Text('Ops, um erro ocorreu\n. Erro: $error'),
        ),
      ),
    );
  }
}
