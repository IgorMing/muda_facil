import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/app.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/review_item_card.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(manageItemsProvider);
    final userOrder = ref.read(userOrderOrNullProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisão de itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return ReviewItemCard(item: item);
                  }),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  // loading is good for UX :)
                  // TODO: double check this for adding it to other places as well...
                  Future.delayed(const Duration(seconds: 1), () {
                    userOrder.setItems(items);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                  });
                },
                child: const Text('Confirmar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
