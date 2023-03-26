import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/order.dart';

class UserOrder extends StateNotifier<MovingOrder?> {
  final orderService = OrderService();
  bool _checked = false;

  bool get isLoading => _checked == false;

  UserOrder() : super(null) {
    getOrder();
  }

  // this will be created just on our state notifier (not on firebase, for now)
  void create() {
    state ??= const MovingOrder();
  }

  void setAddresses({String? from, String? to}) {
    state = state?.copyWith(originAddress: from, destinyAddress: to);
    _persist();
  }

  void setItems(List<Item> list) {
    state = state?.copyWith(items: list);
    _persist();
  }

  void setMovingDate(DateTime date) {
    state = state?.copyWith(movingDate: date);
    _persist();
  }

  Future getOrder() async {
    _checked = false;
    state = await orderService.getOrder();
    _checked = true;
  }

  // method that calls the firebase API and persist it on firestore
  void _persist() async {
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
