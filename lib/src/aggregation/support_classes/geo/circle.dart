import '../../../base/map_expression.dart';
import '../../../query_expression/query_expression.dart';
import 'geometry.dart';

/// Specifies the center point and the radius in meters to search within.
///
/// Example
///
/// Expected Result
/// ```
/// {
///    "center": {
///      "type": "Point",
///      "coordinates": [-73.54, 45.54]
///    },
///    "radius": 1600
///  },
/// ```
base class Circle extends MapExpression {
  /// [center] -  Center of the circle specified as a GeoJSON point.
  ///
  /// [radius] - Radius, which is a number, specified in meters.
  /// Value must be greater than or equal to 0.
  Circle(this.center, this.radius)
      : super(<String, dynamic>{
          'center': center,
          'radius': valueToContent(radius),
        });

  final GeoPoint center;
  final num radius;
}
