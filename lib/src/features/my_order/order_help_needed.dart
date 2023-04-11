import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class OrderHelpNeeded extends StatelessWidget {
  const OrderHelpNeeded({super.key, required this.helpText});

  final String helpText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding * 1.5),
      child: RichText(
        text: TextSpan(
          text: 'Ajuda solicitada: ',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: helpText,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
