import '../base/common/operators_def.dart';
import '../base/expression_content.dart';
import '../base/operator_expression.dart';
import '../query_expression/query_expression.dart';

/// `$expr` operator
class $expr extends OperatorExpression {
  /// Creates an `$expr` part of `$match` stage
  ///
  /// The operator is used in `match` aggregation stage to define match expression
  /// as aggregation expression.
  ///
  /// [expr] - aggregation expression which usually resolves into [bool]
  $expr(ExpressionContent expr) : super(op$expr, valueToContent(expr));
}

/// `$let` operator
class $let extends OperatorExpression {
  /// Creates `$let` operator expression
  ///
  /// Binds variables for use in the specified expression, and returns the
  /// result of the expression.
  ///
  /// * [vars] - Assignment block for the variables accessible in the in
  /// expression. To assign a variable, specify a string for the variable name
  /// and assign a valid expression for the value. The variable assignments
  /// have no meaning outside the in expression, not even within the vars block
  /// itself.
  /// * [inExpr] - The expression to evaluate.
  $let({required Map<String, dynamic> vars, required inExpr})
      : super(
            op$let,
            valueToContent(
                {'vars': valueToContent(vars), 'in': valueToContent(inExpr)}));
}

// TODO: Trigonometry Expression Operators
// TODO: Text Expression Operator
