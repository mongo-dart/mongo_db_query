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
      : super(type: GeoJsonType.lineString, coordinates: [
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
