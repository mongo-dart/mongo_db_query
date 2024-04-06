import '../common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../abstract/shape_operator.dart';

/// https://docs.mongodb.com/manual/reference/operator/query/box/#mongodb-query-op.-box
class $center extends ShapeOperator {
  $center({required List<num> center, required num radius})
      : super(op$center, valueToContent([center, radius]));
}
