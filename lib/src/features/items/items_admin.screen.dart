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
    final notifier = ref.read(candidatesListStateProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    changeText(String oldValue, String newValue) {
      final index = candidates.indexOf(oldValue);
      candidates[index] = newValue;
      notifier.set(candidates);
    }

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) => ExpansionTile(
          key: GlobalKey(),
          title: Text(
            candidates[index],
            style: textTheme.bodyLarge,
          ),
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
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
              leading: Icon(
                Icons.check_outlined,
                color: colorScheme.primary,
              ),
              title: Text(
                'Aprovar',
                style:
                    textTheme.bodySmall!.copyWith(color: colorScheme.primary),
              ),
              onTap: () {
                UIUtils.of(context).showAlertDialog(
                  title: 'Confirmar aprovação?',
                  text:
                      'Ao aprovar, a palavra "${candidates[index]}" será removida desta lista, e adicionada na lista geral.',
                  onSelect: (confirmed) {
                    if (confirmed) {
                      notifier.approveCandidate(candidates[index]);
                    }
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: colorScheme.error),
              title: Text(
                'Remover',
                style: textTheme.bodySmall!.copyWith(color: colorScheme.error),
              ),
              onTap: () {
                UIUtils.of(context).showAlertDialog(
                  title: 'Confirmar remoção?',
                  text:
                      'Ao remover, a palavra "${candidates[index]}" será excluída desta lista.',
                  onSelect: (confirmed) {
                    if (confirmed) {
                      notifier.deleteCandidate(candidates[index]);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
