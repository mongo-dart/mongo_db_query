import 'package:mongo_db_query/src/aggregation/base/atlas_collector.dart';
import 'package:mongo_db_query/src/aggregation/base/atlas_operator.dart';
import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../atlas_operator_collector.dart';
import '../base/aggregation_stage.dart';

/// `$search` aggregation stage
///
/// ### Stage description
///
/// The $search stage performs a full-text search on the specified field or
/// fields which must be covered by an Atlas Search index.
/// https://www.mongodb.com/docs/atlas/atlas-search/query-syntax/#mongodb-pipeline-pipe.-search
class $search extends AggregationStage {
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
  /// [highlight] - Document that specifies the highlighting options for
  /// displaying search terms in their original context.
  ///
  /// [concurrent] - Parallelize search across segments on dedicated search
  /// nodes. If you don't have separate search nodes on your cluster,
  /// Atlas Search ignores this flag. If omitted, defaults to false.
  ///
  /// [count] - Document that specifies the count options for retrieving a
  ///  count of the results. To learn more, see Count Atlas Search Results.
  ///
  /// [scoreDetails] - Flag that specifies whether to retrieve a detailed
  /// breakdown of the score for the documents in the results. If omitted,
  /// defaults to false. To view the details, you must use the $meta expression
  /// in the $project stage.
  ///
  /// [sort] - Document that specifies the fields to sort the Atlas Search
  /// results by in ascending or descending order. You can sort by date,
  /// number (integer, float, and double values), and string values
  ///
  /// [returnStoredSource] - Flag that specifies whether to perform a full
  /// document lookup on the backend database or return only stored source
  /// fields directly from Atlas Search. If omitted, defaults to false.
  ///
  /// [tracking] - Document that specifies the tracking option to retrieve
  /// analytics information on the search terms.

  $search(
      {AtlasCollector? collector,
      AtlasOperator? operator,
      String? index,
      Highlight? highlight,
      bool? concurrent,
      Count? count,
      bool? scoreDetails,
      IndexDocument? sort,
      bool? returnStoredSource,
      Tracking? tracking})
      : super(
            st$search,
            MapExpression({
              if (collector != null) ...collector.build(),
              if (collector == null && operator != null) ...operator.build(),
              if (index != null) 'index': valueToContent(index),
              if (concurrent != null) 'concurrent': valueToContent(concurrent),
              if (count != null) ...count.build(),
              if (highlight != null) ...highlight.build(),
              if (scoreDetails != null)
                'scoreDetails': valueToContent(scoreDetails),
              if (sort != null) 'sort': valueToContent(sort),
              if (returnStoredSource != null)
                'returnStoredSource': valueToContent(returnStoredSource),
              if (tracking != null) ...tracking.build(),
            }));
  $search.raw(MongoDocument raw) : super.raw(st$search, raw);
}
