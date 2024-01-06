import '../../../base/common/operators_def.dart';
import '../../../base/list_expression.dart';
import '../../base/atlas_expression.dart';

///  Adds a series of numbers. For example, you can use arithmetic expression
/// to modify relevance ranking through a numeric field from a data
/// enrichment pipeline
///
/// Expected result:
/// ```
///  "add": [
///    {"path": "rating"},
///    {"score": "relevance"}
///  ]
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Add extends AtlasExpression {
  /// [expressions] - Takes an array of expressions,
  /// which can have negative values. Array length must be greater than
  /// or equal to 2.
  ///
  Add({required List<AtlasExpression> expressions})
      : super(
          expAdd,
          ListExpression(expressions),
        );
}
