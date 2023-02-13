import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/item.dart';

class ManageItems extends StateNotifier<List<Item>> {
  ManageItems() : super([]);

  bool exists(Item item) {
    return state.contains(item);
  }

  void plus(Item item) {
    if (!exists(item)) return;

    for (final each in state) {
      if (each.name == item.name) {
        item.amount += 1;
      }
    }

    state = [...state];
  }

  void minus(Item item) {
    if (!exists(item)) return;

    for (final each in state) {
      if (each.amount == 1) {
        removeItem(item);
      } else {
        each.amount -= 1;
      }
    }

    state = [...state];
  }

  void addItem(Item item) {
    if (!exists(item)) {
      item.amount = 1;
      state = [...state, item];
    }
  }

  void removeItem(Item item) {
    if (exists(item)) {
      state = [
        for (final each in state)
          if (each.name != item.name) each
      ];
    }
  }
}

final manageItemsProvider =
    StateNotifierProvider<ManageItems, List<Item>>((ref) => ManageItems());
