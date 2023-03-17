// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemList _$$_ItemListFromJson(Map<String, dynamic> json) => _$_ItemList(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ItemListToJson(_$_ItemList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
