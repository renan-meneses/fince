// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategorySpend {

 String get name; Money get amount;
/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorySpendCopyWith<CategorySpend> get copyWith => _$CategorySpendCopyWithImpl<CategorySpend>(this as CategorySpend, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySpend&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,name,amount);

@override
String toString() {
  return 'CategorySpend(name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $CategorySpendCopyWith<$Res>  {
  factory $CategorySpendCopyWith(CategorySpend value, $Res Function(CategorySpend) _then) = _$CategorySpendCopyWithImpl;
@useResult
$Res call({
 String name, Money amount
});




}
/// @nodoc
class _$CategorySpendCopyWithImpl<$Res>
    implements $CategorySpendCopyWith<$Res> {
  _$CategorySpendCopyWithImpl(this._self, this._then);

  final CategorySpend _self;
  final $Res Function(CategorySpend) _then;

/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amount = null,}) {
  return _then(CategorySpend(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [CategorySpend].
extension CategorySpendPatterns on CategorySpend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategorySpend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategorySpend value)  $default,){
final _that = this;
switch (_that) {
case _CategorySpend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategorySpend value)?  $default,){
final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  Money amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
return $default(_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  Money amount)  $default,) {final _that = this;
switch (_that) {
case _CategorySpend():
return $default(_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  Money amount)?  $default,) {final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
return $default(_that.name,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _CategorySpend implements CategorySpend {
  const _CategorySpend({required this.name, required this.amount});
  

@override final  String name;
@override final  Money amount;

/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorySpendCopyWith<_CategorySpend> get copyWith => __$CategorySpendCopyWithImpl<_CategorySpend>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategorySpend&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,name,amount);

@override
String toString() {
  return 'CategorySpend(name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$CategorySpendCopyWith<$Res> implements $CategorySpendCopyWith<$Res> {
  factory _$CategorySpendCopyWith(_CategorySpend value, $Res Function(_CategorySpend) _then) = __$CategorySpendCopyWithImpl;
@override @useResult
$Res call({
 String name, Money amount
});




}
/// @nodoc
class __$CategorySpendCopyWithImpl<$Res>
    implements _$CategorySpendCopyWith<$Res> {
  __$CategorySpendCopyWithImpl(this._self, this._then);

  final _CategorySpend _self;
  final $Res Function(_CategorySpend) _then;

/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amount = null,}) {
  return _then(_CategorySpend(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$BudgetUsage {

 String get name; Money get spent; Money get limit;
/// Create a copy of BudgetUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetUsageCopyWith<BudgetUsage> get copyWith => _$BudgetUsageCopyWithImpl<BudgetUsage>(this as BudgetUsage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetUsage&&(identical(other.name, name) || other.name == name)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,name,spent,limit);

@override
String toString() {
  return 'BudgetUsage(name: $name, spent: $spent, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $BudgetUsageCopyWith<$Res>  {
  factory $BudgetUsageCopyWith(BudgetUsage value, $Res Function(BudgetUsage) _then) = _$BudgetUsageCopyWithImpl;
@useResult
$Res call({
 String name, Money spent, Money limit
});




}
/// @nodoc
class _$BudgetUsageCopyWithImpl<$Res>
    implements $BudgetUsageCopyWith<$Res> {
  _$BudgetUsageCopyWithImpl(this._self, this._then);

  final BudgetUsage _self;
  final $Res Function(BudgetUsage) _then;

/// Create a copy of BudgetUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? spent = null,Object? limit = null,}) {
  return _then(BudgetUsage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as Money,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetUsage].
extension BudgetUsagePatterns on BudgetUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetUsage value)  $default,){
final _that = this;
switch (_that) {
case _BudgetUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetUsage value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  Money spent,  Money limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetUsage() when $default != null:
return $default(_that.name,_that.spent,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  Money spent,  Money limit)  $default,) {final _that = this;
switch (_that) {
case _BudgetUsage():
return $default(_that.name,_that.spent,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  Money spent,  Money limit)?  $default,) {final _that = this;
switch (_that) {
case _BudgetUsage() when $default != null:
return $default(_that.name,_that.spent,_that.limit);case _:
  return null;

}
}

}

/// @nodoc


class _BudgetUsage implements BudgetUsage {
  const _BudgetUsage({required this.name, required this.spent, required this.limit});
  

@override final  String name;
@override final  Money spent;
@override final  Money limit;

/// Create a copy of BudgetUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetUsageCopyWith<_BudgetUsage> get copyWith => __$BudgetUsageCopyWithImpl<_BudgetUsage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetUsage&&(identical(other.name, name) || other.name == name)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,name,spent,limit);

@override
String toString() {
  return 'BudgetUsage(name: $name, spent: $spent, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$BudgetUsageCopyWith<$Res> implements $BudgetUsageCopyWith<$Res> {
  factory _$BudgetUsageCopyWith(_BudgetUsage value, $Res Function(_BudgetUsage) _then) = __$BudgetUsageCopyWithImpl;
@override @useResult
$Res call({
 String name, Money spent, Money limit
});




}
/// @nodoc
class __$BudgetUsageCopyWithImpl<$Res>
    implements _$BudgetUsageCopyWith<$Res> {
  __$BudgetUsageCopyWithImpl(this._self, this._then);

  final _BudgetUsage _self;
  final $Res Function(_BudgetUsage) _then;

/// Create a copy of BudgetUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? spent = null,Object? limit = null,}) {
  return _then(_BudgetUsage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as Money,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$FinancialSnapshot {

 String get period; Money get income; Money get expenses; List<CategorySpend> get expensesByCategory; List<CategorySpend> get previousExpensesByCategory; List<BudgetUsage> get budgets;
/// Create a copy of FinancialSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialSnapshotCopyWith<FinancialSnapshot> get copyWith => _$FinancialSnapshotCopyWithImpl<FinancialSnapshot>(this as FinancialSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialSnapshot&&(identical(other.period, period) || other.period == period)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&const DeepCollectionEquality().equals(other.expensesByCategory, expensesByCategory)&&const DeepCollectionEquality().equals(other.previousExpensesByCategory, previousExpensesByCategory)&&const DeepCollectionEquality().equals(other.budgets, budgets));
}


@override
int get hashCode => Object.hash(runtimeType,period,income,expenses,const DeepCollectionEquality().hash(expensesByCategory),const DeepCollectionEquality().hash(previousExpensesByCategory),const DeepCollectionEquality().hash(budgets));

@override
String toString() {
  return 'FinancialSnapshot(period: $period, income: $income, expenses: $expenses, expensesByCategory: $expensesByCategory, previousExpensesByCategory: $previousExpensesByCategory, budgets: $budgets)';
}


}

/// @nodoc
abstract mixin class $FinancialSnapshotCopyWith<$Res>  {
  factory $FinancialSnapshotCopyWith(FinancialSnapshot value, $Res Function(FinancialSnapshot) _then) = _$FinancialSnapshotCopyWithImpl;
@useResult
$Res call({
 String period, Money income, Money expenses, List<CategorySpend> expensesByCategory, List<CategorySpend> previousExpensesByCategory, List<BudgetUsage> budgets
});




}
/// @nodoc
class _$FinancialSnapshotCopyWithImpl<$Res>
    implements $FinancialSnapshotCopyWith<$Res> {
  _$FinancialSnapshotCopyWithImpl(this._self, this._then);

  final FinancialSnapshot _self;
  final $Res Function(FinancialSnapshot) _then;

/// Create a copy of FinancialSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? income = null,Object? expenses = null,Object? expensesByCategory = null,Object? previousExpensesByCategory = null,Object? budgets = null,}) {
  return _then(FinancialSnapshot(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,expensesByCategory: null == expensesByCategory ? _self.expensesByCategory : expensesByCategory // ignore: cast_nullable_to_non_nullable
as List<CategorySpend>,previousExpensesByCategory: null == previousExpensesByCategory ? _self.previousExpensesByCategory : previousExpensesByCategory // ignore: cast_nullable_to_non_nullable
as List<CategorySpend>,budgets: null == budgets ? _self.budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<BudgetUsage>,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialSnapshot].
extension FinancialSnapshotPatterns on FinancialSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _FinancialSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String period,  Money income,  Money expenses,  List<CategorySpend> expensesByCategory,  List<CategorySpend> previousExpensesByCategory,  List<BudgetUsage> budgets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialSnapshot() when $default != null:
return $default(_that.period,_that.income,_that.expenses,_that.expensesByCategory,_that.previousExpensesByCategory,_that.budgets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String period,  Money income,  Money expenses,  List<CategorySpend> expensesByCategory,  List<CategorySpend> previousExpensesByCategory,  List<BudgetUsage> budgets)  $default,) {final _that = this;
switch (_that) {
case _FinancialSnapshot():
return $default(_that.period,_that.income,_that.expenses,_that.expensesByCategory,_that.previousExpensesByCategory,_that.budgets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String period,  Money income,  Money expenses,  List<CategorySpend> expensesByCategory,  List<CategorySpend> previousExpensesByCategory,  List<BudgetUsage> budgets)?  $default,) {final _that = this;
switch (_that) {
case _FinancialSnapshot() when $default != null:
return $default(_that.period,_that.income,_that.expenses,_that.expensesByCategory,_that.previousExpensesByCategory,_that.budgets);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialSnapshot implements FinancialSnapshot {
  const _FinancialSnapshot({required this.period, required this.income, required this.expenses, required  List<CategorySpend> expensesByCategory, required  List<CategorySpend> previousExpensesByCategory, required  List<BudgetUsage> budgets}): _expensesByCategory = expensesByCategory,_previousExpensesByCategory = previousExpensesByCategory,_budgets = budgets;
  

@override final  String period;
@override final  Money income;
@override final  Money expenses;
 final  List<CategorySpend> _expensesByCategory;
@override List<CategorySpend> get expensesByCategory {
  if (_expensesByCategory is EqualUnmodifiableListView) return _expensesByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expensesByCategory);
}

 final  List<CategorySpend> _previousExpensesByCategory;
@override List<CategorySpend> get previousExpensesByCategory {
  if (_previousExpensesByCategory is EqualUnmodifiableListView) return _previousExpensesByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousExpensesByCategory);
}

 final  List<BudgetUsage> _budgets;
@override List<BudgetUsage> get budgets {
  if (_budgets is EqualUnmodifiableListView) return _budgets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgets);
}


/// Create a copy of FinancialSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialSnapshotCopyWith<_FinancialSnapshot> get copyWith => __$FinancialSnapshotCopyWithImpl<_FinancialSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialSnapshot&&(identical(other.period, period) || other.period == period)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&const DeepCollectionEquality().equals(other._expensesByCategory, _expensesByCategory)&&const DeepCollectionEquality().equals(other._previousExpensesByCategory, _previousExpensesByCategory)&&const DeepCollectionEquality().equals(other._budgets, _budgets));
}


@override
int get hashCode => Object.hash(runtimeType,period,income,expenses,const DeepCollectionEquality().hash(_expensesByCategory),const DeepCollectionEquality().hash(_previousExpensesByCategory),const DeepCollectionEquality().hash(_budgets));

@override
String toString() {
  return 'FinancialSnapshot(period: $period, income: $income, expenses: $expenses, expensesByCategory: $expensesByCategory, previousExpensesByCategory: $previousExpensesByCategory, budgets: $budgets)';
}


}

/// @nodoc
abstract mixin class _$FinancialSnapshotCopyWith<$Res> implements $FinancialSnapshotCopyWith<$Res> {
  factory _$FinancialSnapshotCopyWith(_FinancialSnapshot value, $Res Function(_FinancialSnapshot) _then) = __$FinancialSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String period, Money income, Money expenses, List<CategorySpend> expensesByCategory, List<CategorySpend> previousExpensesByCategory, List<BudgetUsage> budgets
});




}
/// @nodoc
class __$FinancialSnapshotCopyWithImpl<$Res>
    implements _$FinancialSnapshotCopyWith<$Res> {
  __$FinancialSnapshotCopyWithImpl(this._self, this._then);

  final _FinancialSnapshot _self;
  final $Res Function(_FinancialSnapshot) _then;

/// Create a copy of FinancialSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? income = null,Object? expenses = null,Object? expensesByCategory = null,Object? previousExpensesByCategory = null,Object? budgets = null,}) {
  return _then(_FinancialSnapshot(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,expensesByCategory: null == expensesByCategory ? _self._expensesByCategory : expensesByCategory // ignore: cast_nullable_to_non_nullable
as List<CategorySpend>,previousExpensesByCategory: null == previousExpensesByCategory ? _self._previousExpensesByCategory : previousExpensesByCategory // ignore: cast_nullable_to_non_nullable
as List<CategorySpend>,budgets: null == budgets ? _self._budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<BudgetUsage>,
  ));
}


}

// dart format on
