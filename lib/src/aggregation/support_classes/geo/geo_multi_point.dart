part of 'geometry.dart';

final class GeoMultiPoint extends Geometry {
  GeoMultiPoint(List<GeoPoint> points)
      : super(type: GeoJsonType.multiPoint, coordinates: [
          for (var point in points) point.rawContent['coordinates']
        ]);
  GeoMultiPoint.positions(List<GeoPosition> positions)
      : super(
            type: GeoJsonType.multiPoint,
            coordinates: ListExpression(positions).rawContent);
  GeoMultiPoint.coordinates(List<List<double>> coordinates)
      : super(type: GeoJsonType.multiPoint, coordinates: coordinates);
}
