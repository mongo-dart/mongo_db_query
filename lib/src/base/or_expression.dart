import 'abstract/expression_content.dart';
import 'common/operators_def.dart';
import 'list_expression.dart';
import 'logical_expression.dart';

class OrExpression extends LogicalExpression {
  OrExpression([List<ExpressionContent>? values])
      : super(op$or, ListExpression(values ?? <ExpressionContent>[]));
  @override
  void add(ExpressionContent operatorExp) => content.add(operatorExp);
}
