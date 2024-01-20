import '../../../base/common/operators_def.dart';
import '../../../base/list_expression.dart';
import '../../base/atlas_expression.dart';

///  Multiplies a series of numbers. For example, you can use arithmetic
/// expression to modify relevance ranking through a numeric field from a
/// data enrichment pipeline
///
/// Expected result:
/// ```
///  "multiply": [
///    {
///      "path": {
///        "value": "popularity",
///        "undefined": 2.5
///      }
///    },
///    {"score": "relevance"},
///    {"constant": 0.75}
///  ]
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Multiply extends AtlasExpression {
  /// [expressions] - Takes an array of expressions, which can have negative
  /// values. Array length must be greater than or equal to 2.
  ///
  Multiply({required List<AtlasExpression> expressions})
      : super(
          expMultiply,
          ListExpression(expressions),
        );
}
