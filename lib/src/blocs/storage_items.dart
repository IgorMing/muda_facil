import 'package:flutter_riverpod/flutter_riverpod.dart';
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
