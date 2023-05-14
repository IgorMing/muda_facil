import 'package:flutter/material.dart';
import 'package:muda_facil/src/app.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/dialogs.dart';

class UIUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static bool isDarkmode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  static void showSnackBar(BuildContext context, String text,
      {bool success = false}) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor:
          success ? kSuccessColor : Theme.of(context).colorScheme.error,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showAlertDialog(
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

  static void showLoaderDialog(BuildContext context, Function? action) {
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
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
        if (action != null) action();
      },
    );
  }

  static void showInputDialog(
    BuildContext context, {
    required Function(String text) onSave,
    required String title,
    String? initialText = '',
    String cancelButtonText = 'Cancelar',
    String confirmButtonText = 'Salvar',
    bool requireMinLength = false,
    int minLength = 10,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialogs.getSingleInputDialog(
        context,
        title: title,
        requireMinLength: requireMinLength,
        minLength: minLength,
        initialText: initialText,
        onSave: onSave,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
      ),
    );
  }

  static Future<void> showInfoDialog(
    BuildContext context, {
    required String title,
    required List<String> body,
    String confirmationText = 'Ok',
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: body.map((e) => Text(e)).toList(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(confirmationText))
        ],
      ),
    );
  }
}
