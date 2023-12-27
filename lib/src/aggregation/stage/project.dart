import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$project` aggregation stage
///
/// ### Stage description
///
/// Passes along the documents with the requested fields to the next stage in
/// the pipeline. The specified fields can be existing fields from the input
/// documents or newly computed fields.
class $project extends AggregationStage {
  /// Creates `$project` aggreagtion stage
  ///
  /// [specification] have the following forms:
  ///
  /// * `<fieldname>`: `1` or `true` - Specifies the inclusion of a field.
  /// * `<fieldname>`: `0` or `false` - Specifies the exclusion of a field. To
  /// exclude a field conditionally, use the [Var].remove (`REMOVE`) variable
  /// instead. If you specify the exclusion of a field other than `_id`, you
  /// cannot employ any other `$project` specification forms. This restriction
  /// does not apply to conditionally exclusion of a field using the
  /// [Var].remove (`REMOVE`) variable. By default, the `_id` field is included
  /// in the output documents. If you do not need the `_id` field, you have
  /// to exclude it explicitly.
  /// * `<fieldname>`: `<expression>` - Adds a new field or resets the value of
  /// an existing field. If the the expression evaluates to [Var].remove
  /// (`$$REMOVE`), the field is excluded in the output.
  ///
  /// Example:
  ///
  /// Dart code:
  /// ```
  /// $project.raw({'_id': 0, 'title': 1, 'author': 1}).build()
  /// ```
  /// Equivalent mongoDB aggregation stage:
  /// ```
  /// { $project : { _id: 0, title : 1 , author : 1 } }
  /// ```
  /// or
  /// ```
  /// $project(included: ['title', 'author'], excluded: ['_id']).build()
  /// ```
  /// Equivalent mongoDB aggregation stage:
  /// ```
  /// { $project : { _id: 0, title : 1 , author : 1 } }
  /// ```
  /// https://docs.mongodb.com/manual/reference/operator/aggregation/project/
  ///
  $project({List<String>? included, List<String>? excluded})
      : super(
            st$project,
            MapExpression({
              for (var element in excluded ?? []) element: 0,
              for (var element in included ?? []) element: 1
            }));
  $project.raw(Map<String, dynamic> specification)
      : super(st$project, valueToContent(specification));
}
