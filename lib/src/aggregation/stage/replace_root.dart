import '../../base/common/operators_def.dart';
import '../../base/field_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$replaceRoot` aggregation stage
///
/// ### Stage description
///
/// Replaces the input document with the specified document. The operation
/// replaces all existing fields in the input document, including the `_id`
/// field. You can promote an existing embedded document to the top level,
/// or create a new document for promotion.
///
/// Examples:
///
/// 1.
///
/// Dart code:
///
/// ```
/// ReplaceRoot(Field('name')).build()
/// ```
///
/// Equivalent mongoDB aggregation stage:
///
/// ```
/// { $replaceRoot: { newRoot: "$name" } }
/// ```
///
/// 2.
///
/// Dart code:
///
/// ```
/// $replaceRoot($mergeObjects([
///    {'_id': Field('_id'), 'first': '', 'last': ''},
///    Field('name')
/// ])).build()
/// ```
///
/// Equivalent mongoDB aggregation stage:
///
/// ```
/// { $replaceRoot: {
///   newRoot: {
///     $mergeObjects: [ { _id: "$_id", first: "", last: "" }, "$name" ]
///   }
/// }}
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/replaceRoot/
class $replaceRoot extends AggregationStage {
  /// Creates `$replaceRoot` aggrregation stage
  ///
  /// The [replacement] document can be any valid expression that resolves to
  /// a document. The stage errors and fails if [replacement] is not
  /// a document.
  $replaceRoot(replacement)
      : super(st$replaceRoot,
            FieldExpression('newRoot', valueToContent(replacement)));
}
