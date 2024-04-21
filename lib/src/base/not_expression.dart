import 'abstract/expression_content.dart';
import 'and_expression.dart';
import 'common/operators_def.dart';
import 'expression.dart';
import 'field_expression.dart';
import 'operator_expression.dart';
import 'abstract/unary_expression.dart';

class NotExpression extends UnaryExpression {
  NotExpression(OperatorExpression operatorExp) : super(op$not, operatorExp);
  NotExpression.placeHolder() : super.placeHolder();

  @override
  Expression setOperator(OperatorExpression operatorExp) {
    if (!isInvalid) {
      throw ArgumentError(
          'Cannot create a new unary operator, this is already valid');
    }
    if (operatorExp is AndExpression && operatorExp.length == 1) {
      var inner = operatorExp.content.values.first;
      if (inner is OperatorExpression) {
        return NotExpression(inner);
      } else if (inner is FieldExpression &&
          inner.content is OperatorExpression<ExpressionContent>) {
        var value = inner.content as OperatorExpression<ExpressionContent>;
        return FieldExpression(inner.fieldName, NotExpression(value));
      }
    }
    return NotExpression(operatorExp);
  }
}
