import 'package:flutter/material.dart';
import 'package:muda_facil/src/app.dart';

class UIUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static bool isDarkmode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static showSnackBar(BuildContext context, String? text,
      {bool success = false}) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor:
          success ? Colors.green : Theme.of(context).colorScheme.error,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showAlertDialog(
    BuildContext context, {
    required String text,
    required Function(bool v) onSelect,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tem certeza?'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              onSelect(false);
              Navigator.of(context).pop();
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onSelect(true);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  static showLoaderDialog(BuildContext context, {Function? action}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (action != null) action();
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
      },
    );
  }

  static showInputDialog(
    BuildContext context, {
    required Function onSave,
    String? initialText = '',
  }) {
    final controller = TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Observação'),
        content: TextField(
          controller: controller,
          autofocus: true,
          autocorrect: false,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(),
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
