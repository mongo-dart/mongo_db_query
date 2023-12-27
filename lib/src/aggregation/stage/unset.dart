import '../../base/common/operators_def.dart';
import '../../base/list_expression.dart';
import '../base/aggregation_base.dart';

/// `$unset` aggregation stage
///
/// ### Stage description
///
/// Available since MongoDB version 4.2
///
/// Removes/excludes fields from documents.
///
/// Example:
///
/// Dart code:
/// ```
/// $unset(['isbn', 'author.first', 'copies.warehouse']).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $unset: [ "isbn", "author.first", "copies.warehouse" ] }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/unset/
class $unset extends AggregationStage {
  /// Creates `$unset` aggreagation stage
  $unset(List<String> fieldNames) : super(st$unset, ListExpression(fieldNames));
}
