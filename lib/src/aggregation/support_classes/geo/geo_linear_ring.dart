part of 'geometry.dart';

/// LinearRings are closed LineStrings. Closed LineStrings have at least four
/// coordinate pairs and specify the same position as the first and last
/// coordinates.
final class GeoLinearRing extends GeoLineString {
  GeoLinearRing(List<GeoPoint> points)
      : super(_checkClosedLineStringPoints(points));
  GeoLinearRing.positions(List<GeoPosition> positions)
      : super.positions(_checkClosedLineStringPositions(positions));
  GeoLinearRing.coordinates(List<List<double>> coordinates)
      : super.coordinates(_checkClosedLineStringCoordinates(coordinates));

  // TODO remove
  static List<List<double>> _checkClosedLineStringCoordinates_old(
      List<List<double>> coordinates) {
    if (coordinates.length < 4) {
      throw ArgumentError('At least four coordinate pairs are required');
    }
    var firstPoint = coordinates.first;
    var lastPoint = coordinates.last;
    if (firstPoint.length == 2) {
      firstPoint.add(0.0);
    }
    if (lastPoint.length == 2) {
      lastPoint.add(0.0);
    }
    for (var i = 0; i < 3; i++) {
      if (firstPoint[i] != lastPoint[i]) {
        throw ArgumentError(
            'Not a linear ring, first and last position must be equal');
      }
    }
    return coordinates;
  }

  static List<List<double>> _checkClosedLineStringCoordinates(
      List<List<double>> coordinates) {
    List<GeoPosition> positions = [
      for (var element in coordinates) GeoPosition.coordinates(element)
    ];
    _checkClosedLineStringPositions(positions);
    return coordinates;
  }

  static List<GeoPosition> _checkClosedLineStringPositions(
      List<GeoPosition> positions) {
    if (positions.length < 4) {
      throw ArgumentError('At least four positions are required');
    }
    if (positions.first != positions.last) {
      throw ArgumentError(
          'Not a linear ring, first and last position must be equal');
    }

    return positions;
  }

  static List<GeoPoint> _checkClosedLineStringPoints(List<GeoPoint> points) {
    if (points.length < 4) {
      throw ArgumentError('At least four positions are required');
    }
    if (points.first != points.last) {
      throw ArgumentError(
          'Not a linear ring, first and last point must be equal');
    }

    return points;
  }
}
