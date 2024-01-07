import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The phrase operator performs search for documents containing an ordered
/// sequence of terms using the analyzer specified in the index configuration.
/// If no analyzer is specified, the default standard analyzer is used.
///
/// Example
///
/// Expected result:
/// ```
/// "phrase": {
///    "path": "title",
///    "query": "new york"
///  }
/// ```
///
/// Expected result:
/// ```
/// "phrase": {
///   "path": "title",
///   "query": "men women",
///   "slop": 5
///  }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/phrase/
class Phrase extends AtlasOperator {
  /// [query] - (string or array of strings) String or strings to search for.
  ///
  /// [path] - (string or array of strings) Indexed field or fields to search.
  /// You can also specify a wildcard path to search.
  ///
  /// [score] - Score to assign to matching search results. You can modify
  /// the default score using the following options:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  ///
  /// [slop] - Allowable distance between words in the query phrase.
  /// Lower value allows less positional distance between the words and greater
  /// value allows more reorganization of the words and more distance between
  /// the words to satisfy the query. The default is 0, meaning that words
  /// must be exactly in the same position as the query in order to be
  /// considered a match. Exact matches are scored higher.
  Phrase({required query, required path, ScoreModify? score, int slop = 0})
      : super(opPhrase, {
          'query': valueToContent(query),
          'path': valueToContent(path),
          if (score != null) ...score.build(),
          if (slop != 0) 'slop': valueToContent(slop),
        });
}
