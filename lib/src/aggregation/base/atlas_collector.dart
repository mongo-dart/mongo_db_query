import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Collector for Atlas Search
abstract class AtlasCollector extends OperatorExpression {
  AtlasCollector(String name, expr) : super(name, valueToContent(expr));
}
