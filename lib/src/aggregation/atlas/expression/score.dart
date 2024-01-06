import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_expression.dart';

/// A score expression represents the relevance score, which is the score
/// Atlas Search assigns documents based on relevance, of the query.
/// It is the same as the current score of the document.
///
/// Expected result:
/// ```
///  "score": "relevance"
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Score extends AtlasExpression {
  /// [score] - Value of relevance score of the query.
  /// Value must be `relevance`.
  Score({String score = 'relevance'})
      : super(
          expScore,
          valueToContent(score),
        );
}
