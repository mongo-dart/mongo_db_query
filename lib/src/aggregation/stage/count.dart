import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$count` aggregation stage
///
/// ### Stage description
///
/// Passes a document to the next stage that contains a count of the number of
/// documents input to the stage.
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/count/
class $count extends AggregationStage {
  /// Creates `$count` aggregation stage
  ///
  /// [fieldName] - is the name of the output field which has the count as its
  /// value. [fieldName] must be a non-empty string and must not contain the `.`
  /// character.
  $count(String fieldName) : super(st$count, valueToContent(fieldName));
}
