import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_score_options.dart';

/// The constant option replaces the base score with a specified number.
///
/// Expected result:
/// ```
///  "constant": { "value": 5 }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#constant
class ConstantOption extends AtlasScoreOption {
  /// [value] - replace the score  with the specified constant value
  ///

  ConstantOption({required double value})
      : super(optConstant, {
          'value': valueToContent(value),
        });
}
