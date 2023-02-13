import 'package:flutter/material.dart';

class ItemCounter extends StatelessWidget {
  final int amount;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  const ItemCounter(this.amount, {super.key, this.onMinus, this.onPlus});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.minimize_outlined),
            onPressed: onMinus,
          ),
          Text(amount.toString()),
          IconButton(
            icon: const Icon(Icons.add_outlined),
            onPressed: onPlus,
          ),
        ],
      ),
    );
  }
}
