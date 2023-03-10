import 'package:flutter/material.dart';

class CheckableButton extends StatelessWidget {
  const CheckableButton({super.key, required this.title, this.checked});

  final String title;
  final bool? checked;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: checked == true
                ? Colors.green
                : Theme.of(context).colorScheme.primary),
      ),
      onPressed: () {},
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
          if (checked == true) const Icon(Icons.check, color: Colors.green),
        ],
      ),
    );
  }
}
