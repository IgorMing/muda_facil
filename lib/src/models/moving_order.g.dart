// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moving_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovingOrder _$$_MovingOrderFromJson(Map<String, dynamic> json) =>
    _$_MovingOrder(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      flexibleMovingDate: json['flexibleMovingDate'] as bool?,
      movingDate: const TimestampOrNullConverter()
          .fromJson(json['movingDate'] as Timestamp?),
      destinyAddress: json['destinyAddress'] as String?,
      originAddress: json['originAddress'] as String?,
    );

Map<String, dynamic> _$$_MovingOrderToJson(_$_MovingOrder instance) {
  final val = <String, dynamic>{
    'items': instance.items.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flexibleMovingDate', instance.flexibleMovingDate);
  writeNotNull('movingDate',
      const TimestampOrNullConverter().toJson(instance.movingDate));
  writeNotNull('destinyAddress', instance.destinyAddress);
  writeNotNull('originAddress', instance.originAddress);
  return val;
}
