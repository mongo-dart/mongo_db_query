import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$toDouble` operator expression
///
/// Converts a value to a double. If the value cannot be converted to an
/// double, `$toDouble` errors. If the value is `null` or missing, `$toDouble`
/// returns `null`.
class $toDouble extends OperatorExpression {
  /// The [$toDouble] takes any valid expression.
  $toDouble(expr) : super(op$toDouble, valueToContent(expr));
}
