import '../common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../abstract/shape_operator.dart';

/// https://docs.mongodb.com/manual/reference/operator/query/box/#mongodb-query-op.-box
class $box extends ShapeOperator {
  $box({required List<num> bottomLeft, required List<num> upperRight})
      : super(op$box, valueToContent([bottomLeft, upperRight]));
}
