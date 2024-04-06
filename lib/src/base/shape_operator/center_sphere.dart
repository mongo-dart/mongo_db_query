import '../common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../abstract/shape_operator.dart';

/// https://docs.mongodb.com/manual/reference/operator/query/box/#mongodb-query-op.-box
class $centerSphere extends ShapeOperator {
  $centerSphere({required List<num> center, required num radius})
      : super(op$centerSphere, valueToContent([center, radius]));
}
