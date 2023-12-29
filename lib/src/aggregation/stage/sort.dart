import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$sort` aggregation stage
///
/// ### Stage description
///
/// Sorts all input documents and returns them to the pipeline in sorted order.
///
/// Example:
///
/// Dart code:
/// ```
/// $sort({'age': -1, 'posts': 1}).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $sort : { age : -1, posts: 1 } }
/// ```
/// or
/// ```
/// $sort.query(where..sortBy({'age': -1})..sortBy('posts')).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $sort : { age : -1, posts: 1 } }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/sort/
class $sort extends AggregationStage {
  /// Creates `$sort` aggregation stage
  ///
  /// [specification] - a document that specifies the field(s) to sort by and
  /// the respective sort order. Sort order can have one of the following
  /// values:
  ///
  /// * 1 to specify ascending order.
  /// * -1 to specify descending order.
  /*  $sort(Map<String, dynamic> specification)
      : super('sort', AEObject(specification)); */
  $sort(Map<String, dynamic> specification)
      : super(st$sort, valueToContent(specification));

  /// [query] - QueryExpression containing the number of documents to skip
  $sort.query(QueryExpression query) : super(st$sort, query.sortExp);
}
