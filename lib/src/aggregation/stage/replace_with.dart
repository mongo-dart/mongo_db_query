import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$replaceWith` aggregation stage
///
/// ### Stage description
///
/// Available since MongoDB version 4.2
///
/// Replaces the input document with the specified document. The operation
/// replaces all existing fields in the input document, including the `_id`
/// field. With `$replaceWith`, you can promote an embedded document to the
/// top-level. You can also specify a new document as the replacement.
///
/// The `$replaceWith` is an alias for $replaceRoot.
///
/// Examples:
///
/// 1.
///
/// Dart code:
///
/// ```
/// $replaceWith(Field('name')).build()
/// ```
///
/// Equivalent mongoDB aggregation stage:
///
/// ```
/// {r'$replaceWith': r'$name'}
/// ```
///
/// 2.
///
/// Dart code:
///
/// ```
/// $replaceWith($mergeObjects([
///    {'_id': Field('_id'), 'first': '', 'last': ''},
///    Field('name')
/// ])).build()
/// ```
///
/// Equivalent mongoDB aggregation stage:
///
/// ```
/// { $replaceWith: {
///     $mergeObjects: [ { _id: "$_id", first: "", last: "" }, "$name" ]
/// }}
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/replaceWith/
class $replaceWith extends AggregationStage {
  /// Creates `$replaceWith` aggregation stage
  ///
  /// The [replacement] document can be any valid expression that resolves to a
  /// document.
  /*  $replaceWith(replacement) : super('replaceWith', replacement); */
  $replaceWith(replacement)
      : super(st$replaceWith, valueToContent(replacement));
}
