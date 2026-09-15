// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsData {

 IncomeExpenseReport get summary; List<CashFlowPoint> get cashFlow; List<CategoryReport> get byCategory; List<AccountReport> get byAccount;
/// Create a copy of ReportsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsDataCopyWith<ReportsData> get copyWith => _$ReportsDataCopyWithImpl<ReportsData>(this as ReportsData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsData&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.cashFlow, cashFlow)&&const DeepCollectionEquality().equals(other.byCategory, byCategory)&&const DeepCollectionEquality().equals(other.byAccount, byAccount));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(cashFlow),const DeepCollectionEquality().hash(byCategory),const DeepCollectionEquality().hash(byAccount));

@override
String toString() {
  return 'ReportsData(summary: $summary, cashFlow: $cashFlow, byCategory: $byCategory, byAccount: $byAccount)';
}


}

/// @nodoc
abstract mixin class $ReportsDataCopyWith<$Res>  {
  factory $ReportsDataCopyWith(ReportsData value, $Res Function(ReportsData) _then) = _$ReportsDataCopyWithImpl;
@useResult
$Res call({
 IncomeExpenseReport summary, List<CashFlowPoint> cashFlow, List<CategoryReport> byCategory, List<AccountReport> byAccount
});


$IncomeExpenseReportCopyWith<$Res> get summary;

}
/// @nodoc
class _$ReportsDataCopyWithImpl<$Res>
    implements $ReportsDataCopyWith<$Res> {
  _$ReportsDataCopyWithImpl(this._self, this._then);

  final ReportsData _self;
  final $Res Function(ReportsData) _then;

/// Create a copy of ReportsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? cashFlow = null,Object? byCategory = null,Object? byAccount = null,}) {
  return _then(ReportsData(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as IncomeExpenseReport,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as List<CashFlowPoint>,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryReport>,byAccount: null == byAccount ? _self.byAccount : byAccount // ignore: cast_nullable_to_non_nullable
as List<AccountReport>,
  ));
}
/// Create a copy of ReportsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomeExpenseReportCopyWith<$Res> get summary {
  
  return $IncomeExpenseReportCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportsData].
extension ReportsDataPatterns on ReportsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsData value)  $default,){
final _that = this;
switch (_that) {
case _ReportsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsData value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IncomeExpenseReport summary,  List<CashFlowPoint> cashFlow,  List<CategoryReport> byCategory,  List<AccountReport> byAccount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsData() when $default != null:
return $default(_that.summary,_that.cashFlow,_that.byCategory,_that.byAccount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IncomeExpenseReport summary,  List<CashFlowPoint> cashFlow,  List<CategoryReport> byCategory,  List<AccountReport> byAccount)  $default,) {final _that = this;
switch (_that) {
case _ReportsData():
return $default(_that.summary,_that.cashFlow,_that.byCategory,_that.byAccount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IncomeExpenseReport summary,  List<CashFlowPoint> cashFlow,  List<CategoryReport> byCategory,  List<AccountReport> byAccount)?  $default,) {final _that = this;
switch (_that) {
case _ReportsData() when $default != null:
return $default(_that.summary,_that.cashFlow,_that.byCategory,_that.byAccount);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsData implements ReportsData {
  const _ReportsData({required this.summary, required  List<CashFlowPoint> cashFlow, required  List<CategoryReport> byCategory, required  List<AccountReport> byAccount}): _cashFlow = cashFlow,_byCategory = byCategory,_byAccount = byAccount;
  

@override final  IncomeExpenseReport summary;
 final  List<CashFlowPoint> _cashFlow;
@override List<CashFlowPoint> get cashFlow {
  if (_cashFlow is EqualUnmodifiableListView) return _cashFlow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cashFlow);
}

 final  List<CategoryReport> _byCategory;
@override List<CategoryReport> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}

 final  List<AccountReport> _byAccount;
@override List<AccountReport> get byAccount {
  if (_byAccount is EqualUnmodifiableListView) return _byAccount;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byAccount);
}


/// Create a copy of ReportsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsDataCopyWith<_ReportsData> get copyWith => __$ReportsDataCopyWithImpl<_ReportsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsData&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._cashFlow, _cashFlow)&&const DeepCollectionEquality().equals(other._byCategory, _byCategory)&&const DeepCollectionEquality().equals(other._byAccount, _byAccount));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_cashFlow),const DeepCollectionEquality().hash(_byCategory),const DeepCollectionEquality().hash(_byAccount));

@override
String toString() {
  return 'ReportsData(summary: $summary, cashFlow: $cashFlow, byCategory: $byCategory, byAccount: $byAccount)';
}


}

/// @nodoc
abstract mixin class _$ReportsDataCopyWith<$Res> implements $ReportsDataCopyWith<$Res> {
  factory _$ReportsDataCopyWith(_ReportsData value, $Res Function(_ReportsData) _then) = __$ReportsDataCopyWithImpl;
@override @useResult
$Res call({
 IncomeExpenseReport summary, List<CashFlowPoint> cashFlow, List<CategoryReport> byCategory, List<AccountReport> byAccount
});


@override $IncomeExpenseReportCopyWith<$Res> get summary;

}
/// @nodoc
class __$ReportsDataCopyWithImpl<$Res>
    implements _$ReportsDataCopyWith<$Res> {
  __$ReportsDataCopyWithImpl(this._self, this._then);

  final _ReportsData _self;
  final $Res Function(_ReportsData) _then;

/// Create a copy of ReportsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? cashFlow = null,Object? byCategory = null,Object? byAccount = null,}) {
  return _then(_ReportsData(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as IncomeExpenseReport,cashFlow: null == cashFlow ? _self._cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as List<CashFlowPoint>,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryReport>,byAccount: null == byAccount ? _self._byAccount : byAccount // ignore: cast_nullable_to_non_nullable
as List<AccountReport>,
  ));
}

/// Create a copy of ReportsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomeExpenseReportCopyWith<$Res> get summary {
  
