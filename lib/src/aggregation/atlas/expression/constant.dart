import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_expression.dart';

/// A constant expression allows a constant number in the function score.
/// For example, you can use constant to modify relevance ranking through a
/// numeric value from a data enrichment pipeline.
///
/// Expected result:
/// ```
///  "constant": 3
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Constant extends AtlasExpression {
  /// [constant] - The numeric value to be used
  ///
  Constant({required double constant})
      : super(
          expConstant,
          valueToContent(constant),
        );
}
