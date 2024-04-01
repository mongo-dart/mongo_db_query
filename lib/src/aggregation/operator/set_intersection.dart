import '../../base/common/operators_def.dart';
import '../../base/abstract/expression_content.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// `$setIntersection` operator
///
/// Takes two or more arrays and returns an array that contains the elements
/// that appear in every input array.
class $setIntersection extends OperatorExpression {
  /// [expr] - The arguments in the list can be any valid expression as long
  /// as they each resolve to an array. For more information on expressions,
  /// see [Expression Operators](https://www.mongodb.com/docs/manual/reference/operator/aggregation/#std-label-aggregation-expressions).
  $setIntersection(List<ExpressionContent> expr)
      : super(op$setIntersection, valueToContent(expr));
}
