import 'package:flutter/material.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/item_counter.dart';

class ItemTile extends StatelessWidget {
  final Item data;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onRemove;
  final Function(String comment) onAddComment;
  final Function() onRemoveComment;

  const ItemTile({
    super.key,
    required this.data,
    required this.onMinus,
    required this.onPlus,
    required this.onRemove,
    required this.onAddComment,
    required this.onRemoveComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ExpansionTile(
        key: GlobalKey(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                "( ${data.amount} ) ${data.name} ",
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: ItemCounter(
                onMinus: onMinus,
                onPlus: onPlus,
              ),
            )
          ],
        ),
        subtitle: data.existsComment
            ? Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: Text(
                  data.comment!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            : null,
        children: [
          ListTile(
            title: Text(
              data.existsComment ? 'Editar observação' : 'Adicionar observação',
            ),
            onTap: () {
              UIUtils.showInputDialog(
                context,
                onSave: (text) {
                  onAddComment(text);
                },
                title: 'Observação',
                initialText: data.comment,
              );
            },
          ),
          if (data.existsComment)
            ListTile(
              title: const Text('Remover comentário'),
              onTap: onRemoveComment,
            ),
          ListTile(
            onTap: () {
              UIUtils.showAlertDialog(
                context,
                text: 'O item sairá de sua lista',
                onSelect: (selected) {
                  if (selected) {
                    onRemove();
                  }
                },
              );
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
    );
  }
}
