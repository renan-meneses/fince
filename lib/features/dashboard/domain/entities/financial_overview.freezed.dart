// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryTotal {

 String get categoryId; String get name; String get color; String get icon; Money get total; double get percent;
/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryTotalCopyWith<CategoryTotal> get copyWith => _$CategoryTotalCopyWithImpl<CategoryTotal>(this as CategoryTotal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryTotal&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.total, total) || other.total == total)&&(identical(other.percent, percent) || other.percent == percent));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,name,color,icon,total,percent);

@override
String toString() {
  return 'CategoryTotal(categoryId: $categoryId, name: $name, color: $color, icon: $icon, total: $total, percent: $percent)';
}


}

/// @nodoc
abstract mixin class $CategoryTotalCopyWith<$Res>  {
  factory $CategoryTotalCopyWith(CategoryTotal value, $Res Function(CategoryTotal) _then) = _$CategoryTotalCopyWithImpl;
@useResult
$Res call({
 String categoryId, String name, String color, String icon, Money total, double percent
});




}
/// @nodoc
class _$CategoryTotalCopyWithImpl<$Res>
    implements $CategoryTotalCopyWith<$Res> {
  _$CategoryTotalCopyWithImpl(this._self, this._then);

  final CategoryTotal _self;
  final $Res Function(CategoryTotal) _then;

/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? name = null,Object? color = null,Object? icon = null,Object? total = null,Object? percent = null,}) {
  return _then(CategoryTotal(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryTotal].
extension CategoryTotalPatterns on CategoryTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryTotal value)  $default,){
final _that = this;
switch (_that) {
case _CategoryTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryTotal value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  String name,  String color,  String icon,  Money total,  double percent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
return $default(_that.categoryId,_that.name,_that.color,_that.icon,_that.total,_that.percent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  String name,  String color,  String icon,  Money total,  double percent)  $default,) {final _that = this;
switch (_that) {
case _CategoryTotal():
return $default(_that.categoryId,_that.name,_that.color,_that.icon,_that.total,_that.percent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  String name,  String color,  String icon,  Money total,  double percent)?  $default,) {final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
return $default(_that.categoryId,_that.name,_that.color,_that.icon,_that.total,_that.percent);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryTotal implements CategoryTotal {
  const _CategoryTotal({required this.categoryId, required this.name, required this.color, required this.icon, required this.total, required this.percent});
  

@override final  String categoryId;
@override final  String name;
@override final  String color;
@override final  String icon;
@override final  Money total;
@override final  double percent;

/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryTotalCopyWith<_CategoryTotal> get copyWith => __$CategoryTotalCopyWithImpl<_CategoryTotal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryTotal&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.total, total) || other.total == total)&&(identical(other.percent, percent) || other.percent == percent));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,name,color,icon,total,percent);

@override
String toString() {
  return 'CategoryTotal(categoryId: $categoryId, name: $name, color: $color, icon: $icon, total: $total, percent: $percent)';
}


}

