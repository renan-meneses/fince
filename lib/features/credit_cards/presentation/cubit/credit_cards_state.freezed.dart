// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_cards_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditCardsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCardsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreditCardsState()';
}


}

/// @nodoc
class $CreditCardsStateCopyWith<$Res>  {
$CreditCardsStateCopyWith(CreditCardsState _, $Res Function(CreditCardsState) __);
}


/// Adds pattern-matching-related methods to [CreditCardsState].
extension CreditCardsStatePatterns on CreditCardsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreditCardsLoading value)?  loading,TResult Function( CreditCardsLoaded value)?  loaded,TResult Function( CreditCardsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreditCardsLoading() when loading != null:
return loading(_that);case CreditCardsLoaded() when loaded != null:
return loaded(_that);case CreditCardsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreditCardsLoading value)  loading,required TResult Function( CreditCardsLoaded value)  loaded,required TResult Function( CreditCardsFailure value)  failure,}){
final _that = this;
switch (_that) {
case CreditCardsLoading():
return loading(_that);case CreditCardsLoaded():
return loaded(_that);case CreditCardsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreditCardsLoading value)?  loading,TResult? Function( CreditCardsLoaded value)?  loaded,TResult? Function( CreditCardsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CreditCardsLoading() when loading != null:
return loading(_that);case CreditCardsLoaded() when loaded != null:
return loaded(_that);case CreditCardsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<CreditCard> cards)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreditCardsLoading() when loading != null:
return loading();case CreditCardsLoaded() when loaded != null:
return loaded(_that.cards);case CreditCardsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<CreditCard> cards)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case CreditCardsLoading():
return loading();case CreditCardsLoaded():
return loaded(_that.cards);case CreditCardsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<CreditCard> cards)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case CreditCardsLoading() when loading != null:
return loading();case CreditCardsLoaded() when loaded != null:
return loaded(_that.cards);case CreditCardsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class CreditCardsLoading implements CreditCardsState {
  const CreditCardsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCardsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreditCardsState.loading()';
}


}




/// @nodoc


class CreditCardsLoaded implements CreditCardsState {
  const CreditCardsLoaded( List<CreditCard> cards): _cards = cards;
  

 final  List<CreditCard> _cards;
 List<CreditCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of CreditCardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCardsLoadedCopyWith<CreditCardsLoaded> get copyWith => _$CreditCardsLoadedCopyWithImpl<CreditCardsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCardsLoaded&&const DeepCollectionEquality().equals(other._cards, _cards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'CreditCardsState.loaded(cards: $cards)';
}


}

/// @nodoc
abstract mixin class $CreditCardsLoadedCopyWith<$Res> implements $CreditCardsStateCopyWith<$Res> {
  factory $CreditCardsLoadedCopyWith(CreditCardsLoaded value, $Res Function(CreditCardsLoaded) _then) = _$CreditCardsLoadedCopyWithImpl;
@useResult
$Res call({
 List<CreditCard> cards
});




}
/// @nodoc
class _$CreditCardsLoadedCopyWithImpl<$Res>
    implements $CreditCardsLoadedCopyWith<$Res> {
  _$CreditCardsLoadedCopyWithImpl(this._self, this._then);

  final CreditCardsLoaded _self;
  final $Res Function(CreditCardsLoaded) _then;

/// Create a copy of CreditCardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cards = null,}) {
  return _then(CreditCardsLoaded(
null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CreditCard>,
  ));
}


}

/// @nodoc


class CreditCardsFailure implements CreditCardsState {
  const CreditCardsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of CreditCardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCardsFailureCopyWith<CreditCardsFailure> get copyWith => _$CreditCardsFailureCopyWithImpl<CreditCardsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCardsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CreditCardsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CreditCardsFailureCopyWith<$Res> implements $CreditCardsStateCopyWith<$Res> {
  factory $CreditCardsFailureCopyWith(CreditCardsFailure value, $Res Function(CreditCardsFailure) _then) = _$CreditCardsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$CreditCardsFailureCopyWithImpl<$Res>
    implements $CreditCardsFailureCopyWith<$Res> {
  _$CreditCardsFailureCopyWithImpl(this._self, this._then);

  final CreditCardsFailure _self;
  final $Res Function(CreditCardsFailure) _then;

/// Create a copy of CreditCardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(CreditCardsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
