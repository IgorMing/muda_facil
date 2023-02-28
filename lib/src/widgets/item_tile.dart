import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/item_counter.dart';

class ItemTile extends StatelessWidget {
  final Item data;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;
  final VoidCallback? onRemove;
  final Function? onAddComment;

  const ItemTile({
    super.key,
    required this.data,
    this.onMinus,
    this.onPlus,
    this.onRemove,
    this.onAddComment,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              UIUtils.showInputDialog(
                context,
                onSave: (text) {
                  onAddComment!(text);
                },
                initialText: data.comment,
              );
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
        child: ExpansionTile(
          key: GlobalKey(),
          // contentPadding: const EdgeInsets.all(4.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${data.name} ( ${data.amount} )"),
              ItemCounter(
                onMinus: onMinus,
                onPlus: onPlus,
              )
            ],
          ),
          subtitle: data.comment != null && data.comment!.isNotEmpty
              ? Text(data.comment ?? '')
              : null,
          children: [
            ListTile(
              title: const Text('Adicionar observação'),
              onTap: () {
                UIUtils.showInputDialog(
                  context,
                  onSave: (text) {
                    onAddComment!(text);
                  },
                  initialText: data.comment,
                );
              },
            ),
            ListTile(
              onTap: () {
                UIUtils.showAlertDialog(context, onSelect: (selected) {
                  if (selected) {
                    onRemove!();
                  }
                });
              },
              title: Text(
                'Remover item',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
