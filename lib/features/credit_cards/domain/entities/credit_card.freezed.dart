// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditCard {

 String get id; String get name; CardBrand get brand; Money get creditLimit; Money get availableLimit; String get currency; int get closingDay; int get dueDay; String? get linkedAccountId; DateTime get createdAt; bool get isActive;
/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCardCopyWith<CreditCard> get copyWith => _$CreditCardCopyWithImpl<CreditCard>(this as CreditCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.availableLimit, availableLimit) || other.availableLimit == availableLimit)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.closingDay, closingDay) || other.closingDay == closingDay)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.linkedAccountId, linkedAccountId) || other.linkedAccountId == linkedAccountId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,brand,creditLimit,availableLimit,currency,closingDay,dueDay,linkedAccountId,createdAt,isActive);

@override
String toString() {
  return 'CreditCard(id: $id, name: $name, brand: $brand, creditLimit: $creditLimit, availableLimit: $availableLimit, currency: $currency, closingDay: $closingDay, dueDay: $dueDay, linkedAccountId: $linkedAccountId, createdAt: $createdAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CreditCardCopyWith<$Res>  {
  factory $CreditCardCopyWith(CreditCard value, $Res Function(CreditCard) _then) = _$CreditCardCopyWithImpl;
@useResult
$Res call({
 String id, String name, CardBrand brand, Money creditLimit, Money availableLimit, String currency, int closingDay, int dueDay, String? linkedAccountId, DateTime createdAt, bool isActive
});




}
/// @nodoc
class _$CreditCardCopyWithImpl<$Res>
    implements $CreditCardCopyWith<$Res> {
  _$CreditCardCopyWithImpl(this._self, this._then);

  final CreditCard _self;
  final $Res Function(CreditCard) _then;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? brand = null,Object? creditLimit = null,Object? availableLimit = null,Object? currency = null,Object? closingDay = null,Object? dueDay = null,Object? linkedAccountId = freezed,Object? createdAt = null,Object? isActive = null,}) {
  return _then(CreditCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as CardBrand,creditLimit: null == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as Money,availableLimit: null == availableLimit ? _self.availableLimit : availableLimit // ignore: cast_nullable_to_non_nullable
as Money,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,closingDay: null == closingDay ? _self.closingDay : closingDay // ignore: cast_nullable_to_non_nullable
as int,dueDay: null == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int,linkedAccountId: freezed == linkedAccountId ? _self.linkedAccountId : linkedAccountId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditCard].
extension CreditCardPatterns on CreditCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditCard value)  $default,){
final _that = this;
switch (_that) {
case _CreditCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditCard value)?  $default,){
final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  CardBrand brand,  Money creditLimit,  Money availableLimit,  String currency,  int closingDay,  int dueDay,  String? linkedAccountId,  DateTime createdAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that.id,_that.name,_that.brand,_that.creditLimit,_that.availableLimit,_that.currency,_that.closingDay,_that.dueDay,_that.linkedAccountId,_that.createdAt,_that.isActive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  CardBrand brand,  Money creditLimit,  Money availableLimit,  String currency,  int closingDay,  int dueDay,  String? linkedAccountId,  DateTime createdAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _CreditCard():
return $default(_that.id,_that.name,_that.brand,_that.creditLimit,_that.availableLimit,_that.currency,_that.closingDay,_that.dueDay,_that.linkedAccountId,_that.createdAt,_that.isActive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  CardBrand brand,  Money creditLimit,  Money availableLimit,  String currency,  int closingDay,  int dueDay,  String? linkedAccountId,  DateTime createdAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that.id,_that.name,_that.brand,_that.creditLimit,_that.availableLimit,_that.currency,_that.closingDay,_that.dueDay,_that.linkedAccountId,_that.createdAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _CreditCard implements CreditCard {
  const _CreditCard({required this.id, required this.name, required this.brand, required this.creditLimit, required this.availableLimit, required this.currency, required this.closingDay, required this.dueDay, this.linkedAccountId, required this.createdAt, required this.isActive});
  

@override final  String id;
@override final  String name;
@override final  CardBrand brand;
@override final  Money creditLimit;
@override final  Money availableLimit;
@override final  String currency;
@override final  int closingDay;
@override final  int dueDay;
@override final  String? linkedAccountId;
@override final  DateTime createdAt;
@override final  bool isActive;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditCardCopyWith<_CreditCard> get copyWith => __$CreditCardCopyWithImpl<_CreditCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.availableLimit, availableLimit) || other.availableLimit == availableLimit)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.closingDay, closingDay) || other.closingDay == closingDay)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.linkedAccountId, linkedAccountId) || other.linkedAccountId == linkedAccountId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,brand,creditLimit,availableLimit,currency,closingDay,dueDay,linkedAccountId,createdAt,isActive);

@override
String toString() {
  return 'CreditCard(id: $id, name: $name, brand: $brand, creditLimit: $creditLimit, availableLimit: $availableLimit, currency: $currency, closingDay: $closingDay, dueDay: $dueDay, linkedAccountId: $linkedAccountId, createdAt: $createdAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CreditCardCopyWith<$Res> implements $CreditCardCopyWith<$Res> {
  factory _$CreditCardCopyWith(_CreditCard value, $Res Function(_CreditCard) _then) = __$CreditCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, CardBrand brand, Money creditLimit, Money availableLimit, String currency, int closingDay, int dueDay, String? linkedAccountId, DateTime createdAt, bool isActive
});




}
/// @nodoc
class __$CreditCardCopyWithImpl<$Res>
    implements _$CreditCardCopyWith<$Res> {
  __$CreditCardCopyWithImpl(this._self, this._then);

  final _CreditCard _self;
  final $Res Function(_CreditCard) _then;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? brand = null,Object? creditLimit = null,Object? availableLimit = null,Object? currency = null,Object? closingDay = null,Object? dueDay = null,Object? linkedAccountId = freezed,Object? createdAt = null,Object? isActive = null,}) {
  return _then(_CreditCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as CardBrand,creditLimit: null == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as Money,availableLimit: null == availableLimit ? _self.availableLimit : availableLimit // ignore: cast_nullable_to_non_nullable
as Money,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,closingDay: null == closingDay ? _self.closingDay : closingDay // ignore: cast_nullable_to_non_nullable
as int,dueDay: null == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int,linkedAccountId: freezed == linkedAccountId ? _self.linkedAccountId : linkedAccountId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
