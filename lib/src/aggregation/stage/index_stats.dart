import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_stage.dart';

/// `$indexStats` aggregation stage
///
/// ### Stage description.
///
/// Example:
///
/// Dart code
/// ```dart
/// $indexStats().build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  $indexStats: {}
/// }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/indexStats/
class $indexStats extends AggregationStage {
  $indexStats() : super(st$indexStats, MapExpression({}));
}
