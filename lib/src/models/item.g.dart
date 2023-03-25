// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      name: json['name'] as String,
      amount: json['amount'] as int? ?? 0,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('comment', instance.comment);
  return val;
}
