// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeExpenseReport {

 Money get income; Money get expenses; Money get result;
/// Create a copy of IncomeExpenseReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeExpenseReportCopyWith<IncomeExpenseReport> get copyWith => _$IncomeExpenseReportCopyWithImpl<IncomeExpenseReport>(this as IncomeExpenseReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeExpenseReport&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,income,expenses,result);

@override
String toString() {
  return 'IncomeExpenseReport(income: $income, expenses: $expenses, result: $result)';
}


}

/// @nodoc
abstract mixin class $IncomeExpenseReportCopyWith<$Res>  {
  factory $IncomeExpenseReportCopyWith(IncomeExpenseReport value, $Res Function(IncomeExpenseReport) _then) = _$IncomeExpenseReportCopyWithImpl;
@useResult
$Res call({
 Money income, Money expenses, Money result
});




}
/// @nodoc
class _$IncomeExpenseReportCopyWithImpl<$Res>
    implements $IncomeExpenseReportCopyWith<$Res> {
  _$IncomeExpenseReportCopyWithImpl(this._self, this._then);

  final IncomeExpenseReport _self;
  final $Res Function(IncomeExpenseReport) _then;

/// Create a copy of IncomeExpenseReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? income = null,Object? expenses = null,Object? result = null,}) {
  return _then(IncomeExpenseReport(
income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeExpenseReport].
extension IncomeExpenseReportPatterns on IncomeExpenseReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeExpenseReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeExpenseReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeExpenseReport value)  $default,){
final _that = this;
switch (_that) {
case _IncomeExpenseReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeExpenseReport value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeExpenseReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Money income,  Money expenses,  Money result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeExpenseReport() when $default != null:
return $default(_that.income,_that.expenses,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Money income,  Money expenses,  Money result)  $default,) {final _that = this;
switch (_that) {
case _IncomeExpenseReport():
return $default(_that.income,_that.expenses,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Money income,  Money expenses,  Money result)?  $default,) {final _that = this;
switch (_that) {
case _IncomeExpenseReport() when $default != null:
return $default(_that.income,_that.expenses,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeExpenseReport implements IncomeExpenseReport {
  const _IncomeExpenseReport({required this.income, required this.expenses, required this.result});
  

@override final  Money income;
@override final  Money expenses;
@override final  Money result;

/// Create a copy of IncomeExpenseReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeExpenseReportCopyWith<_IncomeExpenseReport> get copyWith => __$IncomeExpenseReportCopyWithImpl<_IncomeExpenseReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeExpenseReport&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,income,expenses,result);

@override
String toString() {
  return 'IncomeExpenseReport(income: $income, expenses: $expenses, result: $result)';
}


}

/// @nodoc
abstract mixin class _$IncomeExpenseReportCopyWith<$Res> implements $IncomeExpenseReportCopyWith<$Res> {
  factory _$IncomeExpenseReportCopyWith(_IncomeExpenseReport value, $Res Function(_IncomeExpenseReport) _then) = __$IncomeExpenseReportCopyWithImpl;
@override @useResult
$Res call({
 Money income, Money expenses, Money result
});




}
/// @nodoc
class __$IncomeExpenseReportCopyWithImpl<$Res>
    implements _$IncomeExpenseReportCopyWith<$Res> {
  __$IncomeExpenseReportCopyWithImpl(this._self, this._then);

  final _IncomeExpenseReport _self;
  final $Res Function(_IncomeExpenseReport) _then;

/// Create a copy of IncomeExpenseReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? income = null,Object? expenses = null,Object? result = null,}) {
  return _then(_IncomeExpenseReport(
income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$CashFlowPoint {

 String get period; Money get income; Money get expenses;
/// Create a copy of CashFlowPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowPointCopyWith<CashFlowPoint> get copyWith => _$CashFlowPointCopyWithImpl<CashFlowPoint>(this as CashFlowPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowPoint&&(identical(other.period, period) || other.period == period)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses));
}


@override
int get hashCode => Object.hash(runtimeType,period,income,expenses);

@override
String toString() {
  return 'CashFlowPoint(period: $period, income: $income, expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class $CashFlowPointCopyWith<$Res>  {
  factory $CashFlowPointCopyWith(CashFlowPoint value, $Res Function(CashFlowPoint) _then) = _$CashFlowPointCopyWithImpl;
@useResult
$Res call({
 String period, Money income, Money expenses
});




}
/// @nodoc
class _$CashFlowPointCopyWithImpl<$Res>
    implements $CashFlowPointCopyWith<$Res> {
  _$CashFlowPointCopyWithImpl(this._self, this._then);

  final CashFlowPoint _self;
  final $Res Function(CashFlowPoint) _then;

/// Create a copy of CashFlowPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? income = null,Object? expenses = null,}) {
  return _then(CashFlowPoint(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [CashFlowPoint].
extension CashFlowPointPatterns on CashFlowPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowPoint value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowPoint value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String period,  Money income,  Money expenses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowPoint() when $default != null:
return $default(_that.period,_that.income,_that.expenses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String period,  Money income,  Money expenses)  $default,) {final _that = this;
switch (_that) {
case _CashFlowPoint():
return $default(_that.period,_that.income,_that.expenses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String period,  Money income,  Money expenses)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowPoint() when $default != null:
return $default(_that.period,_that.income,_that.expenses);case _:
  return null;

}
}

}

/// @nodoc


class _CashFlowPoint implements CashFlowPoint {
  const _CashFlowPoint({required this.period, required this.income, required this.expenses});
  

@override final  String period;
@override final  Money income;
@override final  Money expenses;

/// Create a copy of CashFlowPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashFlowPointCopyWith<_CashFlowPoint> get copyWith => __$CashFlowPointCopyWithImpl<_CashFlowPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowPoint&&(identical(other.period, period) || other.period == period)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses));
}


@override
int get hashCode => Object.hash(runtimeType,period,income,expenses);

@override
String toString() {
  return 'CashFlowPoint(period: $period, income: $income, expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class _$CashFlowPointCopyWith<$Res> implements $CashFlowPointCopyWith<$Res> {
  factory _$CashFlowPointCopyWith(_CashFlowPoint value, $Res Function(_CashFlowPoint) _then) = __$CashFlowPointCopyWithImpl;
@override @useResult
$Res call({
 String period, Money income, Money expenses
});




}
/// @nodoc
class __$CashFlowPointCopyWithImpl<$Res>
    implements _$CashFlowPointCopyWith<$Res> {
  __$CashFlowPointCopyWithImpl(this._self, this._then);

  final _CashFlowPoint _self;
  final $Res Function(_CashFlowPoint) _then;

/// Create a copy of CashFlowPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? income = null,Object? expenses = null,}) {
  return _then(_CashFlowPoint(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$CategoryReport {

 String get categoryId; String get name; String get color; Money get total; double get percent;
/// Create a copy of CategoryReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryReportCopyWith<CategoryReport> get copyWith => _$CategoryReportCopyWithImpl<CategoryReport>(this as CategoryReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryReport&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.total, total) || other.total == total)&&(identical(other.percent, percent) || other.percent == percent));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,name,color,total,percent);

@override
String toString() {
  return 'CategoryReport(categoryId: $categoryId, name: $name, color: $color, total: $total, percent: $percent)';
}


}

/// @nodoc
abstract mixin class $CategoryReportCopyWith<$Res>  {
  factory $CategoryReportCopyWith(CategoryReport value, $Res Function(CategoryReport) _then) = _$CategoryReportCopyWithImpl;
@useResult
$Res call({
 String categoryId, String name, String color, Money total, double percent
});




}
/// @nodoc
class _$CategoryReportCopyWithImpl<$Res>
    implements $CategoryReportCopyWith<$Res> {
  _$CategoryReportCopyWithImpl(this._self, this._then);

  final CategoryReport _self;
  final $Res Function(CategoryReport) _then;

/// Create a copy of CategoryReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? name = null,Object? color = null,Object? total = null,Object? percent = null,}) {
  return _then(CategoryReport(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryReport].
extension CategoryReportPatterns on CategoryReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryReport value)  $default,){
final _that = this;
switch (_that) {
case _CategoryReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryReport value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  String name,  String color,  Money total,  double percent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryReport() when $default != null:
return $default(_that.categoryId,_that.name,_that.color,_that.total,_that.percent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  String name,  String color,  Money total,  double percent)  $default,) {final _that = this;
switch (_that) {
case _CategoryReport():
return $default(_that.categoryId,_that.name,_that.color,_that.total,_that.percent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  String name,  String color,  Money total,  double percent)?  $default,) {final _that = this;
switch (_that) {
case _CategoryReport() when $default != null:
return $default(_that.categoryId,_that.name,_that.color,_that.total,_that.percent);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryReport implements CategoryReport {
  const _CategoryReport({required this.categoryId, required this.name, required this.color, required this.total, required this.percent});
  

@override final  String categoryId;
@override final  String name;
@override final  String color;
@override final  Money total;
@override final  double percent;

/// Create a copy of CategoryReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryReportCopyWith<_CategoryReport> get copyWith => __$CategoryReportCopyWithImpl<_CategoryReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryReport&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.total, total) || other.total == total)&&(identical(other.percent, percent) || other.percent == percent));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,name,color,total,percent);

@override
String toString() {
  return 'CategoryReport(categoryId: $categoryId, name: $name, color: $color, total: $total, percent: $percent)';
}


}

/// @nodoc
abstract mixin class _$CategoryReportCopyWith<$Res> implements $CategoryReportCopyWith<$Res> {
  factory _$CategoryReportCopyWith(_CategoryReport value, $Res Function(_CategoryReport) _then) = __$CategoryReportCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String name, String color, Money total, double percent
});




}
/// @nodoc
class __$CategoryReportCopyWithImpl<$Res>
    implements _$CategoryReportCopyWith<$Res> {
  __$CategoryReportCopyWithImpl(this._self, this._then);

  final _CategoryReport _self;
  final $Res Function(_CategoryReport) _then;

/// Create a copy of CategoryReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? name = null,Object? color = null,Object? total = null,Object? percent = null,}) {
  return _then(_CategoryReport(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$AccountReport {

 String get accountId; String get name; Money get total;
/// Create a copy of AccountReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountReportCopyWith<AccountReport> get copyWith => _$AccountReportCopyWithImpl<AccountReport>(this as AccountReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountReport&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.name, name) || other.name == name)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,name,total);

@override
String toString() {
  return 'AccountReport(accountId: $accountId, name: $name, total: $total)';
}


}

/// @nodoc
abstract mixin class $AccountReportCopyWith<$Res>  {
  factory $AccountReportCopyWith(AccountReport value, $Res Function(AccountReport) _then) = _$AccountReportCopyWithImpl;
@useResult
$Res call({
 String accountId, String name, Money total
});




}
/// @nodoc
class _$AccountReportCopyWithImpl<$Res>
    implements $AccountReportCopyWith<$Res> {
  _$AccountReportCopyWithImpl(this._self, this._then);

  final AccountReport _self;
  final $Res Function(AccountReport) _then;

/// Create a copy of AccountReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? name = null,Object? total = null,}) {
  return _then(AccountReport(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountReport].
extension AccountReportPatterns on AccountReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountReport value)  $default,){
final _that = this;
switch (_that) {
case _AccountReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountReport value)?  $default,){
final _that = this;
switch (_that) {
case _AccountReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  String name,  Money total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountReport() when $default != null:
return $default(_that.accountId,_that.name,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  String name,  Money total)  $default,) {final _that = this;
switch (_that) {
case _AccountReport():
return $default(_that.accountId,_that.name,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  String name,  Money total)?  $default,) {final _that = this;
switch (_that) {
case _AccountReport() when $default != null:
return $default(_that.accountId,_that.name,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _AccountReport implements AccountReport {
  const _AccountReport({required this.accountId, required this.name, required this.total});
  

@override final  String accountId;
@override final  String name;
@override final  Money total;

/// Create a copy of AccountReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountReportCopyWith<_AccountReport> get copyWith => __$AccountReportCopyWithImpl<_AccountReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountReport&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.name, name) || other.name == name)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,name,total);

@override
String toString() {
  return 'AccountReport(accountId: $accountId, name: $name, total: $total)';
}


}

/// @nodoc
abstract mixin class _$AccountReportCopyWith<$Res> implements $AccountReportCopyWith<$Res> {
  factory _$AccountReportCopyWith(_AccountReport value, $Res Function(_AccountReport) _then) = __$AccountReportCopyWithImpl;
@override @useResult
$Res call({
 String accountId, String name, Money total
});




}
/// @nodoc
class __$AccountReportCopyWithImpl<$Res>
    implements _$AccountReportCopyWith<$Res> {
  __$AccountReportCopyWithImpl(this._self, this._then);

  final _AccountReport _self;
  final $Res Function(_AccountReport) _then;

/// Create a copy of AccountReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? name = null,Object? total = null,}) {
  return _then(_AccountReport(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

// dart format on
