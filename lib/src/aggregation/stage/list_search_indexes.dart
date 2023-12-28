import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$listSearchIndexes` aggregation stage
///
/// ### Stage description
///
/// New in version 7.0: (Also available starting in 6.0.7).
/// Returns information about existing Atlas Search indexes on a specified
/// collection.
///
/// You cannot specify both id and name. If you omit both the id and name
/// fields, $listSearchIndexes returns information about all Atlas Search
/// indexes on the collection.
///
/// Examples:
///
/// Dart code:
/// ```
/// $listSearchIndexes(name: 'synonym-mappings').build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $listSearchIndexes: { name: "synonym-mappings" }}
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/listSearchIndexes/
class $listSearchIndexes extends AggregationStage {
  /// Creates `$listSampledQueries` aggregation stage
  /// [id] - The id of the index to return information about.
  /// [name] - The name of the index to return information about.
  $listSearchIndexes({String? id, String? name})
      : super(
            st$listSearchIndexes,
            valueToContent({
              if (id != null) 'id': valueToContent(id),
              if (name != null) 'name': valueToContent(name)
            }));
}
