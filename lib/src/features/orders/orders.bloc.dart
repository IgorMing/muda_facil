import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/features/orders/orders.service.dart';

class Orders extends StateNotifier<List<MovingOrderWithRef>> {
  final ordersService = OrdersService();

  late final StreamSubscription<List<MovingOrderWithRef>?> _subscription;

  Orders() : super([]);

  subscribe() {
    _subscription = ordersService.stream.listen((event) {
      state = event;
    });
  }

  unsubscribe() {
    return _subscription.cancel();
  }

  void setBudget(
    DocumentReference<MovingOrder> ref, {
    required double value,
    required String driver,
    required String pixCode,
  }) {
    ordersService.setBudget(ref,
        value: value, driver: driver, pixCode: pixCode);
  }

  void confirmPayment(DocumentReference<MovingOrder> ref) {
    ordersService.confirmPayment(ref);
  }
}

final ordersProvider =
    StateNotifierProvider<Orders, List<MovingOrderWithRef>>((ref) => Orders());
