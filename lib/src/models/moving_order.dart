import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muda_facil/src/models/item.dart';
part 'moving_order.freezed.dart';
part 'moving_order.g.dart';

@freezed
class MovingOrder with _$MovingOrder {
  const factory MovingOrder({
    @Default([]) List<Item>? items,
    bool? flexibleMovingDate,
    DateTime? movingDate,
    String? destinyAddress,
    String? originAddress,
  }) = _MovingOrder;

  factory MovingOrder.fromJson(Map<String, dynamic>? json) =>
      _$MovingOrderFromJson(json!);
}
