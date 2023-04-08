import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class CheckableButton extends StatelessWidget {
  const CheckableButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.checked,
  });

  final String title;
  final bool? checked;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: checked == true
                ? kSuccessColor
                : Theme.of(context).colorScheme.primary),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: TextStyle(
                color: checked == true
                    ? Colors.green[800]
                    : Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 5),
          if (checked == true) const Icon(Icons.check, color: kSuccessColor),
        ],
      ),
    );
  }
}
