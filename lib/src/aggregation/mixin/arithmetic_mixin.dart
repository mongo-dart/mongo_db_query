import '../../base/common/operators_def.dart';
import '../../base/abstract/expression_content.dart';
import '../../base/map_expression.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';
import 'sequence_mixin.dart';

mixin ArithmeticMixin implements SequenceMixin<MapExpression> {
  /// `$abs` operator
  ///
  /// Returns the absolute value of an [expr]
  $abs(ExpressionContent expr) =>
      sequence.add(MapExpression.expression(OperatorExpression(op$abs, expr)));

  /// `$add` operator
  ///
  /// Adds numbers together or adds numbers and a date.
  /// If one of the arguments is a date, `$add` treats the other arguments
  /// as milliseconds to add to the date.
  $add(List args) => sequence.add(MapExpression.expression(
      OperatorExpression(op$add, valueToContent(args))));

  /// `$ceil` operator
  ///
  /// Returns the smallest integer greater than or equal to the specified number
  $ceil(ExpressionContent expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$ceil, valueToContent(expr))));

  /// `$divide` operator
  ///
  /// Divides one number by another and returns the result.
  $divide(dividend, divisor) => sequence.add(MapExpression.expression(
      OperatorExpression(op$divide, valueToContent([dividend, divisor]))));

  /// `$exp` operator
  ///
  /// Raises Euler’s number (i.e. `e` ) to the specified exponent and returns the
  /// result.
  $exp(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$exp, valueToContent(expr))));

  /// `$floor` operator
  ///
  /// Returns the largest integer less than or equal to the specified number.
  $floor(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$floor, valueToContent(expr))));

  /// `$ln` operator
  ///
  /// Calculates the natural logarithm `ln` of a number and returns the result as
  /// a double.
  $ln(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$ln, valueToContent(expr))));

  /// `$log` operator
  ///
  /// Calculates the `log` of an [expr] in the specified [base] and returns the
  /// result as a double.
  $log(expr, base) => sequence.add(MapExpression.expression(
      OperatorExpression(op$log, valueToContent([expr, base]))));

  /// `$log10` operator
  ///
  /// Calculates the `log` base 10 of an [expr] and returns the result as a
  /// double.
  $log10(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$log10, valueToContent(expr))));

  /// `$mod` operator
  ///
  /// Divides one number by another and returns the remainder.
  $mod(dividend, divisor) => sequence.add(MapExpression.expression(
      OperatorExpression(op$mod, valueToContent([dividend, divisor]))));

  /// `$multiply` operator
  ///
  /// Multiplies numbers together and returns the result. Pass the arguments to
  /// `$multiply` in an array.
  $multiply(List args) => sequence.add(MapExpression.expression(
      OperatorExpression(op$multiply, valueToContent(args))));

  /// `$pow` operator
  ///
  /// Raises an [expr] to the specified [exponent] and returns the result.
  $pow(expr, exponent) => sequence.add(MapExpression.expression(
      OperatorExpression(op$pow, valueToContent([expr, exponent]))));

  /// `$round` operator
  ///
  /// Rounds an [expr] to to a whole integer or to a specified decimal [place].
  $round(expr, [place]) => sequence.add(MapExpression.expression(
      OperatorExpression(op$round, valueToContent([expr, place]))));

  /// `$sqrt` operator
  ///
  /// Calculates the square root of a positive number and returns the result as a
  /// double.
  $sqrt(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$sqrt, valueToContent(expr))));

  /// `$subtract` operator
  ///
  /// Subtracts two numbers to return the difference, or two dates to return the
  /// difference in milliseconds, or a date and a number in milliseconds to return
  /// the resulting date.
  $subtract(minuend, subtrahend) => sequence.add(MapExpression.expression(
      OperatorExpression(op$subtract, valueToContent([minuend, subtrahend]))));

  /// `$trunc` operator
  ///
  /// Truncates an [expr] to a whole integer or to a specified decimal [place].
  $trunc(expr, [place]) => sequence.add(MapExpression.expression(
      OperatorExpression(op$trunc, valueToContent([expr, place]))));
}
