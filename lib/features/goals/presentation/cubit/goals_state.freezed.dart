// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goals_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GoalsState()';
}


}

/// @nodoc
class $GoalsStateCopyWith<$Res>  {
$GoalsStateCopyWith(GoalsState _, $Res Function(GoalsState) __);
}


/// Adds pattern-matching-related methods to [GoalsState].
extension GoalsStatePatterns on GoalsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GoalsLoading value)?  loading,TResult Function( GoalsLoaded value)?  loaded,TResult Function( GoalsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GoalsLoading() when loading != null:
return loading(_that);case GoalsLoaded() when loaded != null:
return loaded(_that);case GoalsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GoalsLoading value)  loading,required TResult Function( GoalsLoaded value)  loaded,required TResult Function( GoalsFailure value)  failure,}){
final _that = this;
switch (_that) {
case GoalsLoading():
return loading(_that);case GoalsLoaded():
return loaded(_that);case GoalsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GoalsLoading value)?  loading,TResult? Function( GoalsLoaded value)?  loaded,TResult? Function( GoalsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case GoalsLoading() when loading != null:
return loading(_that);case GoalsLoaded() when loaded != null:
return loaded(_that);case GoalsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<FinancialGoal> goals)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GoalsLoading() when loading != null:
return loading();case GoalsLoaded() when loaded != null:
return loaded(_that.goals);case GoalsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<FinancialGoal> goals)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case GoalsLoading():
return loading();case GoalsLoaded():
return loaded(_that.goals);case GoalsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<FinancialGoal> goals)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case GoalsLoading() when loading != null:
return loading();case GoalsLoaded() when loaded != null:
return loaded(_that.goals);case GoalsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class GoalsLoading implements GoalsState {
  const GoalsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GoalsState.loading()';
}


}




/// @nodoc


class GoalsLoaded implements GoalsState {
  const GoalsLoaded( List<FinancialGoal> goals): _goals = goals;
  

 final  List<FinancialGoal> _goals;
 List<FinancialGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}


/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalsLoadedCopyWith<GoalsLoaded> get copyWith => _$GoalsLoadedCopyWithImpl<GoalsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsLoaded&&const DeepCollectionEquality().equals(other._goals, _goals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_goals));

@override
String toString() {
  return 'GoalsState.loaded(goals: $goals)';
}


}

/// @nodoc
abstract mixin class $GoalsLoadedCopyWith<$Res> implements $GoalsStateCopyWith<$Res> {
  factory $GoalsLoadedCopyWith(GoalsLoaded value, $Res Function(GoalsLoaded) _then) = _$GoalsLoadedCopyWithImpl;
@useResult
$Res call({
 List<FinancialGoal> goals
});




}
/// @nodoc
class _$GoalsLoadedCopyWithImpl<$Res>
    implements $GoalsLoadedCopyWith<$Res> {
  _$GoalsLoadedCopyWithImpl(this._self, this._then);

  final GoalsLoaded _self;
  final $Res Function(GoalsLoaded) _then;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? goals = null,}) {
  return _then(GoalsLoaded(
null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<FinancialGoal>,
  ));
}


}

/// @nodoc


class GoalsFailure implements GoalsState {
  const GoalsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalsFailureCopyWith<GoalsFailure> get copyWith => _$GoalsFailureCopyWithImpl<GoalsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'GoalsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $GoalsFailureCopyWith<$Res> implements $GoalsStateCopyWith<$Res> {
  factory $GoalsFailureCopyWith(GoalsFailure value, $Res Function(GoalsFailure) _then) = _$GoalsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$GoalsFailureCopyWithImpl<$Res>
    implements $GoalsFailureCopyWith<$Res> {
  _$GoalsFailureCopyWithImpl(this._self, this._then);

  final GoalsFailure _self;
  final $Res Function(GoalsFailure) _then;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(GoalsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
