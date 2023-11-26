import '../base/operator_expression.dart';
import '../query_expression/query_expression.dart';

import '../base/common/operators_def.dart';

/// `$and` operator
class $and extends OperatorExpression {
  /// Creates `$and` operator expression
  ///
  /// Evaluates one or more expressions and returns `true` if all of the
  /// expressions are `true` or if evoked with no argument expressions. Otherwise,
  /// `$and` returns `false`.
  $and(List args) : super(op$and, valueToContent(args));
}

/// `$or` operator
class $or extends OperatorExpression {
  /// Creates `$or` operator expression
  ///
  /// Evaluates one or more expressions and returns `true` if any of the expressions
  /// are `true`. Otherwise, `$or` returns `false`.
  $or(List args) : super(op$or, valueToContent(args));
}

/// `$not` operator
class $not extends OperatorExpression {
  /// Creates `$not` operator expression
  ///
  /// Evaluates a boolean and returns the opposite boolean value; i.e. when
  /// passed an expression that evaluates to `true`, `$not` returns `false`; when
  /// passed an expression that evaluates to `false`, $not returns `true`.
  $not(expr) : super(op$not, valueToContent(expr));
}
