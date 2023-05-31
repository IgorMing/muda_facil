import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/items/items.providers.dart';

class ItemsAdminScreen extends ConsumerWidget {
  const ItemsAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candidates = ref.watch(candidatesListStateProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
              onTap: () {},
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
