import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/items/items.service.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/order.dart';
import 'package:muda_facil/src/utils/constants.dart';

class UserOrder extends StateNotifier<MovingOrder?> {
  final orderService = OrderService();
  final itemsService = ItemsService();
  late final StreamSubscription<MovingOrder?> _subscription;

  UserOrder() : super(null) {
    final stream = orderService.getStream();
    _subscription = stream.listen((event) {
      state = event;
    });
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

  void finishOrder() {
    FirebaseAnalytics.instance.logEvent(name: 'order_sent_by_user');
    _persist(state!.copyWith(
        status: OrderStatus.waitingDriver, orderSentDate: DateTime.now()));

    final items = state!.items.map<String>((e) => e.name).toList();

    itemsService.checkCandidates(items);
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
      state?.status == OrderStatus.helpNeeded ||
      state?.status == OrderStatus.declined;

  get canShowEditButtons => state?.status == OrderStatus.pending;
}

bool _isFieldFilled(String? field) {
  return field != null && field.isNotEmpty;
}

final userOrderOrNullProvider =
    StateNotifierProvider<UserOrder, MovingOrder?>((ref) => UserOrder());
