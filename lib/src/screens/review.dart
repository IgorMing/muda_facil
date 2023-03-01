import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/utils/constants.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(manageItemsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Revisão de itens',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text("${item.amount}x ${item.name}"),
                      ),
                    );
                  }),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Confirmar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
