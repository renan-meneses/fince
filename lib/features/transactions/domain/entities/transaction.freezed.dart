// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Transaction {

 String get id; String get description; Money get amount; TransactionType get type; String get accountId; String? get transferAccountId; String? get categoryId; String? get subcategoryId; DateTime get date; PaymentStatus get paymentStatus; String? get notes; List<String> get tags; String? get attachmentPath; String? get transferGroupId; String? get recurrenceId; String? get installmentId; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.transferAccountId, transferAccountId) || other.transferAccountId == transferAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.attachmentPath, attachmentPath) || other.attachmentPath == attachmentPath)&&(identical(other.transferGroupId, transferGroupId) || other.transferGroupId == transferGroupId)&&(identical(other.recurrenceId, recurrenceId) || other.recurrenceId == recurrenceId)&&(identical(other.installmentId, installmentId) || other.installmentId == installmentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,description,amount,type,accountId,transferAccountId,categoryId,subcategoryId,date,paymentStatus,notes,const DeepCollectionEquality().hash(tags),attachmentPath,transferGroupId,recurrenceId,installmentId,createdAt,updatedAt);

@override
String toString() {
  return 'Transaction(id: $id, description: $description, amount: $amount, type: $type, accountId: $accountId, transferAccountId: $transferAccountId, categoryId: $categoryId, subcategoryId: $subcategoryId, date: $date, paymentStatus: $paymentStatus, notes: $notes, tags: $tags, attachmentPath: $attachmentPath, transferGroupId: $transferGroupId, recurrenceId: $recurrenceId, installmentId: $installmentId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String id, String description, Money amount, TransactionType type, String accountId, String? transferAccountId, String? categoryId, String? subcategoryId, DateTime date, PaymentStatus paymentStatus, String? notes, List<String> tags, String? attachmentPath, String? transferGroupId, String? recurrenceId, String? installmentId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? amount = null,Object? type = null,Object? accountId = null,Object? transferAccountId = freezed,Object? categoryId = freezed,Object? subcategoryId = freezed,Object? date = null,Object? paymentStatus = null,Object? notes = freezed,Object? tags = null,Object? attachmentPath = freezed,Object? transferGroupId = freezed,Object? recurrenceId = freezed,Object? installmentId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,transferAccountId: freezed == transferAccountId ? _self.transferAccountId : transferAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,subcategoryId: freezed == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,attachmentPath: freezed == attachmentPath ? _self.attachmentPath : attachmentPath // ignore: cast_nullable_to_non_nullable
as String?,transferGroupId: freezed == transferGroupId ? _self.transferGroupId : transferGroupId // ignore: cast_nullable_to_non_nullable
as String?,recurrenceId: freezed == recurrenceId ? _self.recurrenceId : recurrenceId // ignore: cast_nullable_to_non_nullable
as String?,installmentId: freezed == installmentId ? _self.installmentId : installmentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  Money amount,  TransactionType type,  String accountId,  String? transferAccountId,  String? categoryId,  String? subcategoryId,  DateTime date,  PaymentStatus paymentStatus,  String? notes,  List<String> tags,  String? attachmentPath,  String? transferGroupId,  String? recurrenceId,  String? installmentId,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.description,_that.amount,_that.type,_that.accountId,_that.transferAccountId,_that.categoryId,_that.subcategoryId,_that.date,_that.paymentStatus,_that.notes,_that.tags,_that.attachmentPath,_that.transferGroupId,_that.recurrenceId,_that.installmentId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  Money amount,  TransactionType type,  String accountId,  String? transferAccountId,  String? categoryId,  String? subcategoryId,  DateTime date,  PaymentStatus paymentStatus,  String? notes,  List<String> tags,  String? attachmentPath,  String? transferGroupId,  String? recurrenceId,  String? installmentId,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.id,_that.description,_that.amount,_that.type,_that.accountId,_that.transferAccountId,_that.categoryId,_that.subcategoryId,_that.date,_that.paymentStatus,_that.notes,_that.tags,_that.attachmentPath,_that.transferGroupId,_that.recurrenceId,_that.installmentId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  Money amount,  TransactionType type,  String accountId,  String? transferAccountId,  String? categoryId,  String? subcategoryId,  DateTime date,  PaymentStatus paymentStatus,  String? notes,  List<String> tags,  String? attachmentPath,  String? transferGroupId,  String? recurrenceId,  String? installmentId,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.description,_that.amount,_that.type,_that.accountId,_that.transferAccountId,_that.categoryId,_that.subcategoryId,_that.date,_that.paymentStatus,_that.notes,_that.tags,_that.attachmentPath,_that.transferGroupId,_that.recurrenceId,_that.installmentId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Transaction implements Transaction {
  const _Transaction({required this.id, required this.description, required this.amount, required this.type, required this.accountId, this.transferAccountId, this.categoryId, this.subcategoryId, required this.date, required this.paymentStatus, this.notes,  List<String> tags = const [], this.attachmentPath, this.transferGroupId, this.recurrenceId, this.installmentId, required this.createdAt, required this.updatedAt}): _tags = tags;
  

@override final  String id;
@override final  String description;
@override final  Money amount;
@override final  TransactionType type;
@override final  String accountId;
@override final  String? transferAccountId;
@override final  String? categoryId;
@override final  String? subcategoryId;
@override final  DateTime date;
@override final  PaymentStatus paymentStatus;
@override final  String? notes;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? attachmentPath;
@override final  String? transferGroupId;
@override final  String? recurrenceId;
@override final  String? installmentId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.transferAccountId, transferAccountId) || other.transferAccountId == transferAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.attachmentPath, attachmentPath) || other.attachmentPath == attachmentPath)&&(identical(other.transferGroupId, transferGroupId) || other.transferGroupId == transferGroupId)&&(identical(other.recurrenceId, recurrenceId) || other.recurrenceId == recurrenceId)&&(identical(other.installmentId, installmentId) || other.installmentId == installmentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,description,amount,type,accountId,transferAccountId,categoryId,subcategoryId,date,paymentStatus,notes,const DeepCollectionEquality().hash(_tags),attachmentPath,transferGroupId,recurrenceId,installmentId,createdAt,updatedAt);

