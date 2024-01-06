import '../../../base/common/operators_def.dart';
import '../../base/atlas_expression.dart';

/// In Atlas Search, you can use log expressions to calculate the log10(x)
/// of a specified number.
/// For example, you can use log to influence the relevance score by document
/// popularity score
///
/// Expected result:
/// ```
///  "log": {
///   "multiply": [
///     {"path": "popularity"},
///     {"constant": 0.5},
///     {"score": "relevance"}
///   ]
/// }
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Log extends AtlasExpression {
  /// [expression] - Calculates the log10 of a number.
  ///
  Log({required AtlasExpression expression})
      : super(
          expLog,
          {...expression.build()},
        );
}
