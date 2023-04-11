import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/blocs/storage_items.dart';
import 'package:muda_facil/src/screens/review.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/item_tile.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final TextEditingController textEditingController;
    final items = ref.watch(manageItemsProvider);
    final manageItemsActions = ref.read(manageItemsProvider.notifier);

    final filtered = ref.watch(filteredItemsProvider);

    return Scaffold(
      floatingActionButton: Visibility(
        visible: items.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ReviewScreen(),
            ));
          },
          tooltip: "Próximo",
          child: const Icon(Icons.navigate_next_outlined),
        ),
      ),
      appBar: AppBar(
        title: const Text('Adicionar itens'),
      ),
      body: Column(
        children: [
          Autocomplete<String>(
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted,
            ) {
              textEditingController = fieldTextEditingController;
              return Stack(children: [
                TextField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      helperText: 'Pesquise o item que quer adicionar'),
                ),
              ]);
            },
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable.empty();
              }

              return filtered.when(
                data: (value) {
                  var list = value
                      .where(
                        (option) => option
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()),
                      )
                      .toList();
                  if (list.length > 3) {
                    list = list.sublist(0, 3);
                  }

                  if (list.length != 1) {
                    list.insert(list.length, textEditingValue.text);
                  }

                  return list;
                },
                error: (error, stackTrace) => const Iterable.empty(),
                loading: () => const Iterable.empty(),
              );
            },
            onSelected: (selected) {
              manageItemsActions.plus(selected);
              textEditingController.clear();
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];

                return ItemTile(
                  data: item,
                  onRemove: () {
                    manageItemsActions.removeItem(item);
                  },
                  onMinus: () {
                    if (item.amount == 1) {
                      UIUtils.showAlertDialog(
                        context,
                        text: 'O item sairá de sua lista',
                        onSelect: (selected) {
                          if (selected) {
                            manageItemsActions.minus(item);
                          }
                        },
                      );
                    } else {
                      manageItemsActions.minus(item);
                    }
                  },
                  onPlus: () {
                    manageItemsActions.plus(item.name);
                  },
                  onAddComment: (text) {
                    manageItemsActions.addComment(
                      comment: text,
                      itemName: item.name,
                    );
                  },
                  onRemoveComment: () {
                    manageItemsActions.removeComment(itemName: item.name);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
