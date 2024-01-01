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
      : super(type: GeoJsonType.multiPoint, coordinates: [
          for (var element in coordinates)
            [
              if (element.isNotEmpty)
                element.first
              else
                throw ArgumentError('Missing longitude'),
              if (element.length > 1)
                element[1]
              else
                throw ArgumentError('Missing latitude'),
              if (element.length > 2) element[2]
            ]
        ]);

  // TODO operator==
}
