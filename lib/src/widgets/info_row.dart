import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    this.value,
  });

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
      ),
      child: RichText(
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          text: '$label:',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: " $value",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
