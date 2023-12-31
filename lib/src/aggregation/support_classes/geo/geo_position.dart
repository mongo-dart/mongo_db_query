import '../../../base/list_expression.dart';

class GeoPosition extends ListExpression {
  GeoPosition(double longitude, double latitude, {double? altitude})
      : super([longitude, latitude, if (altitude != null) altitude]);
  GeoPosition.coordinates(List<double> positions)
      : super([
          if (positions.isNotEmpty)
            positions.first
          else
            throw ArgumentError('Missing longitude'),
          if (positions.length > 1)
            positions[1]
          else
            throw ArgumentError('Missing latitude'),
          if (positions.length > 2) positions[2]
        ]);

  @override
  int get hashCode => Object.hashAll(
      (values.length > 2 ? values.sublist(0, 3) : [...values, 0.0]));

  @override
  bool operator ==(Object other) {
    return other is GeoPosition &&
        values.first == other.values.first &&
        values[1] == other.values[1] &&
        (values.length > 2 ? values[2] : 0) ==
            (other.values.length > 2 ? other.values[2] : 0);
  }
}
