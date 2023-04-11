import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@unfreezed
class Item with _$Item {
  @JsonSerializable(includeIfNull: false)
  const Item._();

  factory Item({
    required String name,
    @Default(0) int amount,
    String? comment,
  }) = _Item;

  bool get existsComment => comment != null && comment!.isNotEmpty;

  factory Item.fromJson(Map<String, dynamic>? json) => _$ItemFromJson(json!);
}
