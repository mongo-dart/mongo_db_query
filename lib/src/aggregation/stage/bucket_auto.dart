import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/expression_content.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';
import '../base/aggregation_stage.dart';
import 'granularity.dart';

/// `$bucketAuto` aggregation stage
///
/// ### Stage description
///
/// Categorizes incoming documents into a specific number of groups, called
/// buckets, based on a specified expression. Bucket boundaries are
/// automatically determined in an attempt to evenly distribute the documents
/// into the specified number of buckets.
///
/// Each bucket is represented as a document in the output. The document for
/// each bucket contains an _id field, whose value specifies the inclusive
/// lower bound and the exclusive upper bound for the bucket, and a count
/// field that contains the number of documents in the bucket. The count
/// field is included by default when the output is not specified.
///
/// Example:
///
/// Dart code:
/// ```
///    $bucketAuto(
///      groupBy: Field('_id'),
///      buckets: 5,
///      granularity: Granularity.r5,
///      output: {'count': $sum(1)}).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///    r'$bucketAuto': {
///      groupBy: '$_id',
///      buckets: 5,
///      granularity: 'R5',
///      output: {
///        count: {'$sum': 1}
///      }
///    }
///  }
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/bucketAuto/
class $bucketAuto extends AggregationStage {
  /// Creates `$bucketAuto` aggregation stage
  ///
  /// * [groupBy] - An expression to group documents by. To specify a field path
  /// use [Field] object.
  /// * [buckets] - A positive integer that specifies the number of buckets
  /// into which input documents are grouped.
  /// * [output] - Optional. A document that specifies the fields to include in
  /// the output documents in addition to the `_id` field. To specify the field
  /// to include, you must use accumulator expressions
  /// * [granularity] - Optional. A [Granularity] that specifies the preferred
  /// number series to use to ensure that the calculated boundary edges end on
  /// preferred round numbers or their powers of 10.
  $bucketAuto(
      {required ExpressionContent groupBy,
      required int buckets,
      Map<String, Accumulator>? output,
      Granularity? granularity})
      : super(
            st$bucketAuto,
            valueToContent({
              'groupBy': groupBy,
              'buckets': buckets,
              if (output != null) 'output': valueToContent(output),
              if (granularity != null) 'granularity': granularity
            }));
  $bucketAuto.raw(MongoDocument raw) : super.raw(st$bucketAuto, raw);
}
