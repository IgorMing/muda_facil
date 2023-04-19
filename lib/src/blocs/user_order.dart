import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/order.dart';
import 'package:muda_facil/src/utils/constants.dart';

class UserOrder extends StateNotifier<MovingOrder?> {
  final orderService = OrderService();
  late final StreamSubscription<MovingOrder?> _subscription;

  UserOrder() : super(null) {
    final stream = orderService.getStream();
    _subscription = stream.listen((event) {
      state = event;
    });
  }

  void cancelSubscription() {
    _subscription.cancel();
  }

  void create() {
    state ??= const MovingOrder(status: OrderStatus.pending);
  }

  void setAddresses({String? from, String? to}) {
    _persist((state?.copyWith(originAddress: from, destinyAddress: to))!);
  }

  void setItems(List<Item> list) {
    _persist((state?.copyWith(items: list))!);
  }

  void setStatus(OrderStatus status) {
    _persist((state?.copyWith(status: status))!);
  }

  void setHelp(String text) {
    _persist((state?.copyWith(
      helpNeeded: text,
      status: OrderStatus.helpNeeded,
    ))!);
  }

  void setMovingDate(DateTime date) {
    _persist((state?.copyWith(movingDate: date))!);
  }

  Future deleteOrder() async {
    state = null;
    await orderService.deleteOrder();
  }

  Future declineBudget(String reason) async {
    _persist((state?.copyWith(
      status: OrderStatus.declined,
      declineReason: reason,
    ))!);
  }

  // method that calls the firebase API and persist it on firestore
  void _persist(MovingOrder order) async {
    await orderService.setOrder(order);
  }

  get allCompleted =>
      state?.destinyAddress != null &&
      state?.originAddress != null &&
      state?.movingDate != null;

  get canDeleteOrder =>
      state?.status == OrderStatus.pending ||
      state?.status == OrderStatus.helpNeeded;

  get canShowEditButtons => state?.status == OrderStatus.pending;
}

final userOrderOrNullProvider =
    StateNotifierProvider<UserOrder, MovingOrder?>((ref) => UserOrder());
