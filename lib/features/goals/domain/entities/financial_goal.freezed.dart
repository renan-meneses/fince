// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialGoal {

 String get id; String get name; Money get targetAmount; Money get currentAmount; String get currency; DateTime? get targetDate; String? get description; GoalStatus get status; DateTime get createdAt;
/// Create a copy of FinancialGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialGoalCopyWith<FinancialGoal> get copyWith => _$FinancialGoalCopyWithImpl<FinancialGoal>(this as FinancialGoal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,targetAmount,currentAmount,currency,targetDate,description,status,createdAt);

@override
String toString() {
  return 'FinancialGoal(id: $id, name: $name, targetAmount: $targetAmount, currentAmount: $currentAmount, currency: $currency, targetDate: $targetDate, description: $description, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FinancialGoalCopyWith<$Res>  {
  factory $FinancialGoalCopyWith(FinancialGoal value, $Res Function(FinancialGoal) _then) = _$FinancialGoalCopyWithImpl;
@useResult
$Res call({
 String id, String name, Money targetAmount, Money currentAmount, String currency, DateTime? targetDate, String? description, GoalStatus status, DateTime createdAt
});




}
/// @nodoc
class _$FinancialGoalCopyWithImpl<$Res>
    implements $FinancialGoalCopyWith<$Res> {
  _$FinancialGoalCopyWithImpl(this._self, this._then);

  final FinancialGoal _self;
  final $Res Function(FinancialGoal) _then;

/// Create a copy of FinancialGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? targetAmount = null,Object? currentAmount = null,Object? currency = null,Object? targetDate = freezed,Object? description = freezed,Object? status = null,Object? createdAt = null,}) {
  return _then(FinancialGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetAmount: null == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as Money,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as Money,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialGoal].
extension FinancialGoalPatterns on FinancialGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialGoal value)  $default,){
final _that = this;
switch (_that) {
case _FinancialGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialGoal value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Money targetAmount,  Money currentAmount,  String currency,  DateTime? targetDate,  String? description,  GoalStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialGoal() when $default != null:
return $default(_that.id,_that.name,_that.targetAmount,_that.currentAmount,_that.currency,_that.targetDate,_that.description,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Money targetAmount,  Money currentAmount,  String currency,  DateTime? targetDate,  String? description,  GoalStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _FinancialGoal():
return $default(_that.id,_that.name,_that.targetAmount,_that.currentAmount,_that.currency,_that.targetDate,_that.description,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Money targetAmount,  Money currentAmount,  String currency,  DateTime? targetDate,  String? description,  GoalStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FinancialGoal() when $default != null:
return $default(_that.id,_that.name,_that.targetAmount,_that.currentAmount,_that.currency,_that.targetDate,_that.description,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialGoal implements FinancialGoal {
  const _FinancialGoal({required this.id, required this.name, required this.targetAmount, required this.currentAmount, required this.currency, this.targetDate, this.description, required this.status, required this.createdAt});
  

@override final  String id;
@override final  String name;
@override final  Money targetAmount;
@override final  Money currentAmount;
@override final  String currency;
@override final  DateTime? targetDate;
@override final  String? description;
@override final  GoalStatus status;
@override final  DateTime createdAt;

/// Create a copy of FinancialGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialGoalCopyWith<_FinancialGoal> get copyWith => __$FinancialGoalCopyWithImpl<_FinancialGoal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,targetAmount,currentAmount,currency,targetDate,description,status,createdAt);

@override
String toString() {
  return 'FinancialGoal(id: $id, name: $name, targetAmount: $targetAmount, currentAmount: $currentAmount, currency: $currency, targetDate: $targetDate, description: $description, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FinancialGoalCopyWith<$Res> implements $FinancialGoalCopyWith<$Res> {
  factory _$FinancialGoalCopyWith(_FinancialGoal value, $Res Function(_FinancialGoal) _then) = __$FinancialGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Money targetAmount, Money currentAmount, String currency, DateTime? targetDate, String? description, GoalStatus status, DateTime createdAt
});




}
/// @nodoc
class __$FinancialGoalCopyWithImpl<$Res>
    implements _$FinancialGoalCopyWith<$Res> {
  __$FinancialGoalCopyWithImpl(this._self, this._then);

  final _FinancialGoal _self;
  final $Res Function(_FinancialGoal) _then;

/// Create a copy of FinancialGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? targetAmount = null,Object? currentAmount = null,Object? currency = null,Object? targetDate = freezed,Object? description = freezed,Object? status = null,Object? createdAt = null,}) {
  return _then(_FinancialGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetAmount: null == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as Money,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as Money,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
