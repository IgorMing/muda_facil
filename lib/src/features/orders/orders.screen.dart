import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/features/orders/widgets/order_card.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              UIUtils.showInfoDialog(
                context,
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
        title: const Text('Mudanças'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) => OrderCard(
              topText: orders[index].originAddress!,
              bottomText: orders[index].destinyAddress!,
              date: orders[index].movingDate!,
            ),
          ),
        ),
      ),
    );
  }
}
