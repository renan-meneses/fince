// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialInsight {

 String get id; String get type; String get title; String get message; InsightSeverity get severity; String get period; DateTime get createdAt; bool get isRead;
/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialInsightCopyWith<FinancialInsight> get copyWith => _$FinancialInsightCopyWithImpl<FinancialInsight>(this as FinancialInsight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialInsight&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.period, period) || other.period == period)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,message,severity,period,createdAt,isRead);

@override
String toString() {
  return 'FinancialInsight(id: $id, type: $type, title: $title, message: $message, severity: $severity, period: $period, createdAt: $createdAt, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class $FinancialInsightCopyWith<$Res>  {
  factory $FinancialInsightCopyWith(FinancialInsight value, $Res Function(FinancialInsight) _then) = _$FinancialInsightCopyWithImpl;
@useResult
$Res call({
 String id, String type, String title, String message, InsightSeverity severity, String period, DateTime createdAt, bool isRead
});




}
/// @nodoc
class _$FinancialInsightCopyWithImpl<$Res>
    implements $FinancialInsightCopyWith<$Res> {
  _$FinancialInsightCopyWithImpl(this._self, this._then);

  final FinancialInsight _self;
  final $Res Function(FinancialInsight) _then;

/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? message = null,Object? severity = null,Object? period = null,Object? createdAt = null,Object? isRead = null,}) {
  return _then(FinancialInsight(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as InsightSeverity,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialInsight].
extension FinancialInsightPatterns on FinancialInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialInsight value)  $default,){
final _that = this;
switch (_that) {
case _FinancialInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialInsight value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String message,  InsightSeverity severity,  String period,  DateTime createdAt,  bool isRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.message,_that.severity,_that.period,_that.createdAt,_that.isRead);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String message,  InsightSeverity severity,  String period,  DateTime createdAt,  bool isRead)  $default,) {final _that = this;
switch (_that) {
case _FinancialInsight():
return $default(_that.id,_that.type,_that.title,_that.message,_that.severity,_that.period,_that.createdAt,_that.isRead);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String title,  String message,  InsightSeverity severity,  String period,  DateTime createdAt,  bool isRead)?  $default,) {final _that = this;
switch (_that) {
case _FinancialInsight() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.message,_that.severity,_that.period,_that.createdAt,_that.isRead);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialInsight implements FinancialInsight {
  const _FinancialInsight({required this.id, required this.type, required this.title, required this.message, required this.severity, required this.period, required this.createdAt, required this.isRead});
  

@override final  String id;
@override final  String type;
@override final  String title;
@override final  String message;
@override final  InsightSeverity severity;
@override final  String period;
@override final  DateTime createdAt;
@override final  bool isRead;

/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialInsightCopyWith<_FinancialInsight> get copyWith => __$FinancialInsightCopyWithImpl<_FinancialInsight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialInsight&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.period, period) || other.period == period)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,message,severity,period,createdAt,isRead);

@override
String toString() {
  return 'FinancialInsight(id: $id, type: $type, title: $title, message: $message, severity: $severity, period: $period, createdAt: $createdAt, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class _$FinancialInsightCopyWith<$Res> implements $FinancialInsightCopyWith<$Res> {
  factory _$FinancialInsightCopyWith(_FinancialInsight value, $Res Function(_FinancialInsight) _then) = __$FinancialInsightCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String title, String message, InsightSeverity severity, String period, DateTime createdAt, bool isRead
});




}
/// @nodoc
class __$FinancialInsightCopyWithImpl<$Res>
    implements _$FinancialInsightCopyWith<$Res> {
  __$FinancialInsightCopyWithImpl(this._self, this._then);

  final _FinancialInsight _self;
  final $Res Function(_FinancialInsight) _then;

/// Create a copy of FinancialInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? message = null,Object? severity = null,Object? period = null,Object? createdAt = null,Object? isRead = null,}) {
  return _then(_FinancialInsight(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as InsightSeverity,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
