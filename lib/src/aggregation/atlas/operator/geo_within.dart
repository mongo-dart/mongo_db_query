import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';

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
///
/// ```
///
/// Expected result:
/// ```
///
/// ```
///

// GeoWithin
//class GeoWithin extends AtlasOperator {
/// [field] -
///
/*   GeoWithin({field})
      : super(opGeoWithin, {
          if (field != null) 'field': valueToContent(field),
        });
} */