  return $IncomeExpenseReportCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$ReportsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState()';
}


}

/// @nodoc
class $ReportsStateCopyWith<$Res>  {
$ReportsStateCopyWith(ReportsState _, $Res Function(ReportsState) __);
}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReportsLoading value)?  loading,TResult Function( ReportsLoaded value)?  loaded,TResult Function( ReportsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReportsLoading value)  loading,required TResult Function( ReportsLoaded value)  loaded,required TResult Function( ReportsFailure value)  failure,}){
final _that = this;
switch (_that) {
case ReportsLoading():
return loading(_that);case ReportsLoaded():
return loaded(_that);case ReportsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReportsLoading value)?  loading,TResult? Function( ReportsLoaded value)?  loaded,TResult? Function( ReportsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( ReportsData data)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.data);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( ReportsData data)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ReportsLoading():
return loading();case ReportsLoaded():
return loaded(_that.data);case ReportsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( ReportsData data)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.data);case ReportsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ReportsLoading implements ReportsState {
  const ReportsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.loading()';
}


}




/// @nodoc


class ReportsLoaded implements ReportsState {
  const ReportsLoaded(this.data);
  

 final  ReportsData data;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsLoadedCopyWith<ReportsLoaded> get copyWith => _$ReportsLoadedCopyWithImpl<ReportsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ReportsState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $ReportsLoadedCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsLoadedCopyWith(ReportsLoaded value, $Res Function(ReportsLoaded) _then) = _$ReportsLoadedCopyWithImpl;
@useResult
$Res call({
 ReportsData data
});


$ReportsDataCopyWith<$Res> get data;

}
/// @nodoc
class _$ReportsLoadedCopyWithImpl<$Res>
    implements $ReportsLoadedCopyWith<$Res> {
  _$ReportsLoadedCopyWithImpl(this._self, this._then);

  final ReportsLoaded _self;
  final $Res Function(ReportsLoaded) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ReportsLoaded(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ReportsData,
  ));
}

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportsDataCopyWith<$Res> get data {
  
  return $ReportsDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ReportsFailure implements ReportsState {
  const ReportsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFailureCopyWith<ReportsFailure> get copyWith => _$ReportsFailureCopyWithImpl<ReportsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ReportsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ReportsFailureCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsFailureCopyWith(ReportsFailure value, $Res Function(ReportsFailure) _then) = _$ReportsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ReportsFailureCopyWithImpl<$Res>
    implements $ReportsFailureCopyWith<$Res> {
  _$ReportsFailureCopyWithImpl(this._self, this._then);

  final ReportsFailure _self;
  final $Res Function(ReportsFailure) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ReportsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
