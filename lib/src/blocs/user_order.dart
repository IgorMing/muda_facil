import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/order.dart';

class UserOrder extends StateNotifier<MovingOrder?> {
  final orderService = OrderService();

  UserOrder() : super(null) {
    getOrder();
  }

  void create() {
    state ??= MovingOrder();
  }

  void setAddresses({String? from, String? to}) {
    state!.originAddress = from;
    state!.destinyAddress = to;
  }

  void setItems(List<Item> list) {
    state!.items = list;
  }

  void getOrder() async {
    state = await orderService.getOrder();
  }

  void persist() async {
    if (state != null) {
      await orderService.setOrder(state!);
    }
  }

  get allCompleted =>
      state?.destinyAddress != null &&
      state?.originAddress != null &&
      state?.movingDate != null;
}

final userOrderOrNullProvider =
    StateNotifierProvider<UserOrder, MovingOrder?>((ref) => UserOrder());
