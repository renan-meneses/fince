// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurrenceRule {

 RecurrenceFrequency get frequency; int get interval; int? get dayOfMonth; List<int> get daysOfWeek;
/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurrenceRuleCopyWith<RecurrenceRule> get copyWith => _$RecurrenceRuleCopyWithImpl<RecurrenceRule>(this as RecurrenceRule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurrenceRule&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&const DeepCollectionEquality().equals(other.daysOfWeek, daysOfWeek));
}


@override
int get hashCode => Object.hash(runtimeType,frequency,interval,dayOfMonth,const DeepCollectionEquality().hash(daysOfWeek));

@override
String toString() {
  return 'RecurrenceRule(frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, daysOfWeek: $daysOfWeek)';
}


}

/// @nodoc
abstract mixin class $RecurrenceRuleCopyWith<$Res>  {
  factory $RecurrenceRuleCopyWith(RecurrenceRule value, $Res Function(RecurrenceRule) _then) = _$RecurrenceRuleCopyWithImpl;
@useResult
$Res call({
 RecurrenceFrequency frequency, int interval, int? dayOfMonth, List<int> daysOfWeek
});




}
/// @nodoc
class _$RecurrenceRuleCopyWithImpl<$Res>
    implements $RecurrenceRuleCopyWith<$Res> {
  _$RecurrenceRuleCopyWithImpl(this._self, this._then);

  final RecurrenceRule _self;
  final $Res Function(RecurrenceRule) _then;

/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? daysOfWeek = null,}) {
  return _then(RecurrenceRule(
frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,daysOfWeek: null == daysOfWeek ? _self.daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurrenceRule].
extension RecurrenceRulePatterns on RecurrenceRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurrenceRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurrenceRule value)  $default,){
final _that = this;
switch (_that) {
case _RecurrenceRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurrenceRule value)?  $default,){
final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  List<int> daysOfWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
return $default(_that.frequency,_that.interval,_that.dayOfMonth,_that.daysOfWeek);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  List<int> daysOfWeek)  $default,) {final _that = this;
switch (_that) {
case _RecurrenceRule():
return $default(_that.frequency,_that.interval,_that.dayOfMonth,_that.daysOfWeek);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  List<int> daysOfWeek)?  $default,) {final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
return $default(_that.frequency,_that.interval,_that.dayOfMonth,_that.daysOfWeek);case _:
  return null;

}
}

}

/// @nodoc


class _RecurrenceRule implements RecurrenceRule {
  const _RecurrenceRule({required this.frequency, this.interval = 1, this.dayOfMonth,  List<int> daysOfWeek = const []}): _daysOfWeek = daysOfWeek;
  

@override final  RecurrenceFrequency frequency;
@override@JsonKey() final  int interval;
@override final  int? dayOfMonth;
 final  List<int> _daysOfWeek;
@override@JsonKey() List<int> get daysOfWeek {
  if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daysOfWeek);
}


/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurrenceRuleCopyWith<_RecurrenceRule> get copyWith => __$RecurrenceRuleCopyWithImpl<_RecurrenceRule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurrenceRule&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&const DeepCollectionEquality().equals(other._daysOfWeek, _daysOfWeek));
}


@override
int get hashCode => Object.hash(runtimeType,frequency,interval,dayOfMonth,const DeepCollectionEquality().hash(_daysOfWeek));

@override
String toString() {
  return 'RecurrenceRule(frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, daysOfWeek: $daysOfWeek)';
}


}

