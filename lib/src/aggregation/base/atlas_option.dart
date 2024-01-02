import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Option for Atlas Search
abstract class AtlasOption extends OperatorExpression {
  AtlasOption(String name, expr) : super(name, valueToContent(expr));
}
