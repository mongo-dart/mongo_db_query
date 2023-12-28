import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$toInt` operator expression
///
/// Converts a value to an integer. If the value cannot be converted to an
/// integer, `$toInt` errors. If the value is `null` or missing, `$toInt`
/// returns `null`.
class $toInt extends OperatorExpression {
  /// The [$toInt] takes any valid expression.
  $toInt(expr) : super(op$toInt, valueToContent(expr));
}
