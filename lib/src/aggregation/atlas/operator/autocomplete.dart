import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../atlas_operator_collector.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The `autocomplete` operator performs a search for a word or phrase that
/// contains a sequence of characters from an incomplete input string.
/// You can use the autocomplete operator with search-as-you-type applications
/// to predict words with increasing accuracy as characters are entered in your
/// application's search field. autocomplete returns results that contain
/// predicted words based on the tokenization strategy specified in the index
/// definition for autocompletion. The fields that you intend to query with the
/// autocomplete operator must be indexed with the How to Index Fields for
/// Autocompletion data type in the collection's index definition.
///
/// Example
///
/// Expected result:
/// ```
///
/// ```
///
/// Expected result:
/// ```
///
/// ```
///

class Autocomplete extends AtlasOperator {
  /// [query] - (string or array of strings) String or strings to search for.
  /// If there are multiple terms in a string, Atlas Search also looks for a
  /// match for each term in the string separately.
  ///
  /// [path] - Indexed autocomplete type of field to search.
  ///
  /// [fuzzy] - Enable fuzzy search. Find strings which are similar to the
  ///     search term or terms.
  ///
  /// [score] - Score to assign to the matching search term results.
  /// Use one of the following options to modify the default score:
  /// - boost --> Multiply the result score by the given number.
  /// - constant --> Replace the result score with the given number.
  /// - function --> Replace the result score with the given expression.
  ///
  /// [tokenOrder] - Order in which to search for tokens.
  /// Value can be one of the following:
  /// - any --> Indicates tokens in the query can appear in any order in the
  /// documents. Results contain documents where the tokens appear sequentially
  /// and non-sequentially. However, results where the tokens appear
  /// sequentially score higher than other, non-sequential values.
  /// - sequential --> Indicates tokens in the query must appear adjacent to
  /// each other or in the order specified in the query in the documents.
  /// Results contain only documents where the tokens appear sequentially.
  Autocomplete(query, String path,
      {Fuzzy? fuzzy, ScoreModify? score, String? tokenOrder})
      : super(opAutocomplete, {
          'query': valueToContent(query),
          'path': valueToContent(path),
          if (fuzzy != null) ...fuzzy.build(),
          if (score != null) ...score.build(),
          if (tokenOrder != null) 'tokenOrder': valueToContent(tokenOrder),
        });
}
