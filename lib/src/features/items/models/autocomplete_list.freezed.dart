// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'autocomplete_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AutocompleteList _$AutocompleteListFromJson(Map<String, dynamic> json) {
  return _AutocompleteList.fromJson(json);
}

/// @nodoc
mixin _$AutocompleteList {
  List<String> get data => throw _privateConstructorUsedError;
  set data(List<String> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutocompleteListCopyWith<AutocompleteList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutocompleteListCopyWith<$Res> {
  factory $AutocompleteListCopyWith(
          AutocompleteList value, $Res Function(AutocompleteList) then) =
      _$AutocompleteListCopyWithImpl<$Res, AutocompleteList>;
  @useResult
  $Res call({List<String> data});
}

/// @nodoc
class _$AutocompleteListCopyWithImpl<$Res, $Val extends AutocompleteList>
    implements $AutocompleteListCopyWith<$Res> {
  _$AutocompleteListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AutocompleteListCopyWith<$Res>
    implements $AutocompleteListCopyWith<$Res> {
  factory _$$_AutocompleteListCopyWith(
          _$_AutocompleteList value, $Res Function(_$_AutocompleteList) then) =
      __$$_AutocompleteListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> data});
}

/// @nodoc
class __$$_AutocompleteListCopyWithImpl<$Res>
    extends _$AutocompleteListCopyWithImpl<$Res, _$_AutocompleteList>
    implements _$$_AutocompleteListCopyWith<$Res> {
  __$$_AutocompleteListCopyWithImpl(
      _$_AutocompleteList _value, $Res Function(_$_AutocompleteList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_AutocompleteList(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_AutocompleteList implements _AutocompleteList {
  _$_AutocompleteList({required this.data});

  factory _$_AutocompleteList.fromJson(Map<String, dynamic> json) =>
      _$$_AutocompleteListFromJson(json);

  @override
  List<String> data;

  @override
  String toString() {
    return 'AutocompleteList(data: $data)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AutocompleteListCopyWith<_$_AutocompleteList> get copyWith =>
      __$$_AutocompleteListCopyWithImpl<_$_AutocompleteList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AutocompleteListToJson(
      this,
    );
  }
}

abstract class _AutocompleteList implements AutocompleteList {
  factory _AutocompleteList({required List<String> data}) = _$_AutocompleteList;

  factory _AutocompleteList.fromJson(Map<String, dynamic> json) =
      _$_AutocompleteList.fromJson;

  @override
  List<String> get data;
  set data(List<String> value);
  @override
  @JsonKey(ignore: true)
  _$$_AutocompleteListCopyWith<_$_AutocompleteList> get copyWith =>
      throw _privateConstructorUsedError;
}
