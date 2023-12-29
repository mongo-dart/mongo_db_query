import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/expression_content.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';
import '../base/aggregation_stage.dart';

/// `$bucket` aggregation stage
///
/// ### Stage description
///
/// Categorizes incoming documents into groups, called buckets, based on a
/// specified expression and bucket boundaries.
///
/// Each bucket is represented as a document in the output. The document for
/// each bucket contains an `_id` field, whose value specifies the inclusive
/// lower bound of the bucket and a count field that contains the number of
/// documents in the bucket. The count field is included by default when the
/// output is not specified.
///
/// `$bucket` only produces output documents for buckets that contain at least
/// one input document.
///
/// Example:
///
/// Dart code:
/// ```
///  $bucket(
///          groupBy: Field('price'),
///          boundaries: [0, 200, 400],
///          defaultId: 'Other',
///          output: {'count': $sum(1), 'titles': $push(Field('title'))})
///     .build()
/// ```
/// or
/// ```
/// $bucket.raw({
///          'groupBy': Field('price'),
///          'boundaries': [0, 200, 400],
///          'default': 'Other',
///          'output': accumulatorsMap(
///              [fieldSum('count', 1), fieldPush('titles', Field('title'))])
///        }).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  $bucket: {
///    groupBy: "$price",
///    boundaries: [ 0, 200, 400 ],
///    default: "Other",
///    output: {
///      "count": { $sum: 1 },
///      "titles" : { $push: "$title" }
///    }
///  }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/bucket/
class $bucket extends AggregationStage {
  /// Creates `$bucket` aggregation stage
  ///
  /// * [groupBy] - An expression to group documents by. To specify a field
  /// path use [Field] object. Unless `$bucket` includes a default
  /// specification, each input document must resolve the groupBy field path
  /// or expression to a value that falls within one of the ranges specified
  /// by the boundaries.
  /// * [boundaries] - An array of values based on the [groupBy] expression that
  /// specify the boundaries for each bucket. Each adjacent pair of values acts
  /// as the inclusive lower boundary and the exclusive upper boundary for the
  /// bucket. You must specify at least two boundaries.
  ///
  /// Example:
  ///
  /// An array of `[ 0, 5, 10 ]` creates two buckets:
  ///
  ///   * [0, 5) with inclusive lower bound 0 and exclusive upper bound 5.
  ///   * [5, 10) with inclusive lower bound 5 and exclusive upper bound 10.
  ///
  ///
  /// * [defaultId] - Optional. A literal that specifies the `_id` of an
  /// additional bucket that contains all documents whose groupBy expression
  /// result does not fall into a bucket specified by boundaries. If
  /// unspecified, each input document must resolve the groupBy expression to
  /// a value within one of the bucket ranges specified by boundaries or the
  /// operation throws an error. The default value must be less than the lowest
  /// boundaries value, or greater than or equal to the highest boundaries
  /// value. The default value can be of a different type than the entries in
  /// boundaries.
  /// * [output] - Optional. A document that specifies the fields to include in
  /// the output documents in addition to the _id field. To specify the field
  /// to include, you must use accumulator expressions.
  $bucket(
      {required ExpressionContent groupBy,
      required List boundaries,
      defaultId,
      Map<String, Accumulator>? output})
      : super(
            st$bucket,
            valueToContent({
              'groupBy': groupBy,
              'boundaries': valueToContent(boundaries),
              if (defaultId != null) 'default': defaultId,
              if (output != null) 'output': valueToContent(output)
            }));
  $bucket.raw(MongoDocument raw) : super.raw(st$bucket, raw);
}
