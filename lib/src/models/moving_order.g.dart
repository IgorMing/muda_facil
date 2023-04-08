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
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      flexibleMovingDate: json['flexibleMovingDate'] as bool?,
      movingDate: const TimestampOrNullConverter()
          .fromJson(json['movingDate'] as Timestamp?),
      destinyAddress: json['destinyAddress'] as String?,
      originAddress: json['originAddress'] as String?,
      pixCode: json['pixCode'] as String?,
      helpNeeded: json['helpNeeded'] as String?,
      declineReason: json['declineReason'] as String?,
      driverName: json['driverName'] as String?,
      budgetValue: (json['budgetValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_MovingOrderToJson(_$_MovingOrder instance) {
  final val = <String, dynamic>{
    'items': instance.items.map((e) => e.toJson()).toList(),
    'status': _$OrderStatusEnumMap[instance.status]!,
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
  writeNotNull('pixCode', instance.pixCode);
  writeNotNull('helpNeeded', instance.helpNeeded);
  writeNotNull('declineReason', instance.declineReason);
  writeNotNull('driverName', instance.driverName);
  writeNotNull('budgetValue', instance.budgetValue);
  return val;
}

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.declined: 'declined',
  OrderStatus.helpNeeded: 'helpNeeded',
  OrderStatus.waitingDriver: 'waitingDriver',
  OrderStatus.waitingApproval: 'waitingApproval',
  OrderStatus.waitingPayment: 'waitingPayment',
  OrderStatus.approved: 'approved',
};
