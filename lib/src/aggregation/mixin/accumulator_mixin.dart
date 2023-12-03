import '../../base/common/operators_def.dart';
import '../../base/field_expression.dart';
import '../../base/map_expression.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';
import 'sequence_mixin.dart';

mixin AccumulatorMixin implements SequenceMixin<MapExpression> {
  /// Creates `$addToSet` operator expression
  ///
  /// Returns an array of all unique values that results from applying an
  /// expression to each document in a group of documents that share the
  /// same group by key. Order of the elements in the output array is
  /// unspecified.
  $addToSet(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$addToSet, valueToContent(expr))));

  /// Creates `$avg` operator expression
  ///
  /// Returns the average value of the numeric values. $avg ignores non-numeric values.
  $avg(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$avg, valueToContent(expr))));

  /// Creates `$first` operator expression
  ///
  /// Returns the value that results from applying an expression to the first
  /// document in a group of documents that share the same group by key. Only
  /// meaningful when documents are in a defined order.
  $first(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$first, valueToContent(expr))));

  /// Creates `$last` operator expression
  ///
  /// Returns the value that results from applying an expression to the last
  /// document in a group of documents that share the same group by a field.
  /// Only meaningful when documents are in a defined order.
  $last(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$last, valueToContent(expr))));

  /// Creates `$max` operator expression
  ///
  /// Returns the maximum value. `$max` compares both value and type, using the
  /// specified BSON comparison order for values of different types.
  $max(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$max, valueToContent(expr))));

  /// Creates `$min` operator expression
  ///
  /// Returns the minimum value. `$min` compares both value and type, using the
  /// specified BSON comparison order for values of different types.
  $min(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$min, valueToContent(expr))));

  /// Creates `$push` operator expressions
  ///
  /// Returns an array of all values that result from applying an expression to
  /// each document in a group of documents that share the same group by key.
  $push(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$push, valueToContent(expr))));

  /// Creates `$stdDevPop` operator expression
  ///
  /// Calculates the population standard deviation of the input values. Use if
  /// the values encompass the entire population of data you want to represent
  /// and do not wish to generalize about a larger population. `$stdDevPop` ignores
  /// non-numeric values.
  $stdDevPop(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$stdDevPop, valueToContent(expr))));

  /// Creates `$stdDevSamp` operator expression
  ///
  /// Calculates the sample standard deviation of the input values. Use if the
  /// values encompass a sample of a population of data from which to generalize
  /// about the population. $stdDevSamp ignores non-numeric values.
  $stdDevSamp(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$stdDevSamp, valueToContent(expr))));

  /// Creates `$sum` operator expression
  ///
  /// Calculates and returns the sum of numeric values. $sum ignores non-numeric
  /// values.
  $sum(String newField, expr) =>
      sequence.add(MapExpression.expression(FieldExpression(
          newField, OperatorExpression(op$sum, valueToContent(expr)))));
}
