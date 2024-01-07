import 'package:mongo_db_query/mongo_db_query.dart';

import '../../../base/map_expression.dart';

/// Specifies the bottom left and top right GeoJSON points of a box to search
/// within.
///
/// Example
///
/// Expected Result
/// ```
/// {
///    "bottomLeft": {
///      "type": "Point",
///      "coordinates": [112.467, -55.050]
///    },
///    "topRight": {
///      "type": "Point",
///      "coordinates": [168.000, -9.133]
///    }
/// }
/// ```
base class Box extends MapExpression {
  /// [bottomLeft] - Bottom left GeoJSON point.
  ///
  /// [topRight] - Top right GeoJSON point.
  Box(this.bottomLeft, this.topRight)
      : super(<String, dynamic>{
          'bottomLeft': bottomLeft,
          'topRight': topRight,
        });

  final GeoPoint bottomLeft;
  final GeoPoint topRight;
}
