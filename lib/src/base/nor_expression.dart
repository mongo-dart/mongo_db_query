import 'common/operators_def.dart';
import 'abstract/expression_content.dart';
import 'list_expression.dart';
import 'logical_expression.dart';

class NorExpression extends LogicalExpression {
  NorExpression([List<ExpressionContent>? values])
      : super(op$nor, ListExpression(values ?? <ExpressionContent>[]));
  void add(ExpressionContent operatorExp) => content.add(operatorExp);
}
