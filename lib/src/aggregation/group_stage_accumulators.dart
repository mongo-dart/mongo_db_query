import 'package:mongo_db_query/src/base/map_expression.dart';

import '../base/common/document_types.dart';
import '../base/common/operators_def.dart';
import '../base/field_expression.dart';
import '../query_expression/query_expression.dart';
import 'base/aggregation_base.dart';

/// `$addToSet` operator
class $addToSet extends Accumulator {
  /// Creates `$addToSet` operator expression
  ///
  /// Returns an array of all unique values that results from applying an
  /// expression to each document in a group of documents that share the
  /// same group by key. Order of the elements in the output array is
  /// unspecified.
  /* $addToSet(expr) : super('addToSet', expr); */
  $addToSet(expr) : super(op$addToSet, valueToContent(expr));
}

/// `$avg` operator
class $avg extends Accumulator {
  /// Creates `$avg` operator expression
  ///
  /// Returns the average value of the numeric values. $avg ignores non-numeric values.
  //Avg(expr) : super('avg', expr is List ? AEList(expr) : expr);
  $avg(expr) : super(op$avg, valueToContent(expr));
}

/// `$first` operator
class $first extends Accumulator {
  /// Creates `$first` operator expression
  ///
  /// Returns the value that results from applying an expression to the first
  /// document in a group of documents that share the same group by key. Only
  /// meaningful when documents are in a defined order.
  /* $first(expr) : super('first', expr); */
  $first(expr) : super(op$first, valueToContent(expr));
}

/// `$last` operator
class $last extends Accumulator {
  /// Creates `$last` operator expression
  ///
  /// Returns the value that results from applying an expression to the last
  /// document in a group of documents that share the same group by a field.
  /// Only meaningful when documents are in a defined order.
  /*  $last(expr) : super('last', expr); */
  $last(expr) : super(op$last, valueToContent(expr));
}

/// `$max` operator
class $max extends Accumulator {
  /// Creates `$max` operator expression
  ///
  /// Returns the maximum value. `$max` compares both value and type, using the
  /// specified BSON comparison order for values of different types.
  /* $max(expr) : super('max', expr is List ? AEList(expr) : expr); */
  $max(expr) : super(op$max, valueToContent(expr));
}

/// `$min` operator
class $min extends Accumulator {
  /// Creates `$min` operator expression
  ///
  /// Returns the minimum value. `$min` compares both value and type, using the
  /// specified BSON comparison order for values of different types.
/*   $min(expr) : super('min', expr is List ? AEList(expr) : expr);*/
  $min(expr) : super(op$min, valueToContent(expr));
}

/// `$push` operator
class $push extends Accumulator {
  /// Creates `$push` operator expression
  ///
  /// Returns an array of all values that result from applying an expression to
  /// each document in a group of documents that share the same group by key.
  //Push(expr) : super('push', expr);
  $push(expr) : super(op$push, valueToContent(expr));

  /// Creates `$push` operator expression
  ///
  /// More readable way to create `Push(AEList([...]))`
  @Deprecated('Use dfault constructor')
  $push.list(List list) : super(op$push, valueToContent(list));

  /// Creates `$push` operator expression
  ///
  /// More readable way to create `Push(AOBject({...}))`
  @Deprecated('Use dfault constructor')
  $push.object(Map<String, dynamic> object)
      : super(op$push, valueToContent(object));
}

/// `$stdDevPop` operator
class $stdDevPop extends Accumulator {
  /// Creates `$stdDevPop` operator expression
  ///
  /// Calculates the population standard deviation of the input values. Use if
  /// the values encompass the entire population of data you want to represent
  /// and do not wish to generalize about a larger population. `$stdDevPop` ignores
  /// non-numeric values.
  /* $stdDevPop(expr) : super('stdDevPop', expr is List ? AEList(expr) : expr); */
  $stdDevPop(expr) : super(op$stdDevPop, valueToContent(expr));
}

/// `$stdDevSamp` operator
class $stdDevSamp extends Accumulator {
  /// Creates `$stdDevSamp` operator expression
  ///
  /// Calculates the sample standard deviation of the input values. Use if the
  /// values encompass a sample of a population of data from which to generalize
  /// about the population. $stdDevSamp ignores non-numeric values.
  /*  $stdDevSamp(expr) : super('stdDevSamp', expr is List ? AEList(expr) : expr); */
  $stdDevSamp(expr) : super(op$stdDevSamp, valueToContent(expr));
}

/// `$sum` operator
class $sum extends Accumulator {
  /// Creates `$sum` operator expression
  ///
  /// Calculates and returns the sum of numeric values. $sum ignores non-numeric
  /// values.
  //$Sum(expr) : super('sum', expr is List ? AEList(expr) : expr);
  $sum(expr) : super(op$sum, valueToContent(expr));
}

fieldAccumulator(String fieldName, Accumulator accumulator) =>
    FieldExpression(fieldName, MapExpression.expression(accumulator));

FieldExpression fieldSum(String fieldName, expr) =>
    FieldExpression(fieldName, MapExpression.expression($sum(expr)));
FieldExpression fieldPush(String fieldName, expr) =>
    FieldExpression(fieldName, MapExpression.expression($push(expr)));

MongoDocument accumulatorsMap(List<FieldExpression> operators) =>
    {for (var operator in operators) ...operator.build()};
