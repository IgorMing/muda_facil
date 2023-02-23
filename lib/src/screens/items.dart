import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/blocs/storage_items.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/item_tile.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late TextEditingController textEditingController = TextEditingController();
    final items = ref.watch(manageItemsProvider);
    final manageItemsActions = ref.read(manageItemsProvider.notifier);

    final filtered = ref.watch(filteredItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar itens'),
      ),
      body: Column(
        children: [
          Autocomplete<String>(
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              textEditingController = fieldTextEditingController;
              return TextField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    helperText: 'Pesquise o nome do item de sua casa...'),
              );
            },
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable.empty();
              }

              return filtered.value!.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (selected) {
              manageItemsActions.plus(Item(name: selected));
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
                  onMinus: () {
                    if (item.amount == 1) {
                      UIUtils.showAlertDialog(context, onSelect: (selected) {
                        if (selected) {
                          manageItemsActions.minus(item);
                        }
                      });
                    } else {
                      manageItemsActions.minus(item);
                    }
                  },
                  onPlus: () {
                    manageItemsActions.plus(item);
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
