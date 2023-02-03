import 'package:flutter/material.dart';

class UIUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static bool isDarkmode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static showSnackBar(BuildContext context, String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Theme.of(context).colorScheme.error,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
