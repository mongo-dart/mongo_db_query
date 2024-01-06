import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_score_options.dart';

/// The boost option multiplies a result's base score by a given number or the
/// value of a numeric field in the documents. For example, you can use boost
/// to increase the importance of certain matching documents in the result.
///
/// Example
///
/// Expected result:
/// ```
/// "boost": { "value": 3 }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#boost
class Boost extends AtlasScoreOption {
  /// [value] - Number to multiply the default base score by. Value must be a
  ///  positive number. Either value or path is required, but you can't specify
  ///  both.
  ///
  /// [path] - Name of the numeric field whose value to multiply the
  /// default base score by. Either path or value is required, but you can't
  /// specify both.
  ///
  /// [undefined] - Numeric value to substitute for path if the numeric field
  /// specified through path is not found in the documents. If omitted,
  /// defaults to 0. You can specify this only if you specify path.
  Boost({double? value, String? path, double undefined = 0})
      : super(optBoost, {
          if (value != null) 'value': valueToContent(value),
          if (path != null) 'path': valueToContent(path),
          if (undefined != 0) 'undefined': valueToContent(undefined),
        });
}
