import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$unwind` aggregation stage
///
/// ### Stage description
///
/// Deconstructs an array field from the input documents to output a document
/// for each element. Each output document is the input document with the value
/// of the array field replaced by the element.
///
/// Examples:
///
/// 1.
///
/// Dart code:
/// ```
/// $unwind(Field('sizes')).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$unwind : {path: "$sizes"}}
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/unwind/
class $unwind extends AggregationStage {
  /// Creates `$unwind` aggregation stage
  ///
  /// * [field] - Field path to an array field.
  /// * [includeArrayIndex] - Optional. The name of a new field to hold the
  /// array index of the element.
  /// * [preserveNullAndEmptyArrays] - Optional. If `true`, if the path is
  /// `null`, missing, or an empty array, `$unwind` outputs the document. If
  /// `false`, `$unwind` does not output a document if the path is `null`,
  /// missing, or an empty array. The default value is `false`.
  $unwind(Field field,
      {String? includeArrayIndex, bool? preserveNullAndEmptyArrays})
      : super(
            st$unwind,
            valueToContent({
              'path': field,
              if (includeArrayIndex != null)
                'includeArrayIndex': includeArrayIndex,
              if (preserveNullAndEmptyArrays != null)
                'preserveNullAndEmptyArrays': preserveNullAndEmptyArrays
            }));
}
