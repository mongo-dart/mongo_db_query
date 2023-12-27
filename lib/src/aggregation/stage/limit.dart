import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$limit` aggregation stage
///
/// ### Stage description
///
/// Limits the number of documents passed to the next stage in the pipeline.
///
/// Example:
///
/// Dart code:
/// ```
/// $limit(5).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$limit: 5}
/// ```
/// or
/// ```
/// $limit.query(where..limit(5)).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$limit: 5}
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/limit/
class $limit extends AggregationStage {
  /// Creates `$limit` aggregation stage
  ///
  /// [count] - a positive integer that specifies the maximum number of
  /// documents to pass along.
  $limit(int count) : super(st$limit, valueToContent(count));

  /// [query] - QueryExpression containing the number of documents to skip
  $limit.query(QueryExpression query)
      : super(st$limit, valueToContent(query.getLimit()));
}
