part of 'geometry.dart';

final class GeoPoint extends Geometry {
  GeoPoint(GeoPosition position)
      : super(type: GeoJsonType.point, coordinates: position.rawContent);
  GeoPoint.coordinates(List<double> coordinates)
      : super(type: GeoJsonType.point, coordinates: coordinates);

  @override
  int get hashCode => Object.hashAll((valueMap['coordinates'].length > 2
      ? valueMap['coordinates'].sublist(0, 3)
      : [...valueMap['coordinates'], 0.0]));

  @override
  bool operator ==(Object other) {
    return other is GeoPoint &&
        valueMap['coordinates'].first == other.valueMap['coordinates'].first &&
        valueMap['coordinates'][1] == other.valueMap['coordinates'][1] &&
        (valueMap['coordinates'].length > 2 ? valueMap['coordinates'][2] : 0) ==
            (other.valueMap['coordinates'].length > 2
                ? other.valueMap['coordinates'][2]
                : 0);
  }
}
