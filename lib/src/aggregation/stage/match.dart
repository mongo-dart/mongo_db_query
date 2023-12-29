import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$match` aggregation stage
///
/// ### Stage description
///
/// Filters the documents to pass only the documents that match the specified
/// condition(s) to the next pipeline stage.
///
/// Examples:
///
/// 1. Using [QueryExpression] query
///
/// Dart code:
/// ```
/// $match(where..$eq('author', 'dave')).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$match: {author: "dave"}}
/// ```
///
/// 2. Using aggregation expression:
///
/// Dart code:
/// ```
/// $match($expr($eq(Field('author'), 'dave'))).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$match: {$expr: {$eq: ['$author', 'dave']}}}
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/match/
class $match extends AggregationStage {
  /// Creates `$match` aggreagtion stage
  ///
  /// [query] can be either a [QueryExpression] or an aggregation
  /// expression wrapped in [Expr]
  $match(query) : super(st$match, valueToContent(query));
}
