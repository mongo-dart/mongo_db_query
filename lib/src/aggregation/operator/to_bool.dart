import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$toBool` operator expression
///
/// Converts a value to a boolean.
class $toBool extends OperatorExpression {
  /// [$expr] - any valid expression.
  $toBool(expr) : super(op$toBool, valueToContent(expr));
}
