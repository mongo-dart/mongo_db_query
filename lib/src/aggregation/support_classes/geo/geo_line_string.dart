part of 'geometry.dart';

final class GeoLineString extends Geometry {
  GeoLineString(List<GeoPoint> points)
      : super(type: GeoJsonType.lineString, coordinates: [
          for (var point in points) point.rawContent['coordinates']
        ]);
  GeoLineString.positions(List<GeoPosition> positions)
      : super(
            type: GeoJsonType.lineString,
            coordinates: ListExpression(positions).rawContent);
  GeoLineString.coordinates(List<List<double>> coordinates)
      : super(type: GeoJsonType.lineString, coordinates: coordinates);
}
