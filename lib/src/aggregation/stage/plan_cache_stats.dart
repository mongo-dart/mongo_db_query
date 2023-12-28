import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_base.dart';

/// `$planCacheStats` aggregation stage
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
/// $planCacheStats().build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $planCacheStats: { } }
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/planCacheStats/
class $planCacheStats extends AggregationStage {
  /// Creates `$listSampledQueries` aggregation stage
  ///
  $planCacheStats() : super(st$planCacheStats, MapExpression({}));
}
