import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/widgets/item_counter.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  static const List<String> _kOptions = [
    'Puff',
    'Sofá',
    'Fogão',
    'Geladeira',
    'Cama',
    'Instrumento musical',
    'Cadeira',
    'Caixa',
    'Ar condicionado',
    'Painel de TV',
    'Bicicleta',
    'Escrivaninha',
    'Hack',
    'Mesa',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(manageItemsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar itens'),
      ),
      body: Column(
        children: [
          Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable.empty();
              }

              return ItemsScreen._kOptions.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (selected) {
              ref
                  .read(manageItemsProvider.notifier)
                  .addItem(Item(name: selected));
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: items.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(items[index].name),
                  trailing: ItemCounter(
                    items[index].amount,
                    onMinus: () {
                      ref
                          .read(manageItemsProvider.notifier)
                          .minus(items[index]);
                    },
                    onPlus: () {
                      ref.read(manageItemsProvider.notifier).plus(items[index]);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
