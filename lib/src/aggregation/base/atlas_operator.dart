import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Operator for Atlas Search
abstract class AtlasOperator extends OperatorExpression {
  AtlasOperator(String name, expr) : super(name, valueToContent(expr));
}
