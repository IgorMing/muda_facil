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
    // do firebase does that already? let's spike that out later
    state = await _itemsService.getAll();
  }
}

final _storageItemsProvider =
    StateNotifierProvider<StorageItems, List<String>>((ref) {
  return StorageItems();
});

final filteredItemsProvider = FutureProvider<List<String>>((ref) {
  final selectedItems =
      ref.watch(manageItemsProvider).map((e) => e.name).toSet();
  final storageItems = ref.watch(_storageItemsProvider).toSet();

  return storageItems.difference(selectedItems).toList();
});
