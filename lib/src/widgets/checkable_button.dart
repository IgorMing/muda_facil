import 'package:flutter/material.dart';

class CheckableButton extends StatelessWidget {
  const CheckableButton({super.key, required this.title, this.checked});

  final String title;
  final bool? checked;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(width: 5),
          if (checked == true) const Icon(Icons.check, color: Colors.green),
        ],
      ),
    );
  }
}
