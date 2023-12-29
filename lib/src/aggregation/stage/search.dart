import 'package:mongo_db_query/src/aggregation/base/atlas_collector.dart';
import 'package:mongo_db_query/src/aggregation/base/atlas_operator.dart';
import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$search` aggregation stage
///
/// ### Stage description
///
/// The $search stage performs a full-text search on the specified field or
/// fields which must be covered by an Atlas Search index.
/// https://www.mongodb.com/docs/atlas/atlas-search/query-syntax/#mongodb-pipeline-pipe.-search
class $search extends AggregationStage {
  /// [index] -
  /// [collector] -
  /// [highlight] -
  /// [concurrent] -
  /// [count] -
  /// [scoreDetails] -
  /// [sort] -
  /// [returnStoredSource] -
  /// [tracking] -

  $search(
      {AtlasCollector? collector,
      AtlasOperator? operator,
      String? index,
      highlight,
      bool? concurrent,
      count,
      bool? scoreDetails,
      IndexDocument? sort,
      bool? returnStoredSource,
      tracking})
      : super(
            st$search,
            MapExpression({
              if (collector != null) 'collectorName': valueToContent(collector),
              if (collector == null && operator != null)
                'operatorName': valueToContent(operator),
              if (index != null) 'index': valueToContent(index),
              if (concurrent != null) 'concurrent': valueToContent(concurrent),
              if (count != null) 'count': valueToContent(count),
              if (highlight != null) 'highlight': valueToContent(highlight),
              if (scoreDetails != null)
                'scoreDetails': valueToContent(scoreDetails),
              if (sort != null) 'sort': valueToContent(sort),
              if (returnStoredSource != null)
                'returnStoredSource': valueToContent(returnStoredSource),
              if (tracking != null) 'tracking': valueToContent(tracking),
            }));
  $search.raw(MongoDocument raw) : super.raw(st$search, raw);
}
