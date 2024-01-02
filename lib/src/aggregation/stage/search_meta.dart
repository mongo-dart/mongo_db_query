import 'package:mongo_db_query/src/aggregation/base/atlas_collector.dart';
import 'package:mongo_db_query/src/aggregation/base/atlas_operator.dart';
import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../atlas_operator_collector.dart';
import '../base/aggregation_stage.dart';

/// `$searchMeta` aggregation stage
///
/// ### Stage description
///
/// The `$searchMeta` stage returns different types of metadata result
/// documents.
///
/// Expected result
/// ```
/// {
///  "$searchMeta": {
///    "range": {
///      "path": "year",
///      "gte": 1998,
///      "lt": 1999
///   },
///   "count": {
///     "type": "total"
///   }
///  }
///}
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/query-syntax/#-searchmeta
class $searchMeta extends AggregationStage {
  /// [index] - Name of the Atlas Search index to use. If omitted,
  /// defaults to "default".
  ///
  /// [collector] - Name of the collector to use with the query.
  /// You can provide a document that contains the collector-specific
  /// options as the value for this field. Either this or <operator-name> is
  /// required.
  ///
  /// [operator] - Name of the operator to search with. You can provide a
  /// document that contains the operator-specific options as the value for
  /// this field. Either this or <collector-name> is required.
  /// Use the compound operator to run a compound query with multiple operators.
  ///
  /// [count] - Document that specifies the count options for retrieving a
  ///  count of the results. To learn more, see Count Atlas Search Results.
  $searchMeta({
    AtlasCollector? collector,
    AtlasOperator? operator,
    String? index,
    Count? count,
  }) : super(
            st$searchMeta,
            MapExpression({
              if (collector != null) ...collector.build(),
              if (collector == null && operator != null) ...operator.build(),
              if (index != null) 'index': valueToContent(index),
              if (count != null) ...count.build(),
            }));
  $searchMeta.raw(MongoDocument raw) : super.raw(st$searchMeta, raw);
}
