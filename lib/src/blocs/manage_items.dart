import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/item.dart';

class ManageItems extends StateNotifier<List<Item>> {
  ManageItems() : super([]);
  ManageItems.withList(List<Item> list) : super(list) {
    state = list;
  }

  bool get isSingle => false;

  bool exists(String itemName) {
    return state.any((each) => each.name == itemName);
  }

  void addComment({required String comment, required String itemName}) {
    for (var each in state) {
      if (each.name == itemName) {
        each.comment = comment;
      }
    }

    state = [...state];
  }

  void plus(String name) {
    if (!exists(name)) {
      _addItem(name);
      return;
    }

    for (var each in state) {
      if (each.name == name) {
        each.amount += 1;
      }
    }

    state = [...state];
  }

  void minus(Item item) {
    for (var each in state) {
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

  void _addItem(String itemName) {
    state = [...state, Item(amount: 1, name: itemName)];
  }

  void removeItem(Item item) {
    for (final each in state) {
      if (each.name != item.name) each;
    }
  }
}

final manageItemsProvider =
    StateNotifierProvider<ManageItems, List<Item>>((ref) {
  final userOrder = ref.watch(userOrderOrNullProvider);
  final userOrderItems = userOrder?.items;

  return userOrderItems == null
      ? ManageItems()
      : ManageItems.withList(userOrderItems);
});
