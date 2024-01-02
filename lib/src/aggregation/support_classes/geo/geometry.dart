import '../../../base/list_expression.dart';
import '../../../base/map_expression.dart';
import 'geo_json_type.dart';
import 'geo_position.dart';
import 'geo_shape.dart';

part 'geo_point.dart';
part 'geo_line_string.dart';
part 'geo_linear_ring.dart';
part 'geo_polygon.dart';

part 'geo_multi_point.dart';
part 'geo_multi_line_string.dart';
part 'geo_multi_polygon.dart';

base class Geometry extends MapExpression {
  Geometry({required this.type, required List coordinates})
      : super(<String, dynamic>{
          'type': type.name,
          'coordinates': coordinates,
        });

  static GeoPoint point(List<double> point) => GeoPoint.coordinates(point);

  factory Geometry.multiPoint(List<List<double>> points) =>
      GeoMultiPoint.coordinates(points);

  factory Geometry.lineString(List<List<double>> points) =>
      GeoLineString.coordinates(points);

  factory Geometry.polygon(List<List<List<double>>> rings) =>
      GeoPolygon.coordinates(rings);

  GeoJsonType type;
}
