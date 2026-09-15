// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BudgetStatus {

 Budget get budget; String get categoryName; String get categoryColor; String get categoryIcon; Money get spent; Money get remaining; double get percentUsed;
/// Create a copy of BudgetStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetStatusCopyWith<BudgetStatus> get copyWith => _$BudgetStatusCopyWithImpl<BudgetStatus>(this as BudgetStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetStatus&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryColor, categoryColor) || other.categoryColor == categoryColor)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.percentUsed, percentUsed) || other.percentUsed == percentUsed));
}


@override
int get hashCode => Object.hash(runtimeType,budget,categoryName,categoryColor,categoryIcon,spent,remaining,percentUsed);

@override
String toString() {
  return 'BudgetStatus(budget: $budget, categoryName: $categoryName, categoryColor: $categoryColor, categoryIcon: $categoryIcon, spent: $spent, remaining: $remaining, percentUsed: $percentUsed)';
}


}

/// @nodoc
abstract mixin class $BudgetStatusCopyWith<$Res>  {
  factory $BudgetStatusCopyWith(BudgetStatus value, $Res Function(BudgetStatus) _then) = _$BudgetStatusCopyWithImpl;
@useResult
$Res call({
 Budget budget, String categoryName, String categoryColor, String categoryIcon, Money spent, Money remaining, double percentUsed
});


$BudgetCopyWith<$Res> get budget;

}
/// @nodoc
class _$BudgetStatusCopyWithImpl<$Res>
    implements $BudgetStatusCopyWith<$Res> {
  _$BudgetStatusCopyWithImpl(this._self, this._then);

  final BudgetStatus _self;
  final $Res Function(BudgetStatus) _then;

/// Create a copy of BudgetStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? budget = null,Object? categoryName = null,Object? categoryColor = null,Object? categoryIcon = null,Object? spent = null,Object? remaining = null,Object? percentUsed = null,}) {
  return _then(BudgetStatus(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as Budget,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryColor: null == categoryColor ? _self.categoryColor : categoryColor // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: null == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as Money,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Money,percentUsed: null == percentUsed ? _self.percentUsed : percentUsed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of BudgetStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCopyWith<$Res> get budget {
  
  return $BudgetCopyWith<$Res>(_self.budget, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}


/// Adds pattern-matching-related methods to [BudgetStatus].
extension BudgetStatusPatterns on BudgetStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetStatus value)  $default,){
final _that = this;
switch (_that) {
case _BudgetStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetStatus value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Budget budget,  String categoryName,  String categoryColor,  String categoryIcon,  Money spent,  Money remaining,  double percentUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetStatus() when $default != null:
return $default(_that.budget,_that.categoryName,_that.categoryColor,_that.categoryIcon,_that.spent,_that.remaining,_that.percentUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Budget budget,  String categoryName,  String categoryColor,  String categoryIcon,  Money spent,  Money remaining,  double percentUsed)  $default,) {final _that = this;
switch (_that) {
case _BudgetStatus():
return $default(_that.budget,_that.categoryName,_that.categoryColor,_that.categoryIcon,_that.spent,_that.remaining,_that.percentUsed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Budget budget,  String categoryName,  String categoryColor,  String categoryIcon,  Money spent,  Money remaining,  double percentUsed)?  $default,) {final _that = this;
switch (_that) {
case _BudgetStatus() when $default != null:
return $default(_that.budget,_that.categoryName,_that.categoryColor,_that.categoryIcon,_that.spent,_that.remaining,_that.percentUsed);case _:
  return null;

}
}

}

/// @nodoc


class _BudgetStatus implements BudgetStatus {
  const _BudgetStatus({required this.budget, required this.categoryName, required this.categoryColor, required this.categoryIcon, required this.spent, required this.remaining, required this.percentUsed});
  

@override final  Budget budget;
@override final  String categoryName;
@override final  String categoryColor;
@override final  String categoryIcon;
@override final  Money spent;
@override final  Money remaining;
@override final  double percentUsed;

/// Create a copy of BudgetStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetStatusCopyWith<_BudgetStatus> get copyWith => __$BudgetStatusCopyWithImpl<_BudgetStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetStatus&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryColor, categoryColor) || other.categoryColor == categoryColor)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.percentUsed, percentUsed) || other.percentUsed == percentUsed));
}


@override
int get hashCode => Object.hash(runtimeType,budget,categoryName,categoryColor,categoryIcon,spent,remaining,percentUsed);

@override
String toString() {
  return 'BudgetStatus(budget: $budget, categoryName: $categoryName, categoryColor: $categoryColor, categoryIcon: $categoryIcon, spent: $spent, remaining: $remaining, percentUsed: $percentUsed)';
}


}

/// @nodoc
abstract mixin class _$BudgetStatusCopyWith<$Res> implements $BudgetStatusCopyWith<$Res> {
  factory _$BudgetStatusCopyWith(_BudgetStatus value, $Res Function(_BudgetStatus) _then) = __$BudgetStatusCopyWithImpl;
@override @useResult
$Res call({
 Budget budget, String categoryName, String categoryColor, String categoryIcon, Money spent, Money remaining, double percentUsed
});


@override $BudgetCopyWith<$Res> get budget;

}
/// @nodoc
class __$BudgetStatusCopyWithImpl<$Res>
    implements _$BudgetStatusCopyWith<$Res> {
  __$BudgetStatusCopyWithImpl(this._self, this._then);

  final _BudgetStatus _self;
  final $Res Function(_BudgetStatus) _then;

/// Create a copy of BudgetStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? budget = null,Object? categoryName = null,Object? categoryColor = null,Object? categoryIcon = null,Object? spent = null,Object? remaining = null,Object? percentUsed = null,}) {
  return _then(_BudgetStatus(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as Budget,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryColor: null == categoryColor ? _self.categoryColor : categoryColor // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: null == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as Money,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Money,percentUsed: null == percentUsed ? _self.percentUsed : percentUsed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of BudgetStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCopyWith<$Res> get budget {
  
  return $BudgetCopyWith<$Res>(_self.budget, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}

// dart format on
