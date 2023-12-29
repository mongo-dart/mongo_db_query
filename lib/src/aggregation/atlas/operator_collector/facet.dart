import '../../../base/common/operators_def.dart';
import '../../../base/map_expression.dart';
import '../../base/atlas_collector.dart';
import '../../base/atlas_operator.dart';
import 'support/facet_type.dart';

export 'support/facet_type.dart';

/// The facet collector groups results by values or ranges in the specified
/// faceted fields and returns the count for each of those groups.
///  You can use facet with both the $search and $searchMeta stages.
/// MongoDB recommends using facet with the $searchMeta stage to retrieve
///  metadata results only for the query. To retrieve metadata results and
/// query results using the $search stage, you must use the $$SEARCH_META
/// aggregation variable. See SEARCH_META Aggregation Variable to learn more.
class Facet extends AtlasCollector {
  Facet(List<FacetType> facets, {AtlasOperator? operator})
      : super(coFacet, {
          if (operator != null) 'operator': operator.build(),
          'facets': {for (var element in facets) ...element.build()}
        });
}
