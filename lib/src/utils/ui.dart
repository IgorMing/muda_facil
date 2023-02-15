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

  static showAlertDialog(BuildContext context, {Function? onSelect}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tem certeza?'),
        content: const Text('O item sairá de sua lista'),
        actions: [
          TextButton(
            onPressed: () {
              onSelect!(false);
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              onSelect!(true);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
