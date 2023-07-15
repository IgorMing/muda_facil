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
  OrderStatus get status => throw _privateConstructorUsedError;
  bool? get flexibleMovingDate => throw _privateConstructorUsedError;
  @TimestampOrNullConverter()
  DateTime? get movingDate => throw _privateConstructorUsedError;
  @TimestampOrNullConverter()
  DateTime? get orderSentDate => throw _privateConstructorUsedError;
  String? get destinyAddress => throw _privateConstructorUsedError;
  String? get originAddress => throw _privateConstructorUsedError;
  String? get pixCode => throw _privateConstructorUsedError;
  String? get helpNeeded => throw _privateConstructorUsedError;
  String? get declineReason => throw _privateConstructorUsedError;
  String? get driverName => throw _privateConstructorUsedError;
  double? get budgetValue => throw _privateConstructorUsedError;

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
      OrderStatus status,
      bool? flexibleMovingDate,
      @TimestampOrNullConverter() DateTime? movingDate,
      @TimestampOrNullConverter() DateTime? orderSentDate,
      String? destinyAddress,
      String? originAddress,
      String? pixCode,
      String? helpNeeded,
      String? declineReason,
      String? driverName,
      double? budgetValue});
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
    Object? status = null,
    Object? flexibleMovingDate = freezed,
    Object? movingDate = freezed,
    Object? orderSentDate = freezed,
    Object? destinyAddress = freezed,
    Object? originAddress = freezed,
    Object? pixCode = freezed,
    Object? helpNeeded = freezed,
    Object? declineReason = freezed,
    Object? driverName = freezed,
    Object? budgetValue = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      flexibleMovingDate: freezed == flexibleMovingDate
          ? _value.flexibleMovingDate
          : flexibleMovingDate // ignore: cast_nullable_to_non_nullable
              as bool?,
      movingDate: freezed == movingDate
          ? _value.movingDate
          : movingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderSentDate: freezed == orderSentDate
          ? _value.orderSentDate
          : orderSentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      destinyAddress: freezed == destinyAddress
          ? _value.destinyAddress
          : destinyAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      originAddress: freezed == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      pixCode: freezed == pixCode
          ? _value.pixCode
          : pixCode // ignore: cast_nullable_to_non_nullable
              as String?,
      helpNeeded: freezed == helpNeeded
          ? _value.helpNeeded
          : helpNeeded // ignore: cast_nullable_to_non_nullable
              as String?,
      declineReason: freezed == declineReason
          ? _value.declineReason
          : declineReason // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetValue: freezed == budgetValue
          ? _value.budgetValue
          : budgetValue // ignore: cast_nullable_to_non_nullable
              as double?,
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
      OrderStatus status,
      bool? flexibleMovingDate,
      @TimestampOrNullConverter() DateTime? movingDate,
      @TimestampOrNullConverter() DateTime? orderSentDate,
      String? destinyAddress,
      String? originAddress,
      String? pixCode,
      String? helpNeeded,
      String? declineReason,
      String? driverName,
      double? budgetValue});
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
    Object? status = null,
    Object? flexibleMovingDate = freezed,
    Object? movingDate = freezed,
    Object? orderSentDate = freezed,
    Object? destinyAddress = freezed,
    Object? originAddress = freezed,
    Object? pixCode = freezed,
    Object? helpNeeded = freezed,
    Object? declineReason = freezed,
    Object? driverName = freezed,
    Object? budgetValue = freezed,
  }) {
    return _then(_$_MovingOrder(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      flexibleMovingDate: freezed == flexibleMovingDate
          ? _value.flexibleMovingDate
          : flexibleMovingDate // ignore: cast_nullable_to_non_nullable
              as bool?,
      movingDate: freezed == movingDate
          ? _value.movingDate
          : movingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderSentDate: freezed == orderSentDate
          ? _value.orderSentDate
          : orderSentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      destinyAddress: freezed == destinyAddress
          ? _value.destinyAddress
          : destinyAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      originAddress: freezed == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      pixCode: freezed == pixCode
          ? _value.pixCode
          : pixCode // ignore: cast_nullable_to_non_nullable
              as String?,
      helpNeeded: freezed == helpNeeded
          ? _value.helpNeeded
          : helpNeeded // ignore: cast_nullable_to_non_nullable
              as String?,
      declineReason: freezed == declineReason
          ? _value.declineReason
          : declineReason // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetValue: freezed == budgetValue
          ? _value.budgetValue
          : budgetValue // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$_MovingOrder implements _MovingOrder {
  const _$_MovingOrder(
      {final List<Item> items = const [],
      required this.status,
      this.flexibleMovingDate,
      @TimestampOrNullConverter() this.movingDate,
      @TimestampOrNullConverter() this.orderSentDate,
      this.destinyAddress,
      this.originAddress,
      this.pixCode,
      this.helpNeeded,
      this.declineReason,
      this.driverName,
      this.budgetValue})
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
  final OrderStatus status;
  @override
  final bool? flexibleMovingDate;
  @override
  @TimestampOrNullConverter()
  final DateTime? movingDate;
  @override
  @TimestampOrNullConverter()
  final DateTime? orderSentDate;
  @override
  final String? destinyAddress;
  @override
  final String? originAddress;
  @override
  final String? pixCode;
  @override
  final String? helpNeeded;
  @override
  final String? declineReason;
  @override
  final String? driverName;
  @override
  final double? budgetValue;

  @override
  String toString() {
    return 'MovingOrder(items: $items, status: $status, flexibleMovingDate: $flexibleMovingDate, movingDate: $movingDate, orderSentDate: $orderSentDate, destinyAddress: $destinyAddress, originAddress: $originAddress, pixCode: $pixCode, helpNeeded: $helpNeeded, declineReason: $declineReason, driverName: $driverName, budgetValue: $budgetValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovingOrder &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.flexibleMovingDate, flexibleMovingDate) ||
                other.flexibleMovingDate == flexibleMovingDate) &&
            (identical(other.movingDate, movingDate) ||
                other.movingDate == movingDate) &&
            (identical(other.orderSentDate, orderSentDate) ||
                other.orderSentDate == orderSentDate) &&
            (identical(other.destinyAddress, destinyAddress) ||
                other.destinyAddress == destinyAddress) &&
            (identical(other.originAddress, originAddress) ||
                other.originAddress == originAddress) &&
            (identical(other.pixCode, pixCode) || other.pixCode == pixCode) &&
            (identical(other.helpNeeded, helpNeeded) ||
                other.helpNeeded == helpNeeded) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.budgetValue, budgetValue) ||
                other.budgetValue == budgetValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      status,
      flexibleMovingDate,
      movingDate,
      orderSentDate,
      destinyAddress,
      originAddress,
      pixCode,
      helpNeeded,
      declineReason,
      driverName,
      budgetValue);

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
      required final OrderStatus status,
      final bool? flexibleMovingDate,
      @TimestampOrNullConverter() final DateTime? movingDate,
      @TimestampOrNullConverter() final DateTime? orderSentDate,
      final String? destinyAddress,
      final String? originAddress,
      final String? pixCode,
      final String? helpNeeded,
      final String? declineReason,
      final String? driverName,
      final double? budgetValue}) = _$_MovingOrder;

  factory _MovingOrder.fromJson(Map<String, dynamic> json) =
      _$_MovingOrder.fromJson;

  @override
  List<Item> get items;
  @override
  OrderStatus get status;
  @override
  bool? get flexibleMovingDate;
  @override
  @TimestampOrNullConverter()
  DateTime? get movingDate;
  @override
  @TimestampOrNullConverter()
  DateTime? get orderSentDate;
  @override
  String? get destinyAddress;
  @override
  String? get originAddress;
  @override
  String? get pixCode;
  @override
  String? get helpNeeded;
  @override
  String? get declineReason;
  @override
  String? get driverName;
  @override
  double? get budgetValue;
  @override
  @JsonKey(ignore: true)
  _$$_MovingOrderCopyWith<_$_MovingOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
