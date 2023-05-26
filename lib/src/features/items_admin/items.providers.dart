import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';

final adminPendingCountProvider = FutureProvider<Map<String, int>>((ref) {
  final ordersCount = ref.watch(ordersProvider).length;

  return {
    "orders": ordersCount,
    "items": 12,
  };
});
