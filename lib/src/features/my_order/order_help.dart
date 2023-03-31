import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/ui.dart';

class OrderHelp extends StatelessWidget {
  const OrderHelp({
    super.key,
    required this.onSave,
  });

  final Function(String value) onSave;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        UIUtils.showInputDialog(
          context,
          confirmButtonText: 'Enviar',
          onSave: onSave,
          title: 'Em que podemos lhe ajudar?',
        );
      },
      child: const Text('Precisa de ajuda? Clique aqui'),
    );
  }
}
