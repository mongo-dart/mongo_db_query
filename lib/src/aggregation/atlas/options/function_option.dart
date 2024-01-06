import '../../../base/common/operators_def.dart';
import '../../base/atlas_expression.dart';
import '../../base/atlas_score_options.dart';

/// The function option allows you to alter the final score of the document
/// using a numeric field . You can specify the numeric field for computing
/// the final score through an expression. If the final result of the
/// function score is less than 0, Atlas Search replaces the score with 0.
///
/// Expected result:
/// ```
/// "function": {
///  "add": [
///    {"path": "rating"},
///    {"score": "relevance"}
///  ]
/// }
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#function
class FunctionOption extends AtlasScoreOption {
  /// [expression] - expression for computing the score.
  ///

  FunctionOption({required AtlasExpression expression})
      : super(optFunction, {...expression.build()});
}
