import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_option.dart';

/// The Atlas Search tracking option allows you to track your search queries.
/// When you track your queries, Atlas tracks the search terms and provides
/// analytics information about the search terms in your queries.
/// You can use the analytics information to improve the quality of your
/// search application and to refine your query to return relevant results.
///
/// Example
///
/// Expected result:
/// ```
/// "tracking": {
///  "searchTerms": "summer"
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/tracking
class Tracking extends AtlasOption {
  /// [searchTerms] - Text or term associated with the query to track. You can
  /// specify only one term per query.
  ///
  Tracking(String searchTerms)
      : super(optTracking, {
          'searchTerms': valueToContent(searchTerms),
        });
}
