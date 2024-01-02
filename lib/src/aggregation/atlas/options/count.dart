import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_option.dart';

/// The Atlas Search count option adds a field to the metadata results document
/// that displays a count of the search results for the query. You can use
/// count to determine the size of the result set. You can use it in the
/// $search or $searchMeta stage. You must use it in conjuction with the
/// operators or collectors to display either the total number of documents
/// or a lower bound on the number of documents that match the query.
///
/// Example
///
/// Expected result:
/// ```
/// "count": {
///   "type": "total"
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/counting
class Count extends AtlasOption {
  /// [type] - Type of count of the documents in the result set.
  /// Value can be one of the following:
  /// - `lowerBound` - for a lower bound count of the number of documents that
  /// match the query. You can set the threshold for the lower bound number.
  /// - `total` - for an exact count of the number of documents that match the
  /// query. If the result set is large, Atlas Search might take longer
  /// than for lowerBound to return the count.
  ///
  /// If omitted, defaults to `lowerBound`.
  ///
  /// [threshold] - Number of documents to include in the exact count if type
  /// is lowerBound. If omitted, defaults to 1000, which indicates that any
  /// number up to 1000 is an exact count and any number above 1000 is a rough
  /// count of the number of documents in the result.
  Count({String type = 'lowerBound', int? threshold})
      : super(optCount, {
          'type': valueToContent(type),
          if (threshold != null) 'threshold': valueToContent(threshold),
        });
}
