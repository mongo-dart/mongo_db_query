import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../../query_expression/filter_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$vectorSearch` aggregation stage
///
/// ### Stage description
///
/// The $vectorSearch stage performs an aNN search on a vector in the specified
/// field. The field that you want to search must be indexed as Atlas Vector
/// Search vector type inside a vectorSearch index type.
///
/// https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-stage/
class $vectorSearch extends AggregationStage {
  /// [index] - Name of the Atlas Vector Search index to use.
  /// Atlas Vector Search doesn't return results if you misspell the index
  /// name or if the specified index doesn't already exist on the cluster.
  ///
  /// [limit] - Number (of type int only) of documents to return in the
  /// results. Value can't exceed the value of numCandidates.
  ///
  /// [numCandidates] - Number of nearest neighbors to use during the search.
  /// Value must be less than or equal to (<=) 10000. You can't specify a
  /// number less than the number of documents to return (limit).
  ///
  /// We recommend that you specify a number higher than the number of
  /// documents to return (limit) to increase accuracy although this might
  /// impact latency. For example, we recommend a ratio of ten to twenty
  /// nearest neighbors for a limit of only one document. This overrequest
  /// pattern is the recommended way to trade off latency and recall in
  /// your aNN searches, and we recommend tuning this on your specific dataset.
  ///
  /// [path] - Indexed vectorEmbedding type field to search
  ///
  /// [queryVector] - Array of numbers of the BSON double type that represent
  /// the query vector. The array size must match the number of vector
  /// dimensions specified in the index definition for the field.
  ///
  /// Examples:
  ///
  /// Dart code:
  /// ```
  /// $vectorSearch(index: 'vector_index',
  ///               path: 'plot_embedding',
  ///               queryVector:  [-0.0016261312,-0.028070757,-0.011342932],
  ///               numCandidates: 150,
  ///               limit: 10).build()
  /// ```
  ///
  /// Expected Result
  /// ```
  /// "$vectorSearch": {
  ///    "index": "vector_index",
  ///    "path": "plot_embedding",
  ///    "queryVector": [-0.0016261312,-0.028070757,-0.011342932],
  ///    "numCandidates": 150,
  ///    "limit": 10
  ///  }
  /// ```
  $vectorSearch(
      {required String index,
      required int limit,
      required int numCandidates,
      required String path,
      required List<num> queryVector,
      FilterExpression? filter})
      : super(
            st$vectorSearch,
            MapExpression({
              'index': valueToContent(index),
              'path': valueToContent(path),
              if (filter != null) 'filter': filter.build(),
              'queryVector': valueToContent(queryVector),
              'numCandidates': valueToContent(numCandidates),
              'limit': valueToContent(limit),
            }));
  $vectorSearch.raw(MongoDocument raw) : super.raw(st$vectorSearch, raw);
}
