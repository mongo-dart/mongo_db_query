import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The queryString operator supports querying a combination of indexed fields
/// and values. You can perform text, wildcard, regular expression, fuzzy,
/// and range searches on string fields using the `queryString` operator.
///
/// Example
///
/// Expected result:
/// ```
/// "queryString": {
///     "defaultPath": "title",
///     "query": "Rocky AND (IV OR 4 OR Four)"
///  }
/// ```
///
/// Expected result:
/// ```
/// "queryString": {
///      "defaultPath": "plot",
///      "query": "title:\"The Italian\" AND genres:Drama"
///   }
/// ```
///
/// Expected result:
/// ```
/// "queryString": {
///    "defaultPath": "fullplot",
///    "query": "plot:(captain OR kirk) AND chess"
///  }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/queryString/
class QueryString extends AtlasOperator {
  /// [defaultPath] - The indexed field to search by default. Atlas Search
  /// only searches the field in defaultPath if you omit the field to search
  /// in the query.
  ///
  /// [query] - One or more indexed fields and values to search. Fields and
  /// values are colon-delimited. For example, to search the plot field for the
  /// string baseball, use plot:baseball. The following operators are available
  ///  to combine multiple search criteria:
  ///
  /// You can combine the fields and values using the following:
  /// - AND Indicates AND boolean operator. All search values must be present
  /// for a document to be included in the results.
  /// - OR Indicates OR boolean operator. At least one of the search value must
  /// be present for a document to be included in the results.
  /// - NOT Indicates NOT boolean operator. Specified search value must be
  /// absent for a document to be included in the results.
  /// - TO Indicates the range to search. You can use [] for an inclusive
  /// range, {} for an exclusive range, or {] and [} for an half-open range.
  /// Any value that falls within the specified range must be present for a
  /// document to be included in the results.
  /// - () Delimiters for subqueries. Use the parentheses to group fields and
  /// values to search.
  ///
  /// You can run wildcard and regular expression queries using the following:
  /// - ? Indicates any single character to match.
  /// - * Indicates 0 or more characters to match.
  /// - / Delimiter for regular expression.
  /// - ~ Indicates fuzzy search to find strings which are similar to the
  /// search term. If you use this with multiple terms in a string,
  /// the queryString operator does a proximity search for the terms within
  /// the specified number of terms.
  ///
  /// [score] - The score assigned to matching search results.
  /// You can modify the default score using the following options:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  QueryString(
      {required String defaultPath, required String query, ScoreModify? score})
      : super(opQueryString, {
          'defaultPath': valueToContent(defaultPath),
          'query': valueToContent(query),
          if (score != null) ...score.build(),
        });
}
