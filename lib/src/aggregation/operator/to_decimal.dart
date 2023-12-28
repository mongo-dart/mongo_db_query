import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$toDecimal` operator expression
///
/// Converts a value to a decimal. If the value cannot be converted to a
/// decimal, `$toDecimal` errors. If the value is `null` or missing,
/// `$toDecimal` returns `null`.
class $toDecimal extends OperatorExpression {
  ///
  /// [expr] - any valid expression.
  $toDecimal(expr) : super(op$toDecimal, valueToContent(expr));
}
