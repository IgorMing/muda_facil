import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/utils/constants.dart';

final ordersProvider =
    StateNotifierProvider<Orders, List<MovingOrderWithRef>>((ref) => Orders());

final pendingAdminActionOrdersProvider =
    Provider<List<MovingOrderWithRef>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((element) => isStatusInterable(element.order.status))
      .toList();
});

final ordersPendingCountProvider = Provider<int>((ref) {
  return ref.watch(pendingAdminActionOrdersProvider).length;
});

final needingHelpAdminActionOrdersProvider =
    FutureProvider<List<MovingOrderWithRef>>((ref) async {
  final orders = ref.watch(ordersProvider);
  final authNotifier = ref.read(appUserProvider.notifier);

  final filtered = orders.where((element) =>
      element.order.status == OrderStatus.helpNeeded ||
      element.order.status == OrderStatus.declined);

  for (var order in filtered) {
    final user = await authNotifier.getUser(order.ref.parent.parent!.id);
    order.user = user;
  }

  return filtered.toList();
});

final ordersNeedingHelpCountProvider = Provider<int>((ref) {
  final value = ref.watch(needingHelpAdminActionOrdersProvider);
  return value.asData != null ? value.asData!.value.length : 0;
});
