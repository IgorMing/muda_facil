import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/services/items.dart';

class StorageItems extends StateNotifier<List<String>> {
  StorageItems() : super([]) {
    getItems();
  }

  final ItemsService _itemsService = ItemsService();

  void getItems() async {
    // TODO: we should save this info in a cache, probably
    state = await _itemsService.getAll();
  }
}

final storageItemsProvider =
    StateNotifierProvider<StorageItems, List<String>>((ref) {
  return StorageItems();
});

final filteredItemsProvider = FutureProvider<List<String>>((ref) {
  final selectedItems =
      ref.watch(manageItemsProvider).map((e) => e.name).toSet();
  final storageItems = ref.watch(storageItemsProvider).toSet();

  return storageItems.difference(selectedItems).toList();
});
