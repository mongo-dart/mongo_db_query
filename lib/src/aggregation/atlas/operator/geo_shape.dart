import 'package:mongo_db_query/src/aggregation/support_classes/geo/geometry.dart';

import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

enum GeometryRelation {
  contains('contains'),
  disjoint('disjoint'),
  intersects('intersects'),
  within('within');

  const GeometryRelation(this.name);
  final String name;
}

/// The geoShape operator supports querying shapes with a relation to a given
/// geometry if indexShapes is set to true in the index definition.
///
/// When specifying the coordinates to search, longitude must be specified
/// first and then the latitude. Longitude values can be between -180 and 180,
/// both inclusive. Latitude values can be between -90 and 90, both inclusive.
/// Coordinate values can be integers or doubles.
///
/// Example
///
/// Expected result:
/// ```
/// "geoShape": {
///   "relation": "disjoint",
///   "geometry": {
///     "type": "Polygon",
///     "coordinates": [[[-161.323242,22.512557],
///                    [-152.446289,22.065278],
///                    [-156.09375,17.811456],
///                    [-161.323242,22.512557]]]
///   },
///   "path": "address.location"
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/geoShape/

class GeoShape extends AtlasOperator {
  /// [geometry] - GeoJSON object that specifies the Polygon, MultiPolygon,
  /// or LineString shape or point to search. The polygon must be specified
  /// as a closed loop where the last position is the same as the first
  /// position.
  ///
  /// When calculating geospatial results, Atlas Search geoShape and geoWithin
  /// operators and MongoDB $geoIntersects operator use different geometries.
  /// This difference can be seen in how Atlas Search and MongoDB draw
  /// polygonal edges.
  ///
  /// Atlas Search draws polygons based on Cartesian distance,
  /// which is the shortest line between two points in the coordinate
  /// reference system.
  /// MongoDB draws polygons using third-party library for geodesic types that
  /// use geodesic lines.
  ///
  /// Atlas Search and MongoDB could return different results for geospatial
  /// queries involving polygons.
  ///
  /// [path] - (String or array of strings). Strings Indexed geo type field or
  /// fields to search.
  ///
  /// [relation] - Relation of the query shape geometry to the indexed field
  /// geometry. Value can be one of the following:
  /// - contains - Indicates that the indexed geometry contains the query
  ///  geometry.
  /// - disjoint - Indicates that both the query and indexed geometries have
  ///  nothing in common.
  /// - intersects - Indicates that both the query and indexed geometries
  /// intersect.
  /// - within - Indicates that the indexed geometry is within the query
  /// geometry. You can't use within with LineString or Point.
  ///
  /// [score] - Score to assign to matching search results. By default,
  /// the score in the results is 1. You can modify the score using the
  /// following options:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  ///
  GeoShape(
      {required Geometry geometry,
      required path,
      required GeometryRelation relation,
      ScoreModify? score})
      : super(opGeoShape, {
          'geometry': geometry,
          'path': valueToContent(path),
          'relation': relation.name,
          if (score != null) ...score.build(),
        });
}
