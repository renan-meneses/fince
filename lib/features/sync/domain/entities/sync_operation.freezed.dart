// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_operation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncOperation {

 String get id; String get entityId; String get entityType; SyncOperationType get operation; String get payload; DateTime get timestamp; SyncStatus get status; int get retryCount; String? get lastError; String get idempotencyKey;
/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncOperationCopyWith<SyncOperation> get copyWith => _$SyncOperationCopyWithImpl<SyncOperation>(this as SyncOperation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncOperation&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey));
}


@override
int get hashCode => Object.hash(runtimeType,id,entityId,entityType,operation,payload,timestamp,status,retryCount,lastError,idempotencyKey);

@override
String toString() {
  return 'SyncOperation(id: $id, entityId: $entityId, entityType: $entityType, operation: $operation, payload: $payload, timestamp: $timestamp, status: $status, retryCount: $retryCount, lastError: $lastError, idempotencyKey: $idempotencyKey)';
}


}

/// @nodoc
abstract mixin class $SyncOperationCopyWith<$Res>  {
  factory $SyncOperationCopyWith(SyncOperation value, $Res Function(SyncOperation) _then) = _$SyncOperationCopyWithImpl;
@useResult
$Res call({
 String id, String entityId, String entityType, SyncOperationType operation, String payload, DateTime timestamp, SyncStatus status, int retryCount, String? lastError, String idempotencyKey
});




}
/// @nodoc
class _$SyncOperationCopyWithImpl<$Res>
    implements $SyncOperationCopyWith<$Res> {
  _$SyncOperationCopyWithImpl(this._self, this._then);

  final SyncOperation _self;
  final $Res Function(SyncOperation) _then;

/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? entityId = null,Object? entityType = null,Object? operation = null,Object? payload = null,Object? timestamp = null,Object? status = null,Object? retryCount = null,Object? lastError = freezed,Object? idempotencyKey = null,}) {
  return _then(SyncOperation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as SyncOperationType,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncOperation].
extension SyncOperationPatterns on SyncOperation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncOperation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncOperation value)  $default,){
final _that = this;
switch (_that) {
case _SyncOperation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncOperation value)?  $default,){
final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String entityId,  String entityType,  SyncOperationType operation,  String payload,  DateTime timestamp,  SyncStatus status,  int retryCount,  String? lastError,  String idempotencyKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
return $default(_that.id,_that.entityId,_that.entityType,_that.operation,_that.payload,_that.timestamp,_that.status,_that.retryCount,_that.lastError,_that.idempotencyKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String entityId,  String entityType,  SyncOperationType operation,  String payload,  DateTime timestamp,  SyncStatus status,  int retryCount,  String? lastError,  String idempotencyKey)  $default,) {final _that = this;
switch (_that) {
case _SyncOperation():
return $default(_that.id,_that.entityId,_that.entityType,_that.operation,_that.payload,_that.timestamp,_that.status,_that.retryCount,_that.lastError,_that.idempotencyKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String entityId,  String entityType,  SyncOperationType operation,  String payload,  DateTime timestamp,  SyncStatus status,  int retryCount,  String? lastError,  String idempotencyKey)?  $default,) {final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
return $default(_that.id,_that.entityId,_that.entityType,_that.operation,_that.payload,_that.timestamp,_that.status,_that.retryCount,_that.lastError,_that.idempotencyKey);case _:
  return null;

}
}

}

/// @nodoc


class _SyncOperation implements SyncOperation {
  const _SyncOperation({required this.id, required this.entityId, required this.entityType, required this.operation, required this.payload, required this.timestamp, required this.status, required this.retryCount, this.lastError, required this.idempotencyKey});
  

@override final  String id;
@override final  String entityId;
@override final  String entityType;
@override final  SyncOperationType operation;
@override final  String payload;
@override final  DateTime timestamp;
@override final  SyncStatus status;
@override final  int retryCount;
@override final  String? lastError;
@override final  String idempotencyKey;

/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncOperationCopyWith<_SyncOperation> get copyWith => __$SyncOperationCopyWithImpl<_SyncOperation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncOperation&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey));
}


@override
int get hashCode => Object.hash(runtimeType,id,entityId,entityType,operation,payload,timestamp,status,retryCount,lastError,idempotencyKey);

@override
String toString() {
  return 'SyncOperation(id: $id, entityId: $entityId, entityType: $entityType, operation: $operation, payload: $payload, timestamp: $timestamp, status: $status, retryCount: $retryCount, lastError: $lastError, idempotencyKey: $idempotencyKey)';
}


}

/// @nodoc
abstract mixin class _$SyncOperationCopyWith<$Res> implements $SyncOperationCopyWith<$Res> {
  factory _$SyncOperationCopyWith(_SyncOperation value, $Res Function(_SyncOperation) _then) = __$SyncOperationCopyWithImpl;
@override @useResult
$Res call({
 String id, String entityId, String entityType, SyncOperationType operation, String payload, DateTime timestamp, SyncStatus status, int retryCount, String? lastError, String idempotencyKey
});




}
/// @nodoc
class __$SyncOperationCopyWithImpl<$Res>
    implements _$SyncOperationCopyWith<$Res> {
  __$SyncOperationCopyWithImpl(this._self, this._then);

  final _SyncOperation _self;
  final $Res Function(_SyncOperation) _then;

/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? entityId = null,Object? entityType = null,Object? operation = null,Object? payload = null,Object? timestamp = null,Object? status = null,Object? retryCount = null,Object? lastError = freezed,Object? idempotencyKey = null,}) {
  return _then(_SyncOperation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as SyncOperationType,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
