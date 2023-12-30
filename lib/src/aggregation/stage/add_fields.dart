import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/field_expression.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_stage.dart';

/// `$addFields` aggregation stage
///
/// ### Stage description.
///
/// Adds new fields to documents. $addFields outputs documents that contain
/// all existing fields from the input documents and newly added fields.
/// The $addFields stage is equivalent to a $project stage that explicitly
/// specifies all existing fields in the input documents and adds the
/// new fields. You can include one or more `$addFields` stages in an
/// aggregation pipeline.
///
/// To add field or fields to embedded documents (including documents in arrays)
/// use the dot notation.
///
/// To add an element to an existing array field with `$addFields`, use with
/// `$concatArrays`([ConcatArrays]).
///
/// Example:
///
/// Dart code
/// ```dart
/// $addFields([
///   fieldSum('totalHomework', Field('homework')),
///   fieldSum('totalQuiz', r'$quiz')
/// ]).build()
/// ```
/// or
/// ```dart
/// $addFields.raw({
///   'totalHomework': $sum(Field('homework')),
///   'totalQuiz': $sum(r'$quiz')
/// }).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  $addFields: {
///     totalHomework: { $sum: "$homework" } ,
///     totalQuiz: { $sum: "$quiz" }
///   }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/addFields/
class $addFields extends AggregationStage {
  /// Creates `$addFields` aggregation stage
  $addFields(List<FieldExpression> expressions)
      : super(
            st$addFields,
            MapExpression(
                {for (var expression in expressions) ...expression.build()}));
  $addFields.raw(MongoDocument raw) : super.raw(st$addFields, raw);
}
