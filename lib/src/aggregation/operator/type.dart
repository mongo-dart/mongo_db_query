import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$type` operator expression
///
/// Returns a string that specifies the BSON type of the argument.
class $type extends OperatorExpression {
  /// The argument can be any valid expression.
  $type(expr) : super(op$type, valueToContent(expr));
}
