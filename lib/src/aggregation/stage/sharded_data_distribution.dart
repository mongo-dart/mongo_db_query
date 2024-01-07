import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$shardedDataDistribution` aggregation stage
///
/// ### Stage description
///
/// New in version 6.0.3.
///
/// Returns information on the distribution of data in sharded collections.
///
/// **Note** - This aggregation stage is only available on *mongos*.
///
/// Examples:
///
/// Dart code:
/// ```
/// $shardedDataDistribution().build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $shardedDataDistribution: { } }
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/shardedDataDistribution/
class $shardedDataDistribution extends AggregationStage {
  /// Creates `$shardedDataDistribution` aggregation stage
  $shardedDataDistribution()
      : super(st$shardedDataDistribution, valueToContent({}));
}
