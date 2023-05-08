import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/features/orders/orders.service.dart';

class Orders extends StateNotifier<List<MovingOrder>> {
  final ordersService = OrdersService();
  late final StreamSubscription<List<MovingOrder>?> _subscription;

  Orders() : super([]);

  subscribe() {
    _subscription = ordersService.stream.listen((event) {
      state = event;
    });
  }

  unsubscribe() {
    return _subscription.cancel();
  }
}

final ordersProvider =
    StateNotifierProvider<Orders, List<MovingOrder>>((ref) => Orders());
