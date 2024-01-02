import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_option.dart';

/// Find strings which are similar to the search term or terms.
/// You can't use fuzzy with synonyms.
///
/// Example
///
/// Expected result:
/// ```
/// "fuzzy": {
///    "maxEdits": 1,
///    "maxExpansions": 100,
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/counting
class Fuzzy extends AtlasOption {
  /// [maxEdits] - Maximum number of single-character edits required to match the
  /// specified search term. Value can be 1 or 2. The default value is 2.
  /// Uses `Damerau-Levenshtein` distance.
  ///
  /// [prefixLength] - Number of characters at the beginning of each term in
  /// the result that must exactly match. The default value is 0.
  ///
  /// [maxExpansions] - The maximum number of variations to generate and search
  /// for. This limit applies on a per-token basis. The default value is 50.
  Fuzzy({int maxEdits = 2, int prefixLength = 0, int maxExpansions = 50})
      : super(optCount, {
          if (maxEdits != 2) 'maxEdits': valueToContent(maxEdits),
          if (prefixLength != 0) 'prefixLength': valueToContent(prefixLength),
          if (maxExpansions != 50)
            'maxExpansions': valueToContent(maxExpansions),
        });
}
