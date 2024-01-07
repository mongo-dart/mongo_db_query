import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The in operator performs a search for an array of number, date, boolean,
/// or objectId values at the given path and returns documents where the value
/// of the field equals any value in the specified array. If the specified
/// field holds an array, then the in operator selects the documents whose
/// field holds an array that contains at least one element that matches any
/// value in the specified array.
///
/// Example
///
/// Expected result:
/// ```
/// "in": {
///   "path": "birthdate",
///   "value": [DateTime.parse("1977-03-02T02:20:31.000+00:00"),
///            DateTime.parse("1977-03-01T00:00:00.000+00:00"),
///            DateTime.parse("1977-05-06T21:57:35.000+00:00")]
/// }
/// ```
///
/// Expected result:
/// ```
/// "in": {
///  "path": "accounts",
///  "value": [371138, 371139, 371140]
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/in/

class In extends AtlasOperator {
  /// [path] - Indexed field to search. You can also specify a
  /// wildcard path to search.
  ///
  /// [value] -(boolean, objectId, number, date, or string) -
  /// Value or values to search.
  /// Value can be either a single value or an array of values of only one of
  /// the supported BSON types and can't be a mix of different types.
  ///
  /// [score] - Score to assign to matching search term results.
  /// Use one of the following options to modify the score:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score using the function expression.
  ///
  In({required String path, required value, ScoreModify? score})
      : super(opIn, {
          'path': valueToContent(path),
          'value': valueToContent(value),
          if (score != null) ...score.build(),
        });
}
