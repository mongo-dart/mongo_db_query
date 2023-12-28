import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$toLong` operator expression
///
/// Converts a value to a long. If the value cannot be converted to a long,
/// `$toLong` errors. If the value is `null` or missing, `$toLong` returns
/// `null`.
class $toLong extends OperatorExpression {
  /// The [$toLong] takes any valid expression.
  $toLong(expr) : super(op$toLong, valueToContent(expr));
}
