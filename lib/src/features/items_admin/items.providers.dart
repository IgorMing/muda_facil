import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/utils/constants.dart';

final ordersPendingCountProvider = Provider<int>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((element) =>
          element.order.status == OrderStatus.waitingDriver ||
          element.order.status == OrderStatus.waitingPayment)
      .length;
});

final adminPendingCountProvider = FutureProvider<Map<String, int>>((ref) {
  final ordersCount = ref.watch(ordersPendingCountProvider);

  return {
    "orders": ordersCount,
    "items": 12,
  };
});
