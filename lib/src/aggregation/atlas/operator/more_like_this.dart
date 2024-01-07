import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The moreLikeThis operator returns documents similar to input documents.
/// The moreLikeThis operator allows you to build features for your
/// applications that display similar or alternative results based on one or
/// more given documents.
///
/// Example
///
/// Expected result:
/// ```
/// moreLikeThis: {
///  like:
///   {
///     "title": "The Godfather",
///     "genres": "action"
///   }
/// }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/morelikethis/
class MoreLikeThis extends AtlasOperator {
  /// [like] - (one BSON document or an array of documents)
  /// One or more BSON documents that Atlas Search uses to extract
  /// representative terms to query for.
  ///
  /// [score] - Score to assign to matching search results. You can modify
  /// the default score using the following options:
  /// - boost: multiply the result score by the given number.
  /// - constant: replace the result score with the given number.
  /// - function: replace the result score with the given expression.
  MoreLikeThis({required like, ScoreModify? score})
      : super(opMoreLikeThis, {
          'like': valueToContent(like),
          if (score != null) ...score.build(),
        });
}
