import 'package:flutter/material.dart';

class UIUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

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
