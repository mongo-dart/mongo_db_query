import 'package:mongo_db_query/src/base/operator_expression.dart';

import '../base/common/operators_def.dart';
import '../base/abstract/expression_content.dart';
import '../query_expression/query_expression.dart';

/// `$abs` operator
///
/// Returns the absolute value of an [expr]
class $abs extends OperatorExpression {
  /// Creates an `$abs` operator expression
  //Abs(expr) : super('abs', expr); ** OLD
  $abs(ExpressionContent expr) : super(op$abs, expr);
}

/// `$add` operator
///
/// Adds numbers together or adds numbers and a date. If one of the arguments is
/// a date, `$add` treats the other arguments as milliseconds to add to the date.
class $add extends OperatorExpression {
  /// Creates an `$add` operator expression
  //Add(List args) : super('add', AEList(args)); ** OLD
  $add(List args) : super(op$add, valueToContent(args));
}

/// `$ceil` operator
///
/// Returns the smallest integer greater than or equal to the specified number.
class $ceil extends OperatorExpression {
  /// Creates `$ceil` operator expression
  //Ceil(expr) : super('ceil', expr); ** OLD
  $ceil(ExpressionContent expr) : super(op$ceil, expr);
}

/// `$divide` operator
///
/// Divides one number by another and returns the result.
class $divide extends OperatorExpression {
  /// Creates `$divide` operator expression
  //Divide(dividend, divisor) : super('divide', AEList([dividend, divisor])); OLD
  $divide(dividend, divisor)
      : super(op$divide, valueToContent([dividend, divisor]));
}

/// `$exp` operator
///
/// Raises Euler’s number (i.e. `e` ) to the specified exponent and returns the
/// result.
class $exp extends OperatorExpression {
  /// Creates `$exp` operator expression
  //Exp(expr) : super('exp', expr); ** OLD
  $exp(expr) : super(op$exp, valueToContent(expr));
}

/// `$floor` operator
///
/// Returns the largest integer less than or equal to the specified number.
class $floor extends OperatorExpression {
  /// Creates `$floor` operator expression
  //Floor(expr) : super('floor', expr); ** OLD
  $floor(expr) : super(op$floor, valueToContent(expr));
}

/// `$ln` operator
///
/// Calculates the natural logarithm `ln` of a number and returns the result as
/// a double.
class $ln extends OperatorExpression {
  /// Creates `$ln` operator expression
  //Ln(expr) : super('ln', expr); ** OfflineAudioCompletionEvent
  $ln(expr) : super(op$ln, valueToContent(expr));
}

/// `$log` operator
///
/// Calculates the `log` of an [expr] in the specified [base] and returns the
/// result as a double.
class $log extends OperatorExpression {
  /// Creates `$log` operator expression
  //Log(expr, base) : super('log', AEList([expr, base]));
  $log(expr, base) : super(op$log, valueToContent([expr, base]));
}

/// `$log10` operator
///
/// Calculates the `log` base 10 of an [expr] and returns the result as a
/// double.
class $log10 extends OperatorExpression {
  /// Creates `$log10` operator expression
  //Log10(expr) : super('log10', expr);
  $log10(expr) : super(op$log10, valueToContent(expr));
}

/// `$mod` operator
///
/// Divides one number by another and returns the remainder.
class $mod extends OperatorExpression {
  /// Creates `$mod` operator expression
  //Mod(dividend, divisor) : super('mod', AEList([dividend, divisor]));
  $mod(dividend, divisor) : super(op$mod, valueToContent([dividend, divisor]));
}

/// `$multiply` operator
///
/// Multiplies numbers together and returns the result. Pass the arguments to
/// `$multiply` in an array.
class $multiply extends OperatorExpression {
  /// Creates `$multiply` operator expression
  //Multiply(List args) : super('multiply', AEList(args));
  $multiply(List args) : super(op$multiply, valueToContent(args));
}

/// `$pow` operator
///
/// Raises an [expr] to the specified [exponent] and returns the result.
class $pow extends OperatorExpression {
  /// Creates `$pow` operator expression
  //Pow(expr, exponent) : super('pow', AEList([expr, exponent]));
  $pow(expr, exponent) : super(op$pow, valueToContent([expr, exponent]));
}

/// `$round` operator
///
/// Rounds an [expr] to to a whole integer or to a specified decimal [place].
class $round extends OperatorExpression {
  /// Creates `$round` operator expression
  //Round(expr, [place]) : super('round', AEList([expr, place]));
  $round(expr, [place]) : super(op$round, valueToContent([expr, place]));
}

/// `$sqrt` operator
///
/// Calculates the square root of a positive number and returns the result as a
/// double.
class $sqrt extends OperatorExpression {
  /// Creates `$sqrt` operator expression
  // Sqrt(expr) : super('sqrt', expr);
  $sqrt(expr) : super(op$sqrt, valueToContent(expr));
}

/// `$subtract` operator
///
/// Subtracts two numbers to return the difference, or two dates to return the
/// difference in milliseconds, or a date and a number in milliseconds to return
/// the resulting date.
class $subtract extends OperatorExpression {
  /// Creates `$subtract` operator expression
  //Subtract(minuend, subtrahend)
  //    : super('subtract', AEList([minuend, subtrahend]));
  $subtract(minuend, subtrahend)
      : super(op$subtract, valueToContent([minuend, subtrahend]));
}

/// `$trunc` operator
///
/// Truncates an [expr] to a whole integer or to a specified decimal [place].
class $trunc extends OperatorExpression {
  /// Creates `$trunc` operator expression
  //Trunc(expr, [place]) : super('trunc', AEList([expr, place]));
  $trunc(expr, [place]) : super(op$trunc, valueToContent([expr, place]));
}
