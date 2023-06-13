import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/utils/constants.dart';

final ordersProvider =
    StateNotifierProvider<Orders, List<MovingOrderWithRef>>((ref) => Orders());

final pendingAdminActionOrdersProvider =
    Provider<List<MovingOrderWithRef>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((element) =>
          element.order.status == OrderStatus.waitingDriver ||
          element.order.status == OrderStatus.waitingPayment)
      .toList();
});

final ordersPendingCountProvider = Provider<int>((ref) {
  return ref.watch(pendingAdminActionOrdersProvider).length;
});

final needingHelpAdminActionOrdersProvider =
    Provider<List<MovingOrderWithRef>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((element) =>
          element.order.status == OrderStatus.helpNeeded ||
          element.order.status == OrderStatus.declined)
      .toList();
});

final ordersNeedingHelpCountProvider = Provider<int>((ref) {
  return ref.watch(needingHelpAdminActionOrdersProvider).length;
});
