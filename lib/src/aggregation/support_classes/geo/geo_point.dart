part of 'geometry.dart';

final class GeoPoint extends Geometry {
  GeoPoint(GeoPosition position)
      : super(type: GeoJsonType.point, coordinates: position.rawContent);
  GeoPoint.coordinates(List<double> coordinates)
      : super(type: GeoJsonType.point, coordinates: coordinates);
}
