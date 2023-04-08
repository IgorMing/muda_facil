import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class OrderDeclined extends StatelessWidget {
  const OrderDeclined({
    super.key,
    required this.reason,
  });

  final String reason;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Orçamento recusado.\n\n',
              style: textStyle,
            ),
            TextSpan(
                text: 'Motivo: ',
                style: textStyle.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(
              text: reason,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
