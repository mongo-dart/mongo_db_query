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
