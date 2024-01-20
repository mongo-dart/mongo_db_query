import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The wildcard operator enables queries which use special characters in the
/// search string that can match any character.
/// - ? --> Matches any single character.
/// - * --> Matches 0 or more characters.
/// - \ --> Escape character.
///
/// wildcard is a term-level operator, meaning that the query field is not
/// analyzed. Term-level operators work well with the Keyword Analyzer,
/// because the query field is treated as a single term, with special
/// characters included. For an example of querying against an analyzed query
/// field vs. a non-analyzed query field, see the analyzed field example.
///
/// Example
///
/// Expected result:
/// ```
/// "wildcard": {
///   "path": "title",
///   "query": "Green D*"
///  }
/// ```
///
/// Expected result:
/// ```
/// "wildcard": {
///    "path": "title",
///    "query": "*\\?"
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/wildcard/
class Wildcard extends AtlasOperator {
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
  Wildcard(
      {required query,
      required path,
      bool allowAnalyzedField = false,
      ScoreModify? score})
      : super(opWildcard, {
          'path': valueToContent(path),
          'query': valueToContent(query),
          if (allowAnalyzedField) 'allowAnalyzedField': allowAnalyzedField,
          if (score != null) ...score.build(),
        });
}
