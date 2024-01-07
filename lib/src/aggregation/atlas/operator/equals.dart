import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The equals operator checks whether a field matches a value you specify.
/// equals supports querying the following data types:
/// - boolean
/// - objectId
/// - number, including int32, int64, and double
/// - date
///
/// You can use the equals operator to query booleans, objectIds, numbers,
/// and dates in arrays. If at least one element in the array matches the
/// "value" field in the equals operator, Atlas Search adds the document to
/// the result set.
///
/// Example
///
/// Expected result:
/// ```
/// "equals": {
///     "path": "name",
///     "value": "jim hall"
///   }
/// ```
///
/// Expected result:
/// ```
/// "equals": {
///   "path": "verified_user",
///   "value": true
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/equals/
class Equals extends AtlasOperator {
  /// [path] - Indexed field to search.
  ///
  /// [value] - Value to query for. can be a boolean, objectId, number, date,
  /// or string
  ///
  /// [score] - Score to assign to matching search term results. Use one of
  /// the following options to modify the score:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  Equals({required String path, required value, ScoreModify? score})
      : super(opEquals, {
          'path': path,
          'value': value,
          if (score != null) 'field': valueToContent(score),
        });
}
