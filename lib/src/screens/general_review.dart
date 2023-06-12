import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/full_width_button.dart';
import 'package:muda_facil/src/widgets/info_row.dart';
import 'package:muda_facil/src/widgets/review_item_card.dart';

class GeneralReviewScreen extends ConsumerWidget {
  const GeneralReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(userOrderOrNullProvider);
    final actions = ref.read(userOrderOrNullProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisão geral'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(
              label: "Origem",
              value: order!.originAddress,
            ),
            const Divider(),
            InfoRow(
              label: "Destino",
              value: order.destinyAddress,
            ),
            const Divider(),
            InfoRow(
              label: "Data",
              value: GeneralUtils.formatDateFromTimestamp(
                  order.movingDate!.microsecondsSinceEpoch),
            ),
            const Divider(),
            Text(
              'Itens:',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) =>
                    ReviewItemCard(item: order.items[index]),
              ),
            ),
            FullWidthButton(
                title: 'Confirmar',
                onPressed: () {
                  UIUtils.of(context).showAlertDialog(
                    text:
                        'Ao confirmar, iremos buscar alguém para fazer este frete. Revise com atenção todas as informações adicionadas.',
                    onSelect: (selected) {
                      if (selected) {
                        FirebaseAnalytics.instance
                            .logEvent(name: 'order_sent_by_user');
                        UIUtils.of(context).showLoaderDialog(() {
                          actions.setStatus(OrderStatus.waitingDriver);
                        });
                      }
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
