import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/field_expression.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_base.dart';

/// `$set` aggregation stage
///
/// ### Stage description
///
/// Available since MongoDB version 4.2
///
/// Adds new fields to documents. $set outputs documents that contain all
/// existing fields from the input documents and newly added fields.
///
/// The $set stage is an alias for $addFields.
///
/// Both stages are equivalent to a $project stage that explicitly specifies
/// all existing fields in the input documents and adds the new fields.
///
/// You can include one or more $set stages in an aggregation operation.
///
/// To add field or fields to embedded documents (including documents in
/// arrays) use the dot notation.
///
/// To add an element to an existing array field with `$set`, use with
/// $concatArrays ([ConcatArrays]).
///
/// Dart code:
/// ```dart
/// $set([
///   fieldSum('totalHomework', Field('homework')),
///   fieldSum('totalQuiz', r'$quiz')
/// ]).build()
/// ```
/// or
/// ```dart
/// $set.raw({
///   ...FieldExpression('totalHomework', $sum(Field('homework'))).build(),
///   'totalQuiz': $sum(r'$quiz')
/// }).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///   $set: {
///     totalHomework: { $sum: "$homework" },
///     totalQuiz: { $sum: "$quiz" }
///   }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/set/
class $set extends AggregationStage {
  /// Creates `$set` aggregation stage
  //$set(Map<String, dynamic> fields) : super('set', AEObject(fields));
  $set(List<FieldExpression> expressions)
      : super(
            st$set,
            MapExpression(
                {for (var expression in expressions) ...expression.build()}));
  $set.raw(MongoDocument raw) : super.raw(st$set, raw);
}
