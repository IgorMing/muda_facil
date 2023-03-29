import 'package:flutter/material.dart';

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
    Function? onSelect,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tem certeza?'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              onSelect!(false);
              Navigator.of(context).pop();
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              onSelect!(true);
              Navigator.of(context).pop();
            },
            child: const Text('Sim'),
          ),
        ],
      ),
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
