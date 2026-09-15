// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insights_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InsightsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsightsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InsightsState()';
}


}

/// @nodoc
class $InsightsStateCopyWith<$Res>  {
$InsightsStateCopyWith(InsightsState _, $Res Function(InsightsState) __);
}


/// Adds pattern-matching-related methods to [InsightsState].
extension InsightsStatePatterns on InsightsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InsightsLoading value)?  loading,TResult Function( InsightsLoaded value)?  loaded,TResult Function( InsightsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InsightsLoading() when loading != null:
return loading(_that);case InsightsLoaded() when loaded != null:
return loaded(_that);case InsightsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InsightsLoading value)  loading,required TResult Function( InsightsLoaded value)  loaded,required TResult Function( InsightsFailure value)  failure,}){
final _that = this;
switch (_that) {
case InsightsLoading():
return loading(_that);case InsightsLoaded():
return loaded(_that);case InsightsFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InsightsLoading value)?  loading,TResult? Function( InsightsLoaded value)?  loaded,TResult? Function( InsightsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case InsightsLoading() when loading != null:
return loading(_that);case InsightsLoaded() when loaded != null:
return loaded(_that);case InsightsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<FinancialInsight> insights)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InsightsLoading() when loading != null:
return loading();case InsightsLoaded() when loaded != null:
return loaded(_that.insights);case InsightsFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<FinancialInsight> insights)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case InsightsLoading():
return loading();case InsightsLoaded():
return loaded(_that.insights);case InsightsFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<FinancialInsight> insights)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case InsightsLoading() when loading != null:
return loading();case InsightsLoaded() when loaded != null:
return loaded(_that.insights);case InsightsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class InsightsLoading implements InsightsState {
  const InsightsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsightsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InsightsState.loading()';
}


}




/// @nodoc


class InsightsLoaded implements InsightsState {
  const InsightsLoaded( List<FinancialInsight> insights): _insights = insights;
  

 final  List<FinancialInsight> _insights;
 List<FinancialInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}


/// Create a copy of InsightsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightsLoadedCopyWith<InsightsLoaded> get copyWith => _$InsightsLoadedCopyWithImpl<InsightsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsightsLoaded&&const DeepCollectionEquality().equals(other._insights, _insights));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_insights));

@override
String toString() {
  return 'InsightsState.loaded(insights: $insights)';
}


}

/// @nodoc
abstract mixin class $InsightsLoadedCopyWith<$Res> implements $InsightsStateCopyWith<$Res> {
  factory $InsightsLoadedCopyWith(InsightsLoaded value, $Res Function(InsightsLoaded) _then) = _$InsightsLoadedCopyWithImpl;
@useResult
$Res call({
 List<FinancialInsight> insights
});




}
/// @nodoc
class _$InsightsLoadedCopyWithImpl<$Res>
    implements $InsightsLoadedCopyWith<$Res> {
  _$InsightsLoadedCopyWithImpl(this._self, this._then);

  final InsightsLoaded _self;
  final $Res Function(InsightsLoaded) _then;

/// Create a copy of InsightsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? insights = null,}) {
  return _then(InsightsLoaded(
null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<FinancialInsight>,
  ));
}


}

/// @nodoc


class InsightsFailure implements InsightsState {
  const InsightsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of InsightsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightsFailureCopyWith<InsightsFailure> get copyWith => _$InsightsFailureCopyWithImpl<InsightsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsightsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'InsightsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $InsightsFailureCopyWith<$Res> implements $InsightsStateCopyWith<$Res> {
  factory $InsightsFailureCopyWith(InsightsFailure value, $Res Function(InsightsFailure) _then) = _$InsightsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$InsightsFailureCopyWithImpl<$Res>
    implements $InsightsFailureCopyWith<$Res> {
  _$InsightsFailureCopyWithImpl(this._self, this._then);

  final InsightsFailure _self;
  final $Res Function(InsightsFailure) _then;

/// Create a copy of InsightsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(InsightsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
