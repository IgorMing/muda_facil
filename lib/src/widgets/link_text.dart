import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/ui.dart';

class LinkText extends StatelessWidget {
  final VoidCallback onTap;
  final String message;
  final String link;

  const LinkText({
    super.key,
    required this.onTap,
    required this.message,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: message,
        style: Theme.of(context).textTheme.bodyMedium!,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: ' $link',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: UIUtils.of(context).isDarkmode()
                      ? null
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
          ),
        ],
      ),
    );
  }
}
