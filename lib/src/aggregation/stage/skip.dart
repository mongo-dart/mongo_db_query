import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$skip` aggregation stage
///
/// ### Stage description
///
/// Skips over the specified number of documents that pass into the stage and
/// passes the remaining documents to the next stage in the pipeline.
///
/// Example:
///
/// Dart code:
/// ```
/// $skip(5).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$skip: 5}
/// ```
/// or
/// ```
/// $skip.query(where..skip(5)).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$skip: 5}
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/skip/
class $skip extends AggregationStage {
  /// Creates `$skip` aggregation stage
  ///
  /// [count] - positive integer that specifies the maximum number of documents
  /// to skip.
  $skip(int count) : super(st$skip, valueToContent(count));

  /// [query] - QueryExpression containing the number of documents to skip
  $skip.query(QueryExpression query)
      : super(st$skip, valueToContent(query.getSkip()));
}
