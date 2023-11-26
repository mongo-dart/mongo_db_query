import 'package:mongo_db_query/src/base/map_expression.dart';

import '../base/common/operators_def.dart';
import '../base/expression_content.dart';
import '../base/operator_expression.dart';
import '../query_expression/query_expression.dart';

/// `$cmp` operator
///
/// Compares two values and returns:
///
/// * -1 if the first value is less than the second.
/// * 1 if the first value is greater than the second.
/// * 0 if the two values are equivalent.
class $cmp extends OperatorExpression {
  /// Creates `$cmp` operator expression
  $cmp(a, b) : super(op$cmp, valueToContent([a, b]));
}

/// `$eq` operator
///
/// Compares two values and returns:
///
/// * `true` when the values are equivalent.
/// * `false` when the values are not equivalent.
class $eq extends OperatorExpression {
  /// Creates `$eq` operator expression
  $eq(a, b) : super(op$eq, valueToContent([a, b]));
}

/// `$gt` operator
///
/// Compares two values and returns:
///
/// * `true` when the first value is greater than the second value.
/// * `false` when the first value is less than or equivalent to the second
/// value.
class $gt extends OperatorExpression {
  /// Creates `$gt` operator expression
  $gt(a, b) : super(op$gt, valueToContent([a, b]));
}

/// `$gte` operator
///
/// Compares two values and returns:
///
/// * `true` when the first value is greater than or equivalent to the second
/// value.
/// * `false` when the first value is less than the second value.
class $gte extends OperatorExpression {
  /// Creates `$gte` operator expression
  $gte(a, b) : super(op$gte, valueToContent([a, b]));
}

/// `$lt` operator
///
/// Compares two values and returns:
///
/// * `true` when the first value is less than the second value.
/// * `false` when the first value is greater than or equivalent to the second
/// value.
class $lt extends OperatorExpression {
  /// Creates `$lt` operator expression
  $lt(a, b) : super(op$lt, valueToContent([a, b]));
}

/// `lte` operator
///
/// Compares two values and returns:
///
/// * `true` when the first value is less than or equivalent to the second value.
/// * `false` when the first value is greater than the second value.
class $lte extends OperatorExpression {
  /// Creates `$lte` operator expression
  $lte(a, b) : super(op$lte, valueToContent([a, b]));
}

/// `$ne` operator
///
/// Compares two values and returns:
///
/// * `true` when the values are not equivalent.
/// * `false` when the values are equivalent.
class $ne extends OperatorExpression {
  /// Creates `$ne` operator expression
  $ne(a, b) : super(op$ne, valueToContent([a, b]));
}

/// `$cond` operator
///
/// Evaluates a boolean expression to return one of the two specified return
/// expressions.
///
/// The arguments can be any valid expression.
class $cond extends OperatorExpression {
  /// Creates `$cond` operator expression
  $cond({required ifExpr, required thenExpr, required elseExpr})
      : super(op$cond, valueToContent([ifExpr, thenExpr, elseExpr]));
}

/// `$ifNull` operator
///
/// Evaluates an [expression] and returns the value of the [expression] if the
/// [expression] evaluates to a non-null value. If the [expression] evaluates
/// to a null value, including instances of undefined values or missing fields,
/// returns the value of the [replacement] expression.
class $ifNull extends OperatorExpression {
  /// Creates `$ifNull` operator expression
  $ifNull(expression, replacement)
      : super(op$ifNull, valueToContent([expression, replacement]));
}

/// `$switch` operator
///
/// Evaluates a series of case expressions. When it finds an expression which
/// evaluates to true, $switch executes a specified expression and breaks out
/// of the control flow.
class $switch extends OperatorExpression {
  /// Creates `$switch` operator expression
  ///
  /// * [branches] - An array of control branch object. Each branch is an
  /// instance of [Case]
  /// * [defaultExpr] - Optional. The path to take if no branch case expression
  /// evaluates to true. Although optional, if default is unspecified and no
  /// branch case evaluates to true, $switch returns an error.
  $switch({required List<Case> branches, defaultExpr})
      : super(
            op$switch,
            valueToContent({
              'branches': valueToContent(branches),
              if (defaultExpr != null) 'default': valueToContent(defaultExpr)
            }));
}

/// Case branch for [$switch] operator
class Case extends MapExpression {
  /// Creates [Case] branch for Switch operator
  ///
  /// * [caseExpr] - Can be any valid expression that resolves to a boolean. If
  /// the result is not a boolean, it is coerced to a boolean value.
  /// * [thenExpr] - Can be any valid expression.
  Case({required ExpressionContent caseExpr, required thenExpr})
      : super({
          pmCase: valueToContent(caseExpr),
          pmThen: valueToContent(thenExpr)
        });
}