@override
String toString() {
  return 'Transaction(id: $id, description: $description, amount: $amount, type: $type, accountId: $accountId, transferAccountId: $transferAccountId, categoryId: $categoryId, subcategoryId: $subcategoryId, date: $date, paymentStatus: $paymentStatus, notes: $notes, tags: $tags, attachmentPath: $attachmentPath, transferGroupId: $transferGroupId, recurrenceId: $recurrenceId, installmentId: $installmentId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, Money amount, TransactionType type, String accountId, String? transferAccountId, String? categoryId, String? subcategoryId, DateTime date, PaymentStatus paymentStatus, String? notes, List<String> tags, String? attachmentPath, String? transferGroupId, String? recurrenceId, String? installmentId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? amount = null,Object? type = null,Object? accountId = null,Object? transferAccountId = freezed,Object? categoryId = freezed,Object? subcategoryId = freezed,Object? date = null,Object? paymentStatus = null,Object? notes = freezed,Object? tags = null,Object? attachmentPath = freezed,Object? transferGroupId = freezed,Object? recurrenceId = freezed,Object? installmentId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,transferAccountId: freezed == transferAccountId ? _self.transferAccountId : transferAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,subcategoryId: freezed == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,attachmentPath: freezed == attachmentPath ? _self.attachmentPath : attachmentPath // ignore: cast_nullable_to_non_nullable
as String?,transferGroupId: freezed == transferGroupId ? _self.transferGroupId : transferGroupId // ignore: cast_nullable_to_non_nullable
as String?,recurrenceId: freezed == recurrenceId ? _self.recurrenceId : recurrenceId // ignore: cast_nullable_to_non_nullable
as String?,installmentId: freezed == installmentId ? _self.installmentId : installmentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
