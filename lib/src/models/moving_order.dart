import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/utils/constants.dart';
part 'moving_order.freezed.dart';
part 'moving_order.g.dart';

@freezed
class MovingOrder with _$MovingOrder {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory MovingOrder({
    @Default([]) List<Item> items,
    required OrderStatus status,
    bool? flexibleMovingDate,
    @TimestampOrNullConverter() DateTime? movingDate,
    String? destinyAddress,
    String? originAddress,
    String? pixCode,
  }) = _MovingOrder;

  factory MovingOrder.fromJson(Map<String, dynamic>? json) =>
      _$MovingOrderFromJson(json!);
}

class TimestampOrNullConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampOrNullConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date);
}
