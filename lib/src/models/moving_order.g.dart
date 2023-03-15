// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moving_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovingOrder _$$_MovingOrderFromJson(Map<String, dynamic> json) =>
    _$_MovingOrder(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      flexibleMovingDate: json['flexibleMovingDate'] as bool?,
      movingDate: json['movingDate'] == null
          ? null
          : DateTime.parse(json['movingDate'] as String),
      destinyAddress: json['destinyAddress'] as String?,
      originAddress: json['originAddress'] as String?,
    );

Map<String, dynamic> _$$_MovingOrderToJson(_$_MovingOrder instance) =>
    <String, dynamic>{
      'items': instance.items,
      'flexibleMovingDate': instance.flexibleMovingDate,
      'movingDate': instance.movingDate?.toIso8601String(),
      'destinyAddress': instance.destinyAddress,
      'originAddress': instance.originAddress,
    };
