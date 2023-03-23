import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/order.dart';

class UserOrder extends StateNotifier<MovingOrder?> {
  final orderService = OrderService();

  UserOrder() : super(null) {
    getOrder();
  }

  // this will be created just on our state notifier (not on firebase, for now)
  void create() {
    state ??= const MovingOrder();
  }

  void setAddresses({String? from, String? to}) {
    state = state?.copyWith(originAddress: from, destinyAddress: to);
  }

  void setItems(List<Item> list) {
    state = state?.copyWith(items: list);
  }

  void setMovingDate(DateTime date) {
    state = state?.copyWith(movingDate: date);
  }

  void getOrder() async {
    state = await orderService.getOrder();
  }

  // method that calls the firebase API and persist it on firestore
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
