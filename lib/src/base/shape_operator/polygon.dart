import '../common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../abstract/shape_operator.dart';

/// https://www.mongodb.com/docs/manual/reference/operator/query/polygon/
class $polygon extends ShapeOperator {
  $polygon({required List<List<num>> points})
      : super(op$polygon, valueToContent(points));
}
