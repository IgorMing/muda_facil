import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.providers.dart';
import 'package:muda_facil/src/features/orders/widgets/order_card.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/dialogs.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/icon_row.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class NeedingHelpScreen extends ConsumerWidget {
  const NeedingHelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(needingHelpAdminActionOrdersProvider);
    final notifier = ref.read(ordersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              UIUtils.of(context).showInfoDialog(
                title: 'Instruções de uso',
                body: [
                  'Veja os pedidos que estão precisando de alguma ajuda e/ou intervenção.'
                ],
                confirmationText: 'Entendi',
              );
            },
            icon: Icon(
              Icons.help_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
        title: const Text('Mudanças'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: orders.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final orderModel = data[index];
                return OrderCard(
                  clickable: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          Dialogs.getBugetInfoDialog(context, onSave: ({
                        required budgetValue,
                        required driverName,
                        required pixCode,
                      }) {
                        notifier.setBudget(
                          orderModel.ref,
                          value: budgetValue,
                          driver: driverName,
                          pixCode: pixCode,
                        );
                      }),
                    );
                  },
                  content: Column(
                    children: [
                      IconRow(
                        text: orderModel.order.helpNeeded!,
                        iconData: Icons.text_snippet_outlined,
                        highlightedText: true,
                      ),
                      const SizedBox(
                        height: kDefaultPadding / 4,
                      ),
                      IconRow(
                        text: GeneralUtils.getCurrencyFormat(
                            orderModel.order.budgetValue ?? 0),
                        iconData: Icons.monetization_on_outlined,
                        highlightedText: true,
                      ),
                      const Divider(),
                      IconRow(
                        text: orderModel.user?.name ?? '',
                        iconData: Icons.person_outline,
                      ),
                      const SizedBox(
                        height: kDefaultPadding / 4,
                      ),
                      IconRow(
                        text: orderModel.user?.phone ?? '',
                        iconData: Icons.phone_outlined,
                      ),
                      const SizedBox(
                        height: kDefaultPadding / 4,
                      ),
                      IconRow(
                        text: orderModel.user?.email ?? '',
                        iconData: Icons.email_outlined,
                      ),
                    ],
                  ),
                );
              },
            ),
            error: (error, stackTrace) => const Text('error'),
            loading: () => const LoadingAdaptive(),
          ),
        ),
      ),
    );
  }
}
