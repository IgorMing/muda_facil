import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class IconRow extends StatelessWidget {
  const IconRow({
    super.key,
    required this.text,
    required this.iconData,
    this.highlightedText = false,
  });

  final String text;
  final IconData iconData;
  final bool highlightedText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          width: kDefaultPadding / 2,
        ),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: highlightedText ? Colors.black : null,
                ),
          ),
        ),
      ],
    );
  }
}
