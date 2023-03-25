// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moving_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovingOrder _$MovingOrderFromJson(Map<String, dynamic> json) {
  return _MovingOrder.fromJson(json);
}

/// @nodoc
mixin _$MovingOrder {
  List<Item> get items => throw _privateConstructorUsedError;
  bool? get flexibleMovingDate => throw _privateConstructorUsedError;
  @TimestampOrNullConverter()
  DateTime? get movingDate => throw _privateConstructorUsedError;
  String? get destinyAddress => throw _privateConstructorUsedError;
  String? get originAddress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovingOrderCopyWith<MovingOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovingOrderCopyWith<$Res> {
  factory $MovingOrderCopyWith(
          MovingOrder value, $Res Function(MovingOrder) then) =
      _$MovingOrderCopyWithImpl<$Res, MovingOrder>;
  @useResult
  $Res call(
      {List<Item> items,
      bool? flexibleMovingDate,
      @TimestampOrNullConverter() DateTime? movingDate,
      String? destinyAddress,
      String? originAddress});
}

/// @nodoc
class _$MovingOrderCopyWithImpl<$Res, $Val extends MovingOrder>
    implements $MovingOrderCopyWith<$Res> {
  _$MovingOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? flexibleMovingDate = freezed,
    Object? movingDate = freezed,
    Object? destinyAddress = freezed,
    Object? originAddress = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      flexibleMovingDate: freezed == flexibleMovingDate
          ? _value.flexibleMovingDate
          : flexibleMovingDate // ignore: cast_nullable_to_non_nullable
              as bool?,
      movingDate: freezed == movingDate
          ? _value.movingDate
          : movingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      destinyAddress: freezed == destinyAddress
          ? _value.destinyAddress
          : destinyAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      originAddress: freezed == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovingOrderCopyWith<$Res>
    implements $MovingOrderCopyWith<$Res> {
  factory _$$_MovingOrderCopyWith(
          _$_MovingOrder value, $Res Function(_$_MovingOrder) then) =
      __$$_MovingOrderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Item> items,
      bool? flexibleMovingDate,
      @TimestampOrNullConverter() DateTime? movingDate,
      String? destinyAddress,
      String? originAddress});
}

/// @nodoc
class __$$_MovingOrderCopyWithImpl<$Res>
    extends _$MovingOrderCopyWithImpl<$Res, _$_MovingOrder>
    implements _$$_MovingOrderCopyWith<$Res> {
  __$$_MovingOrderCopyWithImpl(
      _$_MovingOrder _value, $Res Function(_$_MovingOrder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? flexibleMovingDate = freezed,
    Object? movingDate = freezed,
    Object? destinyAddress = freezed,
    Object? originAddress = freezed,
  }) {
    return _then(_$_MovingOrder(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      flexibleMovingDate: freezed == flexibleMovingDate
          ? _value.flexibleMovingDate
          : flexibleMovingDate // ignore: cast_nullable_to_non_nullable
              as bool?,
      movingDate: freezed == movingDate
          ? _value.movingDate
          : movingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      destinyAddress: freezed == destinyAddress
          ? _value.destinyAddress
          : destinyAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      originAddress: freezed == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$_MovingOrder implements _MovingOrder {
  const _$_MovingOrder(
      {final List<Item> items = const [],
      this.flexibleMovingDate,
      @TimestampOrNullConverter() this.movingDate,
      this.destinyAddress,
      this.originAddress})
      : _items = items;

  factory _$_MovingOrder.fromJson(Map<String, dynamic> json) =>
      _$$_MovingOrderFromJson(json);

  final List<Item> _items;
  @override
  @JsonKey()
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool? flexibleMovingDate;
  @override
  @TimestampOrNullConverter()
  final DateTime? movingDate;
  @override
  final String? destinyAddress;
  @override
  final String? originAddress;

  @override
  String toString() {
    return 'MovingOrder(items: $items, flexibleMovingDate: $flexibleMovingDate, movingDate: $movingDate, destinyAddress: $destinyAddress, originAddress: $originAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovingOrder &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.flexibleMovingDate, flexibleMovingDate) ||
                other.flexibleMovingDate == flexibleMovingDate) &&
            (identical(other.movingDate, movingDate) ||
                other.movingDate == movingDate) &&
            (identical(other.destinyAddress, destinyAddress) ||
                other.destinyAddress == destinyAddress) &&
            (identical(other.originAddress, originAddress) ||
                other.originAddress == originAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      flexibleMovingDate,
      movingDate,
      destinyAddress,
      originAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovingOrderCopyWith<_$_MovingOrder> get copyWith =>
      __$$_MovingOrderCopyWithImpl<_$_MovingOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovingOrderToJson(
      this,
    );
  }
}

abstract class _MovingOrder implements MovingOrder {
  const factory _MovingOrder(
      {final List<Item> items,
      final bool? flexibleMovingDate,
      @TimestampOrNullConverter() final DateTime? movingDate,
      final String? destinyAddress,
      final String? originAddress}) = _$_MovingOrder;

  factory _MovingOrder.fromJson(Map<String, dynamic> json) =
      _$_MovingOrder.fromJson;

  @override
  List<Item> get items;
  @override
  bool? get flexibleMovingDate;
  @override
  @TimestampOrNullConverter()
  DateTime? get movingDate;
  @override
  String? get destinyAddress;
  @override
  String? get originAddress;
  @override
  @JsonKey(ignore: true)
  _$$_MovingOrderCopyWith<_$_MovingOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
