import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.providers.dart';
import 'package:muda_facil/src/features/orders/widgets/pending_order_card.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(pendingAdminOrdersWithUserProvider);
    final notifier = ref.read(ordersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              UIUtils.of(context).showInfoDialog(
                title: 'Instruções de uso',
                body: [
                  'Clique no item para adicionar as informações de: motorista, valor e código pix.\n',
                  'Clique e segure pressionado no item, para copiar a mensagem destinada ao motorista.'
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
        title: const Text('Mudanças com pendência'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: orders.when(
            data: (orders) => ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final orderModel = orders[index];
                return PendingOrderCard(
                    orderOwner: orderModel.user!,
                    order: orderModel.orderWithRef.order,
                    onSave: (
                        {required budgetValue,
                        required driverName,
                        required pixCode}) {
                      notifier.setBudget(
                        orderModel.orderWithRef.ref,
                        value: budgetValue,
                        driver: driverName,
                        pixCode: pixCode,
                      );
                    },
                    onConfirm: () =>
                        notifier.confirmPayment(orderModel.orderWithRef.ref),
                    status: orderModel.orderWithRef.order.status);
              },
            ),
            error: (error, stackTrace) => null,
            loading: () => const LoadingAdaptive(),
          ),
        ),
      ),
    );
  }
}
