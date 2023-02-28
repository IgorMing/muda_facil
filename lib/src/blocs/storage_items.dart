import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/models/storage_items_response.dart';
import 'package:muda_facil/src/services/items.dart';

class StorageItems extends StateNotifier<StorageItemsResponse> {
  StorageItems() : super(StorageItemsResponse([])) {
    getItems();
  }

  final ItemsService _itemsService = ItemsService();

  void getItems() async {
    // TODO: we should save this info in a cache, probably
    state = await _itemsService.getAll();
  }
}

final storageItemsProvider =
    StateNotifierProvider<StorageItems, StorageItemsResponse>((ref) {
  return StorageItems();
});

final filteredItemsProvider = FutureProvider<List<String>>((ref) {
  final selectedItems = ref.watch(manageItemsProvider);
  final storageItems = ref.watch(storageItemsProvider);

  return storageItems.data.where((element) {
    if (selectedItems.isEmpty) return true;

    return selectedItems.any((item) => item.name != element);
  }).toList();
});
