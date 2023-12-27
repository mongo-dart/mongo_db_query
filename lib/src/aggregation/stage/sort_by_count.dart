import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$sortByCount`
///
/// ### Stage description
///
/// Groups incoming documents based on the value of a specified expression,
/// then computes the count of documents in each distinct group.
///
/// Each output document contains two fields: an _id field containing the
/// distinct grouping value, and a count field containing the number of
/// documents belonging to that grouping or category.
///
/// The documents are sorted by count in descending order.
/// Example:
///
/// Dart code:
/// ```
/// $sortByCount(Field('employee')).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$sortByCount: "$employee"}
/// ```
/// or
/// ```
/// $sortByCount($mergeObjects([Field('employee'), Field('business')])).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $sortByCount : { $mergeObjects : ["$employee", "$business"] } }
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/sortByCount/
class $sortByCount extends AggregationStage {
  /// Creates `$sortByCount` aggregation stage
  ///
  /// [expression] - expression to group by. You can specify any expression
  /// except for a document literal.
  ///
  /// To specify a field path, use [Field]. For example:
  ///
  /// Dart code:
  /// ```
  /// SortByCount(Field('employee')).build()
  /// ```
  /// Equivalent mongoDB aggregation stage:
  /// ```
  /// { $sortByCount:  "$employee" }
  /// ```
  ///
  /// Although you cannot specify a document literal for the group by
  /// expression, you can, however, specify a field or an expression that
  /// evaluates to a document. For example, if employee and business fields are
  /// document fields, then the following is a valid argument to
  /// `$sortByCounts`:
  ///
  /// Dart code:
  /// ```
  /// SortByCount(MergeObjects([Field('employee'), Field('business')])).build()
  /// ```
  /// Equivalent mongoDB aggregation stage:
  /// ```
  /// { $sortByCount: { $mergeObjects: [ "$employee", "$business" ] } }
  /// ```
/*   $sortByCount(expression) : super('sortByCount', expression);*/
  $sortByCount(expression) : super(st$sortByCount, valueToContent(expression));
}
