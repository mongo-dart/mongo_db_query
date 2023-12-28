import '../../base/common/operators_def.dart';
import '../../base/expression_content.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// `$expr` operator
///
/// Creates an `$expr` part of `$match` stage
///
/// The operator is used in `match` aggregation stage to define match expression
/// as aggregation expression.
class $expr extends OperatorExpression {
  /// [expr] - aggregation expression which usually resolves into [bool]
  $expr(ExpressionContent expr) : super(op$expr, valueToContent(expr));
}
