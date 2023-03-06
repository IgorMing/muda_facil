import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/order.dart';

class UserOrder extends StateNotifier<MovingOrder?> {
  final orderService = OrderService();

  UserOrder() : super(null) {
    getOrder();
  }

  void getOrder() async {
    state = await orderService.getOrder();
  }
}

final userOrderProvider =
    StateNotifierProvider<UserOrder, MovingOrder?>((ref) => UserOrder());
