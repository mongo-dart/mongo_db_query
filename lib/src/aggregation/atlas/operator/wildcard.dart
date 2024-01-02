import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';

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
///
/// ```
///
/// Expected result:
/// ```
///
/// ```
///

// TODO Wildcard
//class Wildcard extends AtlasOperator {
/// [field] -
///
/*   Wildcard({field})
      : super(opWildcard, {
          if (field != null) 'field': valueToContent(field),
        });
} */
