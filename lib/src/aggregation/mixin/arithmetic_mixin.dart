import '../../base/common/operators_def.dart';
import '../../base/expression_content.dart';
import '../../base/map_expression.dart';
import '../../base/operator_expression.dart';
import 'sequence_mixin.dart';

mixin ArithmeticMixin implements SequenceMixin<MapExpression> {
  /// `$abs` operator
  ///
  /// Returns the absolute value of an [expr]
  $abs(ExpressionContent expr) =>
      sequence.add(MapExpression(OperatorExpression(op$abs, expr).build()));
}
