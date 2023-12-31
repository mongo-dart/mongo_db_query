import '../../../base/list_expression.dart';
import '../../../base/map_expression.dart';
import 'geo_json_type.dart';
import 'geo_position.dart';

part 'geo_point.dart';
part 'geo_line_string.dart';
part 'geo_multi_point.dart';

base class Geometry extends MapExpression {
  Geometry({required this.type, required List coordinates})
      : super(<String, dynamic>{
          'type': type.name,
          'coordinates': coordinates,
        });

  factory Geometry.point(List<double> point) => GeoPoint.coordinates(point);

  factory Geometry.multiPoint(List<List<double>> points) =>
      GeoMultiPoint.coordinates(points);

  factory Geometry.lineString(List<List<double>> points) =>
      GeoLineString.coordinates(points);

  GeoJsonType type;
}
