import 'common/operators_def.dart';
import 'operator_expression.dart';
import 'abstract/unary_expression.dart';

class NotExpression extends UnaryExpression {
  NotExpression(OperatorExpression operatorExp) : super(op$not, operatorExp);
  NotExpression.placeHolder() : super.placeHolder();

  @override
  NotExpression setOperator(OperatorExpression operatorExp) {
    if (!isInvalid) {
      throw ArgumentError(
          'Cannot create a new unary operator, this is already valid');
    }
    return NotExpression(operatorExp);
  }
}
