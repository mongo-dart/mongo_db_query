import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/abstract/expression_content.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';
import '../support_classes/geo/geo_json_type.dart';
import '../support_classes/geo/geometry.dart';

/// `$geoNear`
///
/// ### Stage description
/// Outputs documents in order of nearest to farthest from a specified point.
/// [see mongo db documentation](https://docs.mongodb.com/manual/reference/operator/aggregation/geoNear/#std-label-pipeline-geoNear-key-param-example)
///
///
/// Dart code:
///
/// ```
/// $geoNear(
///       near: $geometry.point([-73.99279, 40.719296]),
///       distanceField: 'dist.calculated',
///       maxDistance: 2,
///       query: where..$eq('category', 'Parks'),
///       includeLocs: 'dist.location',
///       spherical: true)
///   .build()
/// ```
///
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///    '$geoNear': {
///        'near': {
///           'type': 'Point',
///           'coordinates': [-73.99279, 40.719296]
///         },
///         'distanceField': 'dist.calculated',
///         'maxDistance': 2,
///         'spherical': true
///         'query': {'category': 'Parks'},
///         'includeLocs': 'dist.location',
///    }
/// }
/// ```
///
///
class $geoNear extends AggregationStage {
  $geoNear(
      {required Geometry near,
      required String distanceField,
      num? maxDistance,
      num? minDistance,
      bool? spherical,
      dynamic query,
      num? distanceMultiplier,
      String? includeLocs,
      String? key})
      : assert(near.rawContent['type'] == GeoJsonType.point.name,
            r"$geoNear 'near' field must be Point"),
        super(
            st$geoNear,
            valueToContent({
              // ignore: deprecated_member_use_from_same_package
              'near': near.rawContent,
              'distanceField': distanceField,
              if (maxDistance != null) 'maxDistance': maxDistance,
              if (minDistance != null) 'minDistance': minDistance,
              if (spherical != null) 'spherical': spherical,
              if (query != null) 'query': _getQuery(query),
              if (distanceMultiplier != null)
                'distanceMultiplier': distanceMultiplier,
              if (includeLocs != null) 'includeLocs': includeLocs,
              if (key != null) 'key': key
            }));

  static ExpressionContent _getQuery(query) {
    if (query is QueryExpression) {
      return MapExpression(query.filter.build());
    } else if (query is MongoDocument) {
      return valueToContent(query);
    } else {
      throw Exception(
          'restrictSearchWithMatch must be Map<String,dynamic> or QueryExpression');
    }
  }
}
