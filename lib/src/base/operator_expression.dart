import 'expression.dart';
import 'expression_content.dart';

class OperatorExpression<T extends ExpressionContent> extends Expression<T> {
  OperatorExpression(super.operator, super.value);
  String get operator => entry.key;
}
