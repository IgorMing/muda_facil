import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/manage_items.dart';
import 'package:muda_facil/src/services/items.dart';

class StorageItemResponse {
  List<String> data;

  StorageItemResponse(this.data);
}

class StorageItems extends StateNotifier<StorageItemResponse> {
  StorageItems() : super(StorageItemResponse([])) {
    getItems();
  }

  ItemsService itemsService = ItemsService();

  getItems() async {
    var response = await itemsService.getAll();
    state = StorageItemResponse([...response]);
  }
}

final storageItemsProvider =
    StateNotifierProvider<StorageItems, StorageItemResponse>(
        (ref) => StorageItems());

final filteredItemsProvider = FutureProvider((ref) {
  final selectedItems = ref.watch(manageItemsProvider);
  final storageItems = ref.watch(storageItemsProvider);

  return storageItems.data.toList()
    ..retainWhere(
      (element) {
        return !selectedItems.any((item) => item.name == element);
      },
    );
});
