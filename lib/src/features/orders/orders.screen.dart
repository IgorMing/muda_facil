import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => Card(
          child: Text('testing $index'),
        ),
      ),
    );
  }
}
