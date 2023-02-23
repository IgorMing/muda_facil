import 'package:flutter/material.dart';
import 'package:muda_facil/src/models/item.dart';

import 'item_counter.dart';

class ItemTile extends StatelessWidget {
  final Item data;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  const ItemTile({
    super.key,
    required this.data,
    this.onMinus,
    this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      trailing: ItemCounter(
        data.amount,
        onMinus: onMinus,
        onPlus: onPlus,
      ),
    );
  }
}
