import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../aggregation_pipeline_builder.dart';
import '../base/aggregation_base.dart';

/// `$unionWith` aggregation stage
///
/// ### Stage description
///
/// New in version 4.4.
///
/// Performs a union of two collections. $unionWith combines pipeline results
/// from two collections into a single result set. The stage outputs the
///  combined result set (including duplicates) to the next stage.
///
/// The order in which the combined result set documents are output
/// is unspecified.
///
/// Examples:
///
/// Dart code:
/// ```
///  $unionWith(
///    coll: 'warehouses',
///    pipeline: [
///      $project.raw({'state': 1, '_id': 0})
///    ],
///  ).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///   $unionWith: {
///      coll: "warehouses",
///      pipeline: [
///        { $project:
///          { state: 1, _id: 0 }
///        }
///      ]
///   }
/// }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/unionWith/
class $unionWith extends AggregationStage {
  /// Creates `$UnionWith` stage with it's own pipeline
  ///
  /// * [coll] - The collection or view whose pipeline results you
  ///   wish to include in the result set.
  /// * [pipeline] - Optional. An aggregation pipeline to apply to the
  ///   specified coll.
  ///     [ <stage1>, <stage2>, ...]
  ///   The pipeline cannot include the $out and $merge stages.
  ///
  ///   The combined results from the previous stage and the $unionWith stage
  ///   can include duplicates.
  ///
  /// NOTE:
  ///
  /// The $unionWith operation would correspond to the following SQL statement:
  /// ```
  ///    SELECT *
  ///   FROM Collection1
  ///   WHERE ...
  ///   UNION ALL
  ///   SELECT *
  ///   FROM Collection2
  ///   WHERE ...
  /// ```
  /// The pipeline cannot directly access the input document fields. Instead,
  /// first define the variables for the input document fields, and then
  /// reference the variables in the stages in the pipeline.
  /// * [as] - Specifies the name of the new array field to add to the input
  /// documents. The new array field contains the matching documents from the
  /// from collection. If the specified name already exists in the input
  /// document, the existing field is overwritten.
  $unionWith({required String coll, AggregationPipeline? pipeline})
      : super(
            st$unionWith,
            valueToContent({
              'coll': coll,
              if (pipeline != null) 'pipeline': valueToContent(pipeline),
            }));
}
