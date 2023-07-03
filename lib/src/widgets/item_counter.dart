import 'package:flutter/material.dart';

class ItemCounter extends StatelessWidget {
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  const ItemCounter({
    super.key,
    this.onMinus,
    this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: const EdgeInsets.only(bottom: 10),
          icon: const Icon(Icons.minimize_outlined),
          onPressed: onMinus,
        ),
        IconButton(
          icon: const Icon(Icons.add_outlined),
          onPressed: onPlus,
        ),
      ],
    );
  }
}
