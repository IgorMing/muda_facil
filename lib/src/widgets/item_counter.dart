import 'package:flutter/material.dart';

class ItemCounter extends StatelessWidget {
  final int? amount;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  const ItemCounter({
    super.key,
    this.onMinus,
    this.onPlus,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: const EdgeInsets.only(bottom: 10),
          icon: const Icon(Icons.minimize_outlined),
          onPressed: onMinus,
        ),
        Visibility(
          visible: amount != null,
          child: Text(amount.toString()),
        ),
        IconButton(
          icon: const Icon(Icons.add_outlined),
          onPressed: onPlus,
        ),
      ],
    );
  }
}
