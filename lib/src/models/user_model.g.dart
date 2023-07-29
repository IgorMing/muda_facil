// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']) ?? Role.user,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('email', instance.email);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  val['role'] = _$RoleEnumMap[instance.role]!;
  return val;
}

const _$RoleEnumMap = {
  Role.user: 'user',
  Role.admin: 'admin',
  Role.driver: 'driver',
};
