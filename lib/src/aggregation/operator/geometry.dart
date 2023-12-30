import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/shape_operator.dart';
import '../support_classes/geo/geometry.dart';

/// https://docs.mongodb.com/manual/reference/operator/query/geometry/#mongodb-query-op.-geometry
class $geometry extends ShapeOperator {
  $geometry({required Geometry geometry, Map<String, dynamic>? crs})
      : super(
            op$geometry,
            valueToContent(
                {...geometry.rawContent, if (crs != null) 'crs': crs}));
}
