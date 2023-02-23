import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/item.dart';

class ManageItems extends StateNotifier<List<Item>> {
  ManageItems() : super([]);

  bool get isSingle => false;

  bool exists(Item item) {
    return state.any((each) => each.name == item.name);
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
      if (each.amount > 1) {
        each.amount -= 1;
      } else {
        _removeItem(item);
      }
    }

    state = [...state];
  }

  void _addItem(Item item) {
    if (!exists(item)) {
      item.amount = 1;
      state = [...state, item];
    }
  }

  void _removeItem(Item item) {
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
