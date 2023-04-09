import 'package:flutter/material.dart';
import 'package:muda_facil/src/app.dart';
import 'package:muda_facil/src/utils/constants.dart';

class UIUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static bool isDarkmode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static showSnackBar(BuildContext context, String text,
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

  static showLoaderDialog(BuildContext context, Function? action) {
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
    required Function(String text) onSave,
    required String title,
    String? initialText = '',
    String cancelButtonText = 'Cancelar',
    String confirmButtonText = 'Salvar',
    bool requireMinLength = false,
    int minLength = 10,
  }) {
    final controller = TextEditingController(text: initialText);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: TextFormField(
            validator: (value) {
              if (!requireMinLength) {
                return null;
              }

              if (value == null || value.length < minLength) {
                return 'Digite ao menos $minLength caracteres';
              }

              return null;
            },
            controller: controller,
            autofocus: true,
            autocorrect: false,
            textCapitalization: TextCapitalization.sentences,
            onSaved: (newValue) {
              onSave(controller.text);
              Navigator.of(context).pop();
            },
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(),
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelButtonText),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              }
            },
            child: Text(confirmButtonText),
          ),
        ],
      ),
    );
  }
}
