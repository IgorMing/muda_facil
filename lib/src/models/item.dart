import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@unfreezed
class Item with _$Item {
  @JsonSerializable(includeIfNull: false)
  factory Item({
    required String name,
    @Default(0) int amount,
    String? comment,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic>? json) => _$ItemFromJson(json!);
}
