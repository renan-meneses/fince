// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState()';
}


}

/// @nodoc
class $DashboardStateCopyWith<$Res>  {
$DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DashboardLoading value)?  loading,TResult Function( DashboardLoaded value)?  loaded,TResult Function( DashboardFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DashboardLoading() when loading != null:
return loading(_that);case DashboardLoaded() when loaded != null:
return loaded(_that);case DashboardFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DashboardLoading value)  loading,required TResult Function( DashboardLoaded value)  loaded,required TResult Function( DashboardFailure value)  failure,}){
final _that = this;
switch (_that) {
case DashboardLoading():
return loading(_that);case DashboardLoaded():
return loaded(_that);case DashboardFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DashboardLoading value)?  loading,TResult? Function( DashboardLoaded value)?  loaded,TResult? Function( DashboardFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DashboardLoading() when loading != null:
return loading(_that);case DashboardLoaded() when loaded != null:
return loaded(_that);case DashboardFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( FinancialOverview overview)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DashboardLoading() when loading != null:
return loading();case DashboardLoaded() when loaded != null:
return loaded(_that.overview);case DashboardFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( FinancialOverview overview)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case DashboardLoading():
return loading();case DashboardLoaded():
return loaded(_that.overview);case DashboardFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( FinancialOverview overview)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case DashboardLoading() when loading != null:
return loading();case DashboardLoaded() when loaded != null:
return loaded(_that.overview);case DashboardFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class DashboardLoading implements DashboardState {
  const DashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.loading()';
}


}




/// @nodoc


class DashboardLoaded implements DashboardState {
  const DashboardLoaded(this.overview);
  

 final  FinancialOverview overview;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardLoadedCopyWith<DashboardLoaded> get copyWith => _$DashboardLoadedCopyWithImpl<DashboardLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardLoaded&&(identical(other.overview, overview) || other.overview == overview));
}


@override
int get hashCode => Object.hash(runtimeType,overview);

@override
String toString() {
  return 'DashboardState.loaded(overview: $overview)';
}


}

/// @nodoc
abstract mixin class $DashboardLoadedCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory $DashboardLoadedCopyWith(DashboardLoaded value, $Res Function(DashboardLoaded) _then) = _$DashboardLoadedCopyWithImpl;
@useResult
$Res call({
 FinancialOverview overview
});


$FinancialOverviewCopyWith<$Res> get overview;

}
/// @nodoc
class _$DashboardLoadedCopyWithImpl<$Res>
    implements $DashboardLoadedCopyWith<$Res> {
  _$DashboardLoadedCopyWithImpl(this._self, this._then);

  final DashboardLoaded _self;
  final $Res Function(DashboardLoaded) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? overview = null,}) {
  return _then(DashboardLoaded(
null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as FinancialOverview,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialOverviewCopyWith<$Res> get overview {
  
  return $FinancialOverviewCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}
}

/// @nodoc


class DashboardFailure implements DashboardState {
  const DashboardFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardFailureCopyWith<DashboardFailure> get copyWith => _$DashboardFailureCopyWithImpl<DashboardFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'DashboardState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DashboardFailureCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory $DashboardFailureCopyWith(DashboardFailure value, $Res Function(DashboardFailure) _then) = _$DashboardFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$DashboardFailureCopyWithImpl<$Res>
    implements $DashboardFailureCopyWith<$Res> {
  _$DashboardFailureCopyWithImpl(this._self, this._then);

  final DashboardFailure _self;
  final $Res Function(DashboardFailure) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(DashboardFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
