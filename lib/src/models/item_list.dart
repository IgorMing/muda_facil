import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muda_facil/src/models/item.dart';

part 'item_list.freezed.dart';
part 'item_list.g.dart';

@freezed
class ItemList with _$ItemList {
  const factory ItemList({
    @Default([]) List<Item> data,
  }) = _ItemList;

  factory ItemList.fromJson(Map<String, dynamic>? json) =>
      _$ItemListFromJson(json!);
}