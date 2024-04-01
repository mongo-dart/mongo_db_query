import 'common/operators_def.dart';
import 'abstract/expression_content.dart';
import 'list_expression.dart';
import 'operator_expression.dart';

abstract class LogicalExpression extends OperatorExpression<ListExpression> {
  LogicalExpression(super.operator, super.value);
  bool get isEmpty => content.isEmpty;
  bool get isNotEmpty => content.isNotEmpty;
}

class OrExpression extends LogicalExpression {
  OrExpression([List<ExpressionContent>? values])
      : super(op$or, ListExpression(values ?? <ExpressionContent>[]));
  void add(ExpressionContent operatorExp) => content.add(operatorExp);
}