/// @nodoc
abstract mixin class _$CategoryTotalCopyWith<$Res> implements $CategoryTotalCopyWith<$Res> {
  factory _$CategoryTotalCopyWith(_CategoryTotal value, $Res Function(_CategoryTotal) _then) = __$CategoryTotalCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String name, String color, String icon, Money total, double percent
});




}
/// @nodoc
class __$CategoryTotalCopyWithImpl<$Res>
    implements _$CategoryTotalCopyWith<$Res> {
  __$CategoryTotalCopyWithImpl(this._self, this._then);

  final _CategoryTotal _self;
  final $Res Function(_CategoryTotal) _then;

/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? name = null,Object? color = null,Object? icon = null,Object? total = null,Object? percent = null,}) {
  return _then(_CategoryTotal(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$FinancialOverview {

 Money get totalBalance; Money get income; Money get expenses; Money get result; double? get variationPercent; List<Transaction> get recentTransactions; List<CategoryTotal> get expensesByCategory;
/// Create a copy of FinancialOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialOverviewCopyWith<FinancialOverview> get copyWith => _$FinancialOverviewCopyWithImpl<FinancialOverview>(this as FinancialOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialOverview&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.result, result) || other.result == result)&&(identical(other.variationPercent, variationPercent) || other.variationPercent == variationPercent)&&const DeepCollectionEquality().equals(other.recentTransactions, recentTransactions)&&const DeepCollectionEquality().equals(other.expensesByCategory, expensesByCategory));
}


@override
int get hashCode => Object.hash(runtimeType,totalBalance,income,expenses,result,variationPercent,const DeepCollectionEquality().hash(recentTransactions),const DeepCollectionEquality().hash(expensesByCategory));

@override
String toString() {
  return 'FinancialOverview(totalBalance: $totalBalance, income: $income, expenses: $expenses, result: $result, variationPercent: $variationPercent, recentTransactions: $recentTransactions, expensesByCategory: $expensesByCategory)';
}


}

/// @nodoc
abstract mixin class $FinancialOverviewCopyWith<$Res>  {
  factory $FinancialOverviewCopyWith(FinancialOverview value, $Res Function(FinancialOverview) _then) = _$FinancialOverviewCopyWithImpl;
@useResult
$Res call({
 Money totalBalance, Money income, Money expenses, Money result, double? variationPercent, List<Transaction> recentTransactions, List<CategoryTotal> expensesByCategory
});




}
/// @nodoc
class _$FinancialOverviewCopyWithImpl<$Res>
    implements $FinancialOverviewCopyWith<$Res> {
  _$FinancialOverviewCopyWithImpl(this._self, this._then);

  final FinancialOverview _self;
  final $Res Function(FinancialOverview) _then;

/// Create a copy of FinancialOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? income = null,Object? expenses = null,Object? result = null,Object? variationPercent = freezed,Object? recentTransactions = null,Object? expensesByCategory = null,}) {
  return _then(FinancialOverview(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as Money,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Money,variationPercent: freezed == variationPercent ? _self.variationPercent : variationPercent // ignore: cast_nullable_to_non_nullable
as double?,recentTransactions: null == recentTransactions ? _self.recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>,expensesByCategory: null == expensesByCategory ? _self.expensesByCategory : expensesByCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryTotal>,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialOverview].
extension FinancialOverviewPatterns on FinancialOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialOverview value)  $default,){
final _that = this;
switch (_that) {
case _FinancialOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialOverview value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Money totalBalance,  Money income,  Money expenses,  Money result,  double? variationPercent,  List<Transaction> recentTransactions,  List<CategoryTotal> expensesByCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialOverview() when $default != null:
return $default(_that.totalBalance,_that.income,_that.expenses,_that.result,_that.variationPercent,_that.recentTransactions,_that.expensesByCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Money totalBalance,  Money income,  Money expenses,  Money result,  double? variationPercent,  List<Transaction> recentTransactions,  List<CategoryTotal> expensesByCategory)  $default,) {final _that = this;
switch (_that) {
case _FinancialOverview():
return $default(_that.totalBalance,_that.income,_that.expenses,_that.result,_that.variationPercent,_that.recentTransactions,_that.expensesByCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Money totalBalance,  Money income,  Money expenses,  Money result,  double? variationPercent,  List<Transaction> recentTransactions,  List<CategoryTotal> expensesByCategory)?  $default,) {final _that = this;
switch (_that) {
case _FinancialOverview() when $default != null:
return $default(_that.totalBalance,_that.income,_that.expenses,_that.result,_that.variationPercent,_that.recentTransactions,_that.expensesByCategory);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialOverview implements FinancialOverview {
  const _FinancialOverview({required this.totalBalance, required this.income, required this.expenses, required this.result, required this.variationPercent, required  List<Transaction> recentTransactions, required  List<CategoryTotal> expensesByCategory}): _recentTransactions = recentTransactions,_expensesByCategory = expensesByCategory;
  

@override final  Money totalBalance;
@override final  Money income;
@override final  Money expenses;
@override final  Money result;
@override final  double? variationPercent;
 final  List<Transaction> _recentTransactions;
@override List<Transaction> get recentTransactions {
  if (_recentTransactions is EqualUnmodifiableListView) return _recentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTransactions);
}

 final  List<CategoryTotal> _expensesByCategory;
@override List<CategoryTotal> get expensesByCategory {
  if (_expensesByCategory is EqualUnmodifiableListView) return _expensesByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expensesByCategory);
}


/// Create a copy of FinancialOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialOverviewCopyWith<_FinancialOverview> get copyWith => __$FinancialOverviewCopyWithImpl<_FinancialOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialOverview&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.result, result) || other.result == result)&&(identical(other.variationPercent, variationPercent) || other.variationPercent == variationPercent)&&const DeepCollectionEquality().equals(other._recentTransactions, _recentTransactions)&&const DeepCollectionEquality().equals(other._expensesByCategory, _expensesByCategory));
}


@override
int get hashCode => Object.hash(runtimeType,totalBalance,income,expenses,result,variationPercent,const DeepCollectionEquality().hash(_recentTransactions),const DeepCollectionEquality().hash(_expensesByCategory));

@override
String toString() {
  return 'FinancialOverview(totalBalance: $totalBalance, income: $income, expenses: $expenses, result: $result, variationPercent: $variationPercent, recentTransactions: $recentTransactions, expensesByCategory: $expensesByCategory)';
}


}

/// @nodoc
abstract mixin class _$FinancialOverviewCopyWith<$Res> implements $FinancialOverviewCopyWith<$Res> {
  factory _$FinancialOverviewCopyWith(_FinancialOverview value, $Res Function(_FinancialOverview) _then) = __$FinancialOverviewCopyWithImpl;
@override @useResult
$Res call({
 Money totalBalance, Money income, Money expenses, Money result, double? variationPercent, List<Transaction> recentTransactions, List<CategoryTotal> expensesByCategory
});




}
/// @nodoc
class __$FinancialOverviewCopyWithImpl<$Res>
    implements _$FinancialOverviewCopyWith<$Res> {
  __$FinancialOverviewCopyWithImpl(this._self, this._then);

  final _FinancialOverview _self;
  final $Res Function(_FinancialOverview) _then;

/// Create a copy of FinancialOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? income = null,Object? expenses = null,Object? result = null,Object? variationPercent = freezed,Object? recentTransactions = null,Object? expensesByCategory = null,}) {
  return _then(_FinancialOverview(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as Money,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Money,variationPercent: freezed == variationPercent ? _self.variationPercent : variationPercent // ignore: cast_nullable_to_non_nullable
as double?,recentTransactions: null == recentTransactions ? _self._recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>,expensesByCategory: null == expensesByCategory ? _self._expensesByCategory : expensesByCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryTotal>,
  ));
}


}

// dart format on
