import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../atlas_operator_collector.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

///
///
/// Example
///
/// Expected result:
/// ```
/// "text": {
///  "path": "title",
///  "query": "naw yark",
///  "fuzzy": {
///    "maxEdits": 1,
///    "prefixLength": 2,
///  }
/// }
/// ```
///
/// Expected result:
/// ```
/// "text": {
///   "path": "comments",
///   "query": "dress",
///   "synonyms": "mySynonyms"
/// }
/// ```
class Text extends AtlasOperator {
  /// [path] - The indexed field or fields to search. You can also specify a
  /// wildcard path to search.
  ///
  /// [query] - The string or strings to search for. If there are multiple
  /// terms in a string, Atlas Search also looks for a match for each term in
  /// the string separately.
  ///
  /// [fuzzy] - Enable fuzzy search. Find strings which are similar to the
  /// search term or terms. You can't use fuzzy with synonyms.
  /// - fuzzy.maxEdits - Maximum number of single-character edits required to
  /// match the specified search term. Value can be 1 or 2.
  /// - fuzzy.prefixLength - Number of characters at the beginning of each term
  /// in the result that must exactly match. The default value is 0.
  /// fuzzy.maxExpansions - The maximum number of variations to generate and
  /// search for. This limit applies on a per-token basis.
  /// The default value is 50.
  ///
  /// [score] - The score assigned to matching search term results. Use one of
  /// the following options to modify the score:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score using the given expression.
  ///
  /// [synonyms] - Required for running queries using synonyms.
  /// Name of the synonym mapping definition in the index definition.
  /// Value can't be an empty string. You can't use fuzzy with synonyms.
  /// text queries that use synonyms look for a conjunction (AND) of query
  /// tokens. text queries that don't use synonyms search for a disjunction
  /// (OR) of query tokens. To run text queries that use synonyms and search
  /// for a disjunction (OR) of query tokens also, use the compound operator.
  /// For example:
  /// ```
  /// "compound": {
  ///   "should": [
  ///     {
  ///       "text": {
  ///         "path": "a",
  ///         "query": "my query",
  ///         "synonyms": "mySynonyms"
  ///       }
  ///     },
  ///     {
  ///       "text": {
  ///         "path": "a",
  ///         "query": "my query"
  ///       }
  ///     }
  ///   ]
  /// }
  ///
  /// https://www.mongodb.com/docs/atlas/atlas-search/text
  Text(
      {required path,
      required query,
      Fuzzy? fuzzy,
      ScoreModify? score,
      String? synonyms})
      : super(opText, {
          'path': valueToContent(path),
          'query': valueToContent(query),
          if (fuzzy != null) ...fuzzy.build(),
          if (score != null) ...score.build(),
          if (synonyms != null) 'synonyms': valueToContent(synonyms),
        });
}
