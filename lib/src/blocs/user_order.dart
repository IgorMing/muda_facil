import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
    if (FirebaseAuth.instance.currentUser != null) {
      _subscription = stream.listen((event) {
        state = event;
      });
    }
  }

  Future<void> cancelSubscription() {
    return _subscription.cancel();
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
      _isFieldFilled(state?.destinyAddress) &&
      _isFieldFilled(state?.originAddress) &&
      _isFieldFilled(state?.movingDate?.toIso8601String());

  get canDeleteOrder =>
      state?.status == OrderStatus.pending ||
      state?.status == OrderStatus.helpNeeded;

  get canShowEditButtons => state?.status == OrderStatus.pending;
}

bool _isFieldFilled(String? field) {
  return field != null && field.isNotEmpty;
}

final userOrderOrNullProvider =
    StateNotifierProvider<UserOrder, MovingOrder?>((ref) => UserOrder());
