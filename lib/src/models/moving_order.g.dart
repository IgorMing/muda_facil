// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moving_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovingOrder _$$_MovingOrderFromJson(Map<String, dynamic> json) =>
    _$_MovingOrder(
      items: json['items'] == null
          ? const ItemList(data: [])
          : ItemList.fromJson(json['items'] as Map<String, dynamic>?),
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
