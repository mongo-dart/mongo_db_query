import '../../../base/map_expression.dart';
import 'geo_json_type.dart';

// TODO missing Polygon

class Geometry extends MapExpression {
  Geometry(
      {required this.type,
      required List coordinates,
      Map<String, dynamic>? crs})
      : super(<String, dynamic>{
          'type': type.name,
          'coordinates': coordinates,
          if (crs != null) 'crs': crs
        });

  Geometry.point(List<double> point, {Map<String, dynamic>? crs})
      : type = GeoJsonType.point,
        super({
          'type': GeoJsonType.point.name,
          'coordinates': point,
          if (crs != null) 'crs': crs
        });

  GeoJsonType type;
}
