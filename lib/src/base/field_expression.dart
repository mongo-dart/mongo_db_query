import 'expression.dart';
import 'abstract/expression_content.dart';

class FieldExpression<T extends ExpressionContent> extends Expression {
  FieldExpression(super.fieldName, T super.value);
  String get fieldName => entry.key;
}
