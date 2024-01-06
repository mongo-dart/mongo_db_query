import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_expression.dart';

/// A path expression incorporates an indexed numeric field value into a
/// function score. It can either be a string or an object.
///
/// Expected result:
/// ```
///  "path": {"value": "quantity", "undefined": 2}
/// ```
/// or
/// ```
/// "path": "quantity"
/// ```
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Path extends AtlasExpression {
  /// [value] - Name of numeric field. Field can contain negative
  /// numeric values.
  ///
  /// [undefined] - Value to use if the numeric field specified using value is
  /// missing in the document. If omitted, defaults to 0.
  Path({required String value, double undefined = 0})
      : super(
            expPath,
            undefined == 0
                ? valueToContent(value)
                : {
                    'value': valueToContent(value),
                    'undefined': valueToContent(undefined)
                  });
}
