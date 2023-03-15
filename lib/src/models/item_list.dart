import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muda_facil/src/models/item.dart';

part 'item_list.freezed.dart';
part 'item_list.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ItemList with _$ItemList {
  const factory ItemList({
    required List<Item> data,
  }) = _ItemList;

  factory ItemList.fromJson(Map<String, dynamic>? json) =>
      _$ItemListFromJson(json!);
}
