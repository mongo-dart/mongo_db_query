import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$listSampledQueries` aggregation stage
///
/// ### Stage description
///
/// Returns sampled queries for all collections or a specific collection.
/// Sampled queries are used by the analyzeShardKey command to calculate
/// metrics about the read and write distribution of a shard key.
///
/// Examples:
///
/// Dart code:
/// ```
/// $listSampledQueries(namespace: 'social.post').build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $listSampledQueries: { namespace: "social.post" } }
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/listSampledQueries/
class $listSampledQueries extends AggregationStage {
  /// Creates `$listSampledQueries` aggregation stage
  /// [namespace] - To list sampled queries for a single collection,
  /// specify the collection in the [namespace] argument.
  $listSampledQueries({String? namespace})
      : super(
            st$listSampledQueries,
            valueToContent({
              if (namespace != null) 'namespace': valueToContent(namespace)
            }));
}
