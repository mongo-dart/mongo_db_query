import 'package:mongo_db_query/src/aggregation/atlas/options/score_modify.dart';

import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../../support_classes/geo/box.dart';
import '../../support_classes/geo/circle.dart';
import '../../support_classes/geo/geometry.dart';

/// The geoWithin operator supports querying geographic points within a given
/// geometry. Only points are returned, even if indexShapes value is true in
/// the index definition.
///
/// You can query points within a:
/// - Circle
/// - Bounding box
/// - Polygon
///
/// When specifying the coordinates to search, longitude must be specified
/// first and then the latitude. Longitude values can be between -180 and 180,
///  both inclusive. Latitude values can be between -90 and 90, both inclusive.
/// Coordinate values can be integers or doubles.
///
/// Example
///
/// Expected result:
/// ```
/// "geoWithin": {
///   "path": "address.location",
///   "box": {
///     "bottomLeft": {
///       "type": "Point",
///       "coordinates": [112.467, -55.050]
///     },
///     "topRight": {
///       "type": "Point",
///       "coordinates": [168.000, -9.133]
///     }
///   }
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/geoWithin/
class GeoWithin extends AtlasOperator {
  /// [box] - Object that specifies the bottom left and top right GeoJSON
  /// points of a box to search within. The object takes the following fields:
  /// - bottomLeft - Bottom left GeoJSON point.
  /// - topRight - Top right GeoJSON point.
  ///
  /// To learn how to specify GeoJSON data inside a GeoJSON object,
  /// see GeoJSON Objects.
  ///
  /// Either box, circle, or geometry is required.
  ///
  /// [circle] - Object that specifies the center point and the radius in
  /// meters to search within. The object contains the following GeoJSON fields:
  /// - center - Center of the circle specified as a GeoJSON point.
  /// - radius - Radius, which is a number, specified in meters. Value must
  /// be greater than or equal to 0.
  ///
  /// To learn how to specify GeoJSON data inside a GeoJSON object,
  /// see GeoJSON Objects.
  ///
  /// Either circle, box, or geometry is required.
  ///
  /// [geometry] - GeoJSON object that specifies the MultiPolygon or Polygon to
  /// search within. The polygon must be specified as a closed loop where the
  /// last position is the same as the first position.
  ///
  /// When calculating geospatial results, Atlas Search geoShape and geoWithin
  /// operators and MongoDB $geoIntersects operator use different geometries.
  /// This difference can be seen in how Atlas Search and MongoDB draw
  /// polygonal edges.
  ///
  /// Atlas Search draws polygons based on Cartesian distance, which is the
  /// shortest line between two points in the coordinate reference system.
  ///
  /// MongoDB draws polygons using third-party library for geodesic types that
  /// use geodesic lines. To learn more, see GeoJSON Objects.
  ///
  /// Atlas Search and MongoDB could return different results for geospatial
  /// queries involving polygons.
  ///
  /// To learn how to specify GeoJSON data inside a GeoJSON object, see
  /// GeoJSON Objects.
  ///
  /// Either geometry, box, or circle is required.
  ///
  /// [path] - (string or array of strings) - Indexed geo type field or fields
  /// to search.
  ///
  /// [score] - Score to assign to matching search results. By default,
  /// the score in the results is 1. You can modify the score using the
  /// following options:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  GeoWithin(
      {Box? box,
      Circle? circle,
      Geometry? geometry,
      required path,
      ScoreModify? score})
      : super(opGeoWithin, {
          if (box != null) 'box': box,
          if (circle != null) 'circle': circle,
          if (geometry != null) 'geometry': geometry,
          'path': valueToContent(path),
          if (score != null) ...score.build()
        });
}
