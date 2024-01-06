import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_expression.dart';
import 'path.dart';

/// A gaussian decay expression allows you to decay, or reduce by multiplying,
/// the final scores of the documents based on the distance of a numeric field
/// value from a specified origin point, where sigma is computed to assure that
/// the score takes the value decay at distance scale from origin±offset:
///
/// For example, you can use gauss to adjust the relevant score of documents
/// based on document freshness, or date influencing higher ranking
///
/// Expected result:
/// ```
/// "gauss": {
///   "path": {
///     "value": "rating",
///     "undefined": 50
///   },
///   "origin": 95,
///   "scale": 5,
///   "offset": 5,
///   "decay": 0.5
/// }
/// ```
///
///https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#expressions
class Gaussian extends AtlasExpression {
  /// [origin] - The numeric value to be used
  ///
  /// [path] - Name of the numeric field whose value you want to use to
  /// multiply the base score.
  ///
  ///[scale] - Distance from origin plus or minus (±) offset at which scores
  ///must be multiplied.
  ///
  /// [offset] - Number to use to determine the distance from origin. The decay
  /// operation is performed only for documents whose distances are greater
  /// than origin plus or minus (±) offset. If ommitted, defaults to 0.
  ///
  /// [decay] - Rate at which you want to multiply the scores. Value must be a
  /// positive number between 0 and 1 exclusive. If omitted, defaults to 0.5.
  ///
  /// For documents whose numeric field value (specified using path) is at a
  /// distance (specified using scale) away from origin plus or minus (±)
  /// offset, Atlas Search multiplies the current score using decay.
  Gaussian(
      {required double origin,
      required Path path,
      required double scale,
      double offset = 0.0,
      double decay = 0.5})
      : super(
          expGauss,
          {
            ...path.build(),
            'origin': valueToContent(origin),
            'scale': valueToContent(scale),
            if (offset != 0.0) 'offset': valueToContent(offset),
            if (decay != 0.5) 'decay': valueToContent(decay)
          },
        );
}
