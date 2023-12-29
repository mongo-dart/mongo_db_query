import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/field_expression.dart';
import '../../base/list_expression.dart';
import '../../base/map_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$fill` aggregation stage
///
/// ### Stage description
///
///    New in version 5.3.
///
/// Populates null and missing field values within documents.
/// You can use $fill to populate missing data points:
/// - In a sequence based on surrounding values.
/// - With a fixed value.
///
/// Example:
///
/// Dart code
/// ```dart
/// $fill(sortBy: {
///    'date': 1
///  }, partitionBy: {
///    'restaurant': r'$restaurant'
/// }, output: [
///    FieldExpression('score', MapExpression({'method': 'locf'}))
///  ]).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  $fill: {
///      partitionBy: {restaurant: r'$restaurant'},
///      sortBy: {date: 1},
///      output: {
///        score: {method: 'locf'}
///      }
///   }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/fill/
class $fill extends AggregationStage {
  /// Creates `$fill` aggregation stage
  ///
  /// [partitionBy] - Specifies an expression to group the documents.
  /// In the $fill stage, a group of documents is known as a partition.
  ///
  /// If you omit partitionBy and partitionByFields, $fill uses one partition
  /// for the entire collection.
  ///
  /// partitionBy and partitionByFields are mutually exclusive.
  /// [partitionByFields] - Specifies an array of fields as the compound key
  /// to group the documents. In the $fill stage, each group of documents is
  /// known as a partition.
  ///
  /// If you omit partitionBy and partitionByFields, $fill uses one partition
  /// for the entire collection.
  ///
  /// partitionBy and partitionByFields are mutually exclusive.
  /// [sortBy] - Required if method is specified in at least one output.<field>.
  /// Specifies the field or fields to sort the documents within each partition.
  /// Uses the same syntax as the $sort stage.
  /// [output] - Specifies an object containing each field for which to fill
  /// missing values. You can specify multiple fields in the output object.
  ///
  /// The object name is the name of the field to fill. The object value
  /// specifies how the field is filled.
  /// [output.<field>] - Specifies an object indicating how to fill missing
  /// values in the target field.
  ///
  /// The object name must be either value or method. If the name is:
  /// - value, the value must be an expression indicating the value used to
  /// fill the target field.
  /// - method, the value must be either linear or locf. If you specify:
  ///   - linear fill method, values are filled using linear interpolation
  ///   based on the surrounding non-null values in the sequence.
  ///   - locf fill method, values are filled based on the last non-null value
  ///   for the field in the partition. locf stands for last observation carried
  ///   forward.
  $fill(
      {partitionBy,
      List<String>? partitionByFields,
      IndexDocument? sortBy,
      required List<FieldExpression> output})
      : super(
            st$fill,
            MapExpression({
              if (partitionBy != null)
                'partitionBy': valueToContent(partitionBy),
              if (partitionByFields != null)
                'partitionByFields': ListExpression(partitionByFields),
              if (sortBy != null) 'sortBy': MapExpression(sortBy),
              'output':
                  MapExpression({for (var field in output) ...field.build()}),
            }));
  $fill.raw(MongoDocument raw) : super.raw(st$fill, raw);
}
