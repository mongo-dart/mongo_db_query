import '../../../base/common/document_types.dart';
import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';

/// The range operator supports querying and scoring numeric and date values.
/// This operator can be used to perform a search over:
/// - Number fields of BSON int32, int64, and double data types.
/// - Date fields of BSON date data type in `ISODate` format.
///
/// You can use the range operator to find results that are within a given
/// numeric or date range.
///
/// Example
///
/// Expected result:
/// ```
/// "range": {
///    "path": "runtime",
///    "gte": 2,
///    "lte": 3
/// }
/// ```
///
/// Expected result:
/// ```
///
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/range/

class Range extends AtlasOperator {
  /// [path] - Indexed field or fields to search. See Path Construction.
  ///
  /// [gt] - Find values greater than (>) the given value.
  /// Alternative to gte
  /// - For number fields, the value can be an int32, int64, or double data
  /// type.
  /// - For date fields, the value must be an DateTime object.
  ///
  /// [gte] - Find values greater than or equal to (>=) the given value.
  /// Alternative to gt
  /// - For number fields, the value can be an int32, int64, or double data
  /// type.
  /// - For date fields, the value must be an DateTime object.
  ///
  /// [lt] - Find values less than (<) the given value.
  /// Alternative to lte
  /// - For number fields, the value can be an int32, int64, or double data
  /// type.
  /// - For date fields, the value must be an DateTime object.
  ///
  /// [lte] - Find values less than or equal to (<=) the given value.
  /// Alternative to lt
  /// - For number fields, the value can be an int32, int64, or double data
  /// type.
  /// - For date fields, the value must be an DateTime object.
  ///
  Range({required path, gt, gte, lt, lte, MongoDocument? score})
      : super(opRange, {
          'path': valueToContent(path),
          if (gt != null) 'gt': valueToContent(gt),
          if (gte != null) 'gte': valueToContent(gte),
          if (lt != null) 'lt': valueToContent(lt),
          if (lte != null) 'lte': valueToContent(lte),
          if (score != null) 'score': valueToContent(score),
        });
}
