import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// There is
abstract class ShapeOperator extends OperatorExpression {
  ShapeOperator(super.name, super.args);
}

enum GeometryObjectType {
  // ignore: constant_identifier_names
  Point,
  // ignore: constant_identifier_names
  LineString,
  // ignore: constant_identifier_names
  Polygon,
  // ignore: constant_identifier_names
  MultiPoint,
  // ignore: constant_identifier_names
  MultiLineString,
  // ignore: constant_identifier_names
  MultiPolygon
}

/// https://docs.mongodb.com/manual/reference/operator/query/geometry/#mongodb-query-op.-geometry
class $geometry extends ShapeOperator {
  $geometry(
      {required this.type,
      required List coordinates,
      Map<String, dynamic>? crs})
      : super(
            op$geometry,
            valueToContent({
              'type': type.toString().split('.').last,
              'coordinates': coordinates,
              if (crs != null) 'crs': crs
            }));

  $geometry.point(List<double> point, {Map<String, dynamic>? crs})
      : type = GeometryObjectType.Point,
        super(
            op$geometry,
            valueToContent({
              'type': GeometryObjectType.Point.toString().split('.').last,
              'coordinates': point,
              if (crs != null) 'crs': crs
            }));

  GeometryObjectType type;
}

/// https://docs.mongodb.com/manual/reference/operator/query/box/#mongodb-query-op.-box
class $box extends ShapeOperator {
  $box({required List<num> bottomLeft, required List<num> upperRight})
      : super(op$box, valueToContent([bottomLeft, upperRight]));
}

/// https://docs.mongodb.com/manual/reference/operator/query/box/#mongodb-query-op.-box
class $center extends ShapeOperator {
  $center({required List<num> center, required num radius})
      : super(op$center, valueToContent([center, radius]));
}

/// https://docs.mongodb.com/manual/reference/operator/query/box/#mongodb-query-op.-box
class $centerSphere extends ShapeOperator {
  $centerSphere({required List<num> center, required num radius})
      : super(op$centerSphere, valueToContent([center, radius]));
}

// TODO missing Polygon
