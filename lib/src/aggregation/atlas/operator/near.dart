import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The near operator supports querying and scoring numeric, date, and GeoJSON
/// point values. This operator can be used to perform a search over:
/// -    Number fields of BSON int32, int64, and double data types.
/// -    Date fields of BSON date type in ISODate format.
/// -    Geographic location fields defined using latitude and longitude
/// coordinates.
/// You can use the near operator to find results that are near a number or a
/// date. The near operator scores the Atlas Search results by proximity to
/// the number or date.
///
/// Example
///
/// Expected result:
/// ```
/// {
/// "near":
///   {
///   "path": "runtime",
///   "origin": 279,
///   "pivot": 2
///  }
/// }
/// ```
///
/// Expected result:
/// ```
///  {
///    "near": {
///      "path": "address.location"
///      "origin": {
///        "type": "Point",
///        "coordinates": [114.15027, 22.28158]
///      },
///      "pivot": 1000,
///    }
///  }
/// ```
class Near extends AtlasOperator {
  /// [path] - indexed field or fields to search.
  ///
  /// [origin] - Number, date, or geographic point to search near. This is the
  /// origin from which the proximity of the results is measured.
  ///   - For number fields, the value must be of BSON int32, int64, or double data types.
  ///   - For date fields, the value must be an DateTime object.
  ///   - For geo fields. the value must be a GeoJSON point.
  ///
  /// [pivot] - Value to use to calculate scores of Atlas Search result
  /// documents. Score is calculated using the following formula:
  ///
  ///              pivot
  /// score = ------------------
  ///          pivot + distance
  ///
  /// where distance is the difference between origin and the indexed field
  /// value.
  /// Results have a score equal to 1/2 (or 0.5) when their indexed field value
  /// is pivot units away from origin. The value of pivot must be greater
  /// than (i.e. >) 0.
  /// If origin is a:
  ///   - Number, pivot can be specified as an integer or floating point number.
  ///   - Date, pivot must be specified in milliseconds and can be specified as
  /// a 32 or 64 bit integer.
  ///   - GeoJSON point, pivot is measured in meters and must be specified as an
  ///   integer or floating point number.
  ///
  /// [score] - Score to assign to matching search results. You can modify the
  /// default score using the following options:
  ///    - boost: multiply the result score by the given number.
  ///    - constant: replace the result score with the given number.
  ///    - function: replace the result score with the given expression.
  Near({required path, required origin, required num pivot, ScoreModify? score})
      : super(opNear, {
          'path': valueToContent(path),
          'origin': valueToContent(origin),
          'pivot': valueToContent(pivot),
          if (score != null) ...score.build(),
        });
}
