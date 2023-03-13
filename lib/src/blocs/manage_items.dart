import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/item.dart';

class ManageItems extends StateNotifier<List<Item>> {
  ManageItems() : super([]);
  ManageItems.withList(List<Item> list) : super([]) {
    _createWith(list);
  }

  bool get isSingle => false;

  bool exists(Item item) {
    return state.any((each) => each.name == item.name);
  }

  void addComment(String comment, Item item) {
    for (final each in state) {
      if (each.name == item.name) {
        each.comment = comment;
      }
    }

    state = [...state];
  }

  void plus(Item item) {
    if (!exists(item)) {
      _addItem(item);
      return;
    }

    for (final each in state) {
      if (each.name == item.name) {
        each.amount += 1;
      }
    }

    state = [...state];
  }

  void minus(Item item) {
    for (final each in state) {
      if (each.name == item.name) {
        if (each.amount > 1) {
          each.amount -= 1;
        } else {
          removeItem(item);
        }
      }
    }

    state = [...state];
  }

  void _addItem(Item item) {
    item.amount = 1;
    state = [...state, item];
  }

  void removeItem(Item item) {
    state = [
      for (final each in state)
        if (each.name != item.name) each
    ];
  }

  void _createWith(List<Item> list) {
    state = [...list];
  }
}

final manageItemsProvider =
    StateNotifierProvider<ManageItems, List<Item>>((ref) {
  final userOrder = ref.watch(userOrderOrNullProvider);
  final userOrderItems = userOrder?.items ?? [];

  return ManageItems.withList(userOrderItems);
});
