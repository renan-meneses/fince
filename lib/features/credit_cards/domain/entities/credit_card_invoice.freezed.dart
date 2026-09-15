// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_card_invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditCardInvoice {

 String get id; String get creditCardId; DateTime get periodStart; DateTime get periodEnd; DateTime get closingDate; DateTime get dueDate; Money get totalAmount; Money get paidAmount; String get currency; InvoiceStatus get status; DateTime? get paidAt;
/// Create a copy of CreditCardInvoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCardInvoiceCopyWith<CreditCardInvoice> get copyWith => _$CreditCardInvoiceCopyWithImpl<CreditCardInvoice>(this as CreditCardInvoice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCardInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.creditCardId, creditCardId) || other.creditCardId == creditCardId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.closingDate, closingDate) || other.closingDate == closingDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,creditCardId,periodStart,periodEnd,closingDate,dueDate,totalAmount,paidAmount,currency,status,paidAt);

@override
String toString() {
  return 'CreditCardInvoice(id: $id, creditCardId: $creditCardId, periodStart: $periodStart, periodEnd: $periodEnd, closingDate: $closingDate, dueDate: $dueDate, totalAmount: $totalAmount, paidAmount: $paidAmount, currency: $currency, status: $status, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class $CreditCardInvoiceCopyWith<$Res>  {
  factory $CreditCardInvoiceCopyWith(CreditCardInvoice value, $Res Function(CreditCardInvoice) _then) = _$CreditCardInvoiceCopyWithImpl;
@useResult
$Res call({
 String id, String creditCardId, DateTime periodStart, DateTime periodEnd, DateTime closingDate, DateTime dueDate, Money totalAmount, Money paidAmount, String currency, InvoiceStatus status, DateTime? paidAt
});




}
/// @nodoc
class _$CreditCardInvoiceCopyWithImpl<$Res>
    implements $CreditCardInvoiceCopyWith<$Res> {
  _$CreditCardInvoiceCopyWithImpl(this._self, this._then);

  final CreditCardInvoice _self;
  final $Res Function(CreditCardInvoice) _then;

/// Create a copy of CreditCardInvoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? creditCardId = null,Object? periodStart = null,Object? periodEnd = null,Object? closingDate = null,Object? dueDate = null,Object? totalAmount = null,Object? paidAmount = null,Object? currency = null,Object? status = null,Object? paidAt = freezed,}) {
  return _then(CreditCardInvoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,creditCardId: null == creditCardId ? _self.creditCardId : creditCardId // ignore: cast_nullable_to_non_nullable
as String,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,closingDate: null == closingDate ? _self.closingDate : closingDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as Money,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as Money,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvoiceStatus,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditCardInvoice].
extension CreditCardInvoicePatterns on CreditCardInvoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditCardInvoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditCardInvoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditCardInvoice value)  $default,){
final _that = this;
switch (_that) {
case _CreditCardInvoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditCardInvoice value)?  $default,){
final _that = this;
switch (_that) {
case _CreditCardInvoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String creditCardId,  DateTime periodStart,  DateTime periodEnd,  DateTime closingDate,  DateTime dueDate,  Money totalAmount,  Money paidAmount,  String currency,  InvoiceStatus status,  DateTime? paidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditCardInvoice() when $default != null:
return $default(_that.id,_that.creditCardId,_that.periodStart,_that.periodEnd,_that.closingDate,_that.dueDate,_that.totalAmount,_that.paidAmount,_that.currency,_that.status,_that.paidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String creditCardId,  DateTime periodStart,  DateTime periodEnd,  DateTime closingDate,  DateTime dueDate,  Money totalAmount,  Money paidAmount,  String currency,  InvoiceStatus status,  DateTime? paidAt)  $default,) {final _that = this;
switch (_that) {
case _CreditCardInvoice():
return $default(_that.id,_that.creditCardId,_that.periodStart,_that.periodEnd,_that.closingDate,_that.dueDate,_that.totalAmount,_that.paidAmount,_that.currency,_that.status,_that.paidAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String creditCardId,  DateTime periodStart,  DateTime periodEnd,  DateTime closingDate,  DateTime dueDate,  Money totalAmount,  Money paidAmount,  String currency,  InvoiceStatus status,  DateTime? paidAt)?  $default,) {final _that = this;
switch (_that) {
case _CreditCardInvoice() when $default != null:
return $default(_that.id,_that.creditCardId,_that.periodStart,_that.periodEnd,_that.closingDate,_that.dueDate,_that.totalAmount,_that.paidAmount,_that.currency,_that.status,_that.paidAt);case _:
  return null;

}
}

}

/// @nodoc


class _CreditCardInvoice implements CreditCardInvoice {
  const _CreditCardInvoice({required this.id, required this.creditCardId, required this.periodStart, required this.periodEnd, required this.closingDate, required this.dueDate, required this.totalAmount, required this.paidAmount, required this.currency, required this.status, this.paidAt});
  

@override final  String id;
@override final  String creditCardId;
@override final  DateTime periodStart;
@override final  DateTime periodEnd;
@override final  DateTime closingDate;
@override final  DateTime dueDate;
@override final  Money totalAmount;
@override final  Money paidAmount;
@override final  String currency;
@override final  InvoiceStatus status;
@override final  DateTime? paidAt;

/// Create a copy of CreditCardInvoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditCardInvoiceCopyWith<_CreditCardInvoice> get copyWith => __$CreditCardInvoiceCopyWithImpl<_CreditCardInvoice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditCardInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.creditCardId, creditCardId) || other.creditCardId == creditCardId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.closingDate, closingDate) || other.closingDate == closingDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,creditCardId,periodStart,periodEnd,closingDate,dueDate,totalAmount,paidAmount,currency,status,paidAt);

@override
String toString() {
  return 'CreditCardInvoice(id: $id, creditCardId: $creditCardId, periodStart: $periodStart, periodEnd: $periodEnd, closingDate: $closingDate, dueDate: $dueDate, totalAmount: $totalAmount, paidAmount: $paidAmount, currency: $currency, status: $status, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class _$CreditCardInvoiceCopyWith<$Res> implements $CreditCardInvoiceCopyWith<$Res> {
  factory _$CreditCardInvoiceCopyWith(_CreditCardInvoice value, $Res Function(_CreditCardInvoice) _then) = __$CreditCardInvoiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String creditCardId, DateTime periodStart, DateTime periodEnd, DateTime closingDate, DateTime dueDate, Money totalAmount, Money paidAmount, String currency, InvoiceStatus status, DateTime? paidAt
});




}
/// @nodoc
class __$CreditCardInvoiceCopyWithImpl<$Res>
    implements _$CreditCardInvoiceCopyWith<$Res> {
  __$CreditCardInvoiceCopyWithImpl(this._self, this._then);

  final _CreditCardInvoice _self;
  final $Res Function(_CreditCardInvoice) _then;

/// Create a copy of CreditCardInvoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? creditCardId = null,Object? periodStart = null,Object? periodEnd = null,Object? closingDate = null,Object? dueDate = null,Object? totalAmount = null,Object? paidAmount = null,Object? currency = null,Object? status = null,Object? paidAt = freezed,}) {
  return _then(_CreditCardInvoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,creditCardId: null == creditCardId ? _self.creditCardId : creditCardId // ignore: cast_nullable_to_non_nullable
as String,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,closingDate: null == closingDate ? _self.closingDate : closingDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as Money,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as Money,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvoiceStatus,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
