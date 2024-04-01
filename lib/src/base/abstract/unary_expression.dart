import 'package:meta/meta.dart';

import '../operator_expression.dart';
import '../value_expression.dart';

abstract class UnaryExpression extends OperatorExpression {
  UnaryExpression(super.unaryOperator, OperatorExpression super.operatorExp);
  @protected
  UnaryExpression.placeHolder()
      : super('placeHolder', ValueExpression.create(0));
  bool get isInvalid => operator == 'placeHolder';
  UnaryExpression setOperator(OperatorExpression operatorExp);
}
