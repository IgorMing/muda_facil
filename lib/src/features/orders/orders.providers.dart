import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/providers/authentication.dart';
import 'package:muda_facil/src/utils/constants.dart';

class OrderWithUser {
  final MovingOrderWithRef orderWithRef;
  final UserModel? user;

  OrderWithUser({
    required this.orderWithRef,
    required this.user,
  });
}

final ordersProvider =
    StateNotifierProvider<Orders, List<MovingOrderWithRef>>((ref) => Orders());

final pendingAdminOrdersWithUserProvider = FutureProvider<List<OrderWithUser>>(
  (ref) async {
    final orders = ref.watch(pendingAdminActionOrdersProvider);
    final auth = ref.read(authenticationProvider);
    final List<OrderWithUser> response = [];

    for (var order in orders) {
      final user = await auth.getUserInfo(uid: order.ref.parent.parent!.id);
      response.add(OrderWithUser(orderWithRef: order, user: user));
    }

    return response;
  },
);

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
