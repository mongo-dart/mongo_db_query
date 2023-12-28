import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$let` operator expression
///
/// Binds variables for use in the specified expression, and returns the
/// result of the expression.
class $let extends OperatorExpression {
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