/// @nodoc
abstract mixin class _$RecurrenceRuleCopyWith<$Res> implements $RecurrenceRuleCopyWith<$Res> {
  factory _$RecurrenceRuleCopyWith(_RecurrenceRule value, $Res Function(_RecurrenceRule) _then) = __$RecurrenceRuleCopyWithImpl;
@override @useResult
$Res call({
 RecurrenceFrequency frequency, int interval, int? dayOfMonth, List<int> daysOfWeek
});




}
/// @nodoc
class __$RecurrenceRuleCopyWithImpl<$Res>
    implements _$RecurrenceRuleCopyWith<$Res> {
  __$RecurrenceRuleCopyWithImpl(this._self, this._then);

  final _RecurrenceRule _self;
  final $Res Function(_RecurrenceRule) _then;

/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? daysOfWeek = null,}) {
  return _then(_RecurrenceRule(
frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,daysOfWeek: null == daysOfWeek ? _self._daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$RecurringTransaction {

 String get id; String get description; Money get amount; TransactionType get type; String get accountId; String? get categoryId; RecurrenceRule get rule; DateTime get startDate; DateTime? get endDate; DateTime? get lastGeneratedDate; DateTime get nextDueDate; bool get isActive;
/// Create a copy of RecurringTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringTransactionCopyWith<RecurringTransaction> get copyWith => _$RecurringTransactionCopyWithImpl<RecurringTransaction>(this as RecurringTransaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.rule, rule) || other.rule == rule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.lastGeneratedDate, lastGeneratedDate) || other.lastGeneratedDate == lastGeneratedDate)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,description,amount,type,accountId,categoryId,rule,startDate,endDate,lastGeneratedDate,nextDueDate,isActive);

@override
String toString() {
  return 'RecurringTransaction(id: $id, description: $description, amount: $amount, type: $type, accountId: $accountId, categoryId: $categoryId, rule: $rule, startDate: $startDate, endDate: $endDate, lastGeneratedDate: $lastGeneratedDate, nextDueDate: $nextDueDate, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $RecurringTransactionCopyWith<$Res>  {
  factory $RecurringTransactionCopyWith(RecurringTransaction value, $Res Function(RecurringTransaction) _then) = _$RecurringTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String description, Money amount, TransactionType type, String accountId, String? categoryId, RecurrenceRule rule, DateTime startDate, DateTime? endDate, DateTime? lastGeneratedDate, DateTime nextDueDate, bool isActive
});


$RecurrenceRuleCopyWith<$Res> get rule;

}
/// @nodoc
class _$RecurringTransactionCopyWithImpl<$Res>
    implements $RecurringTransactionCopyWith<$Res> {
  _$RecurringTransactionCopyWithImpl(this._self, this._then);

  final RecurringTransaction _self;
  final $Res Function(RecurringTransaction) _then;

/// Create a copy of RecurringTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? amount = null,Object? type = null,Object? accountId = null,Object? categoryId = freezed,Object? rule = null,Object? startDate = null,Object? endDate = freezed,Object? lastGeneratedDate = freezed,Object? nextDueDate = null,Object? isActive = null,}) {
  return _then(RecurringTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as RecurrenceRule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastGeneratedDate: freezed == lastGeneratedDate ? _self.lastGeneratedDate : lastGeneratedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RecurringTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurrenceRuleCopyWith<$Res> get rule {
  
  return $RecurrenceRuleCopyWith<$Res>(_self.rule, (value) {
    return _then(_self.copyWith(rule: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecurringTransaction].
extension RecurringTransactionPatterns on RecurringTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringTransaction value)  $default,){
final _that = this;
switch (_that) {
case _RecurringTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  Money amount,  TransactionType type,  String accountId,  String? categoryId,  RecurrenceRule rule,  DateTime startDate,  DateTime? endDate,  DateTime? lastGeneratedDate,  DateTime nextDueDate,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringTransaction() when $default != null:
return $default(_that.id,_that.description,_that.amount,_that.type,_that.accountId,_that.categoryId,_that.rule,_that.startDate,_that.endDate,_that.lastGeneratedDate,_that.nextDueDate,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  Money amount,  TransactionType type,  String accountId,  String? categoryId,  RecurrenceRule rule,  DateTime startDate,  DateTime? endDate,  DateTime? lastGeneratedDate,  DateTime nextDueDate,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _RecurringTransaction():
return $default(_that.id,_that.description,_that.amount,_that.type,_that.accountId,_that.categoryId,_that.rule,_that.startDate,_that.endDate,_that.lastGeneratedDate,_that.nextDueDate,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  Money amount,  TransactionType type,  String accountId,  String? categoryId,  RecurrenceRule rule,  DateTime startDate,  DateTime? endDate,  DateTime? lastGeneratedDate,  DateTime nextDueDate,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _RecurringTransaction() when $default != null:
return $default(_that.id,_that.description,_that.amount,_that.type,_that.accountId,_that.categoryId,_that.rule,_that.startDate,_that.endDate,_that.lastGeneratedDate,_that.nextDueDate,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringTransaction implements RecurringTransaction {
  const _RecurringTransaction({required this.id, required this.description, required this.amount, required this.type, required this.accountId, this.categoryId, required this.rule, required this.startDate, this.endDate, this.lastGeneratedDate, required this.nextDueDate, required this.isActive});
  

@override final  String id;
@override final  String description;
@override final  Money amount;
@override final  TransactionType type;
@override final  String accountId;
@override final  String? categoryId;
@override final  RecurrenceRule rule;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  DateTime? lastGeneratedDate;
@override final  DateTime nextDueDate;
@override final  bool isActive;

/// Create a copy of RecurringTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringTransactionCopyWith<_RecurringTransaction> get copyWith => __$RecurringTransactionCopyWithImpl<_RecurringTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.rule, rule) || other.rule == rule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.lastGeneratedDate, lastGeneratedDate) || other.lastGeneratedDate == lastGeneratedDate)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,description,amount,type,accountId,categoryId,rule,startDate,endDate,lastGeneratedDate,nextDueDate,isActive);

@override
String toString() {
  return 'RecurringTransaction(id: $id, description: $description, amount: $amount, type: $type, accountId: $accountId, categoryId: $categoryId, rule: $rule, startDate: $startDate, endDate: $endDate, lastGeneratedDate: $lastGeneratedDate, nextDueDate: $nextDueDate, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$RecurringTransactionCopyWith<$Res> implements $RecurringTransactionCopyWith<$Res> {
  factory _$RecurringTransactionCopyWith(_RecurringTransaction value, $Res Function(_RecurringTransaction) _then) = __$RecurringTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, Money amount, TransactionType type, String accountId, String? categoryId, RecurrenceRule rule, DateTime startDate, DateTime? endDate, DateTime? lastGeneratedDate, DateTime nextDueDate, bool isActive
});


@override $RecurrenceRuleCopyWith<$Res> get rule;

}
/// @nodoc
class __$RecurringTransactionCopyWithImpl<$Res>
    implements _$RecurringTransactionCopyWith<$Res> {
  __$RecurringTransactionCopyWithImpl(this._self, this._then);

  final _RecurringTransaction _self;
  final $Res Function(_RecurringTransaction) _then;

/// Create a copy of RecurringTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? amount = null,Object? type = null,Object? accountId = null,Object? categoryId = freezed,Object? rule = null,Object? startDate = null,Object? endDate = freezed,Object? lastGeneratedDate = freezed,Object? nextDueDate = null,Object? isActive = null,}) {
  return _then(_RecurringTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as RecurrenceRule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastGeneratedDate: freezed == lastGeneratedDate ? _self.lastGeneratedDate : lastGeneratedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RecurringTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurrenceRuleCopyWith<$Res> get rule {
  
  return $RecurrenceRuleCopyWith<$Res>(_self.rule, (value) {
    return _then(_self.copyWith(rule: value));
  });
}
}

// dart format on
