import 'package:mongo_db_query/src/base/and_expression.dart';
import 'package:mongo_db_query/src/base/nor_expression.dart';

import 'abstract/expression_content.dart';
import 'or_expression.dart';

import 'list_expression.dart';
import 'operator_expression.dart';

abstract class LogicalExpression extends OperatorExpression<ListExpression> {
  LogicalExpression(super.operator, super.value);

  bool isLowerLevel = false;

  bool get isEmpty => content.isEmpty;
  bool get isNotEmpty => content.isNotEmpty;
  int get length => content.length;

  void add(ExpressionContent operatorExp);

  /// Adds the value at the beginning of the list (index 0)
  void inject(ExpressionContent operatorExp) => content.inject(operatorExp);

  /// Return true if this and other have the same runtimeType
  bool sameType(LogicalExpression other) => runtimeType == other.runtimeType;

  /// Returns operators precedense $NOR > $AND > $OR
  /// In case of same type this will have the precedence
  bool hasHigherPrecedenceThan(LogicalExpression expression) {
    if (isLowerLevel == expression.isLowerLevel) {
      if (this is OrExpression) {
        return false;
      } else if (this is AndExpression) {
        if (expression is NorExpression) {
          return false;
        }
      }
      return true;
    }
    if (isLowerLevel == false) {
      return false;
    }
    return true;
  }
}
