import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$toObjectId` operator expression
///
/// Converts a value to an ObjectId. If the value cannot be converted to an
/// `ObjectId`, `$toObjectId` errors. If the value is `null` or missing,
/// `$toObjectId` returns `null`.
class $toObjectId extends OperatorExpression {
  ///
  /// The [$toObjectId] takes any valid expression.
  $toObjectId(expr) : super(op$toObjectId, valueToContent(expr));
}
