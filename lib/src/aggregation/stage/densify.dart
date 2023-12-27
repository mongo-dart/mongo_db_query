import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/list_expression.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$densify` aggregation stage
///
/// ### Stage description
///
///     New in version 5.1.
///
/// Creates new documents in a sequence of documents where certain values in a
/// field are missing.
/// You can use $densify to:
/// - Fill gaps in time series data.
/// - Add missing values between groups of data.
/// - Populate your data with a specified range of values.
/// https://docs.mongodb.com/manual/reference/operator/aggregation/densify/
class $densify extends AggregationStage {
  /// Creates `$densify` aggregation stage
  ///
  /// [field] - The field to densify. The values of the specified field
  /// must either be all numeric values or all dates.
  /// Documents that do not contain the specified field continue through the
  /// pipeline unmodified.
  /// To specify a <field> in an embedded document or in an array,
  /// use dot notation.
  /// [partitionByFields] - The set of fields to act as the compound key to
  /// group the documents. In the $densify stage, each group of documents
  /// is known as a partition.
  ///
  /// If you omit this field, $densify uses one partition for the entire
  /// collection.
  /// [bounds] - You can specify range.bounds as either:
  ///  An array: [ < lower bound >, < upper bound > ],
  ///  A string: either "full" or "partition".
  ///  If bounds is an array:
  ///  - $densify adds documents spanning the range of values within the
  /// specified bounds.
  ///    The data type for the bounds must correspond to the data type in the
  /// field being densified.
  ///
  /// If bounds is "full":
  /// - $densify adds documents spanning the full range of values of the field
  /// being densified.
  ///
  /// If bounds is "partition":
  /// - $densify adds documents to each partition, similar to if you had run a
  /// full range densification on each partition individually.
  /// [step] - The amount to increment the field value in each document.
  /// $densify creates a new document for each step between the existing
  /// documents.
  ///
  /// If range.unit is specified, step must be an integer. Otherwise, step can
  /// be any numeric value.
  /// [unit] - Required if field is a date. The unit to apply to the step
  /// field when incrementing date values in field.
  /// You can specify one of the following values for unit as a string:
  /// - millisecond
  /// - second
  /// - minute
  /// - hour
  /// - day
  /// - week
  /// - month
  /// - quarter
  /// - year
  $densify(String field,
      {List<String>? partitionByFields,
      required bounds,
      required num? step,
      String? unit})
      : super(
            st$densify,
            MapExpression({
              'field': field,
              if (partitionByFields != null)
                'partitionByFields': ListExpression(partitionByFields),
              'range': MapExpression({
                'step': step,
                if (unit != null) 'unit': unit,
                'bounds': valueToContent(bounds),
              })
            }));
  $densify.raw(MongoDocument raw) : super.raw(st$densify, raw);
}
