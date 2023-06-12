import 'package:firebase_analytics/firebase_analytics.dart';
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
    return Center(
      child: TextButton(
        onPressed: () {
          FirebaseAnalytics.instance.logEvent(name: 'needs_help');
          UIUtils.of(context).showInputDialog(
            confirmButtonText: 'Enviar',
            onSave: onSave,
            title: 'Em que podemos lhe ajudar?',
          );
        },
        child: const Text('Precisa de ajuda? Clique aqui'),
      ),
    );
  }
}
