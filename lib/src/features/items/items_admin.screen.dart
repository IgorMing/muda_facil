import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/items/items.providers.dart';
import 'package:muda_facil/src/utils/ui.dart';

class ItemsAdminScreen extends ConsumerStatefulWidget {
  const ItemsAdminScreen({super.key});

  @override
  ConsumerState<ItemsAdminScreen> createState() => _ItemsAdminScreenState();
}

class _ItemsAdminScreenState extends ConsumerState<ItemsAdminScreen> {
  @override
  Widget build(BuildContext context) {
    final candidates = ref.watch(candidatesListStateProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    changeText(String oldValue, String newValue) {
      final index = candidates.indexOf(oldValue);
      candidates[index] = newValue;
      ref.read(candidatesListStateProvider.notifier).set(candidates);
    }

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) => ExpansionTile(
          title: Text(
            candidates[index],
            style: textTheme.bodyLarge,
          ),
          children: [
            ListTile(
              title: Text(
                'Editar',
                style: textTheme.bodySmall,
              ),
              onTap: () {
                UIUtils.of(context).showInputDialog(
                  onSave: (text) {
                    changeText(candidates[index], text);
                  },
                  title: 'Editar',
                  initialText: candidates[index],
                );
              },
            ),
            ListTile(
              title: Text(
                'Aprovar',
                style:
                    textTheme.bodySmall!.copyWith(color: colorScheme.primary),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Remover',
                style: textTheme.bodySmall!.copyWith(color: colorScheme.error),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
