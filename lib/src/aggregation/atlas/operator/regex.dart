import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// regex interprets the query field as a regular expression. regex is a
/// term-level operator, meaning that the query field isn't analyzed.
///
/// Example
///
/// Expected result:
/// ```
/// "regex": {
///     "path": "title",
///     "query": "(.*) Seattle"
///  }
/// ```
///
/// Expected result:
/// ```
/// "regex": {
///      "path": "title",
///      "query": "[0-9]{2} (.){4}s"
///   }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/regex/
class Regex extends AtlasOperator {
  /// [query] - (string or array of strings) String or strings to search for.
  ///
  /// [path] - (string or array of strings) Indexed field or fields to search.
  /// You can also specify a wildcard path to search.
  ///
  /// [allowAnalyzedField] - Must be set to true if the query is run against
  /// an analyzed field.
  ///
  /// [score] - Score to assign to matching search term results. Options are:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  Regex(
      {required query,
      required path,
      bool allowAnalyzedField = false,
      ScoreModify? score})
      : super(opRegex, {
          'query': valueToContent(query),
          'path': valueToContent(path),
          if (allowAnalyzedField) 'allowAnalyzedField': allowAnalyzedField,
          if (score != null) ...score.build(),
        });
}
