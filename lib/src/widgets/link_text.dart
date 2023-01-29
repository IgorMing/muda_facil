import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final VoidCallback onTap;
  final String message;
  final String link;

  const LinkText(
      {super.key,
      required this.onTap,
      required this.message,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: ' $link',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    );
  }
}
