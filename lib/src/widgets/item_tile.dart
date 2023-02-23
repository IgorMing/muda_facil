import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/widgets/item_counter.dart';

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
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              // TODO: open menu to add an observation
            },
            icon: Icons.details,
            label: "Observação",
            backgroundColor: Colors.yellow.shade800,
            foregroundColor: Colors.white,
          ),
        ],
      ),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          title: Text("${data.name} ( ${data.amount} )"),
          trailing: ItemCounter(
            onMinus: onMinus,
            onPlus: onPlus,
          ),
        ),
      ),
    );
  }
}
