import '../../../base/common/operators_def.dart';
import '../../base/atlas_expression.dart';

/// In Atlas Search, you can use log1p expressions to calculate the  log10(x+1)
/// of a specified number.
/// For example, you can use log1p to influence the relevance score by document
/// popularity score
///
/// Expected result:
/// ```
/// "log1p": {
///   "path": {
///     "value": "rating",
///     "undefined": 4
///   }
/// }
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Log1p extends AtlasExpression {
  /// [expression] - Adds 1 to the number and then calculates its log10.
  Log1p({required AtlasExpression expression})
      : super(
          expLog1p,
          {...expression.build()},
        );
}
