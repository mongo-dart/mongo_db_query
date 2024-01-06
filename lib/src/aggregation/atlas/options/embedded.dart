import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_score_options.dart';

/// The embedded option allows you to configure how to:
/// - Aggregate the scores of multiple matching embedded documents.
/// - Modify the score of an embeddedDocument operator after aggregating
/// the scores from matching embedded documents.
///
/// You can use this option with the `embeddedDocument` operator only.
///
/// Example
///
/// Expected result:
/// ```
/// "outerScore": {
///      "function": {
///        "multiply": [
///          {
///            "log1p": {
///              "path": {
///                "value": "transaction_count"
///              }
///            }
///          },
///          {
///            "score": "relevance"
///          }
///        ]
///      }
///    }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/#embedded
class Embedded extends AtlasScoreOption {
  /// [aggregate] - Configures how to combine scores of matching embedded
  /// documents. Value must be one of the following aggregation strategies:
  /// - sum - (Default) Sum the score of all matching embedded documents.
  /// - maximum - Choose the greatest score of all matching embedded documents.
  /// - minimum - Choose the least high score of all matching embedded
  /// documents.
  /// - mean - Choose the average (arithmetic mean) score of all matching
  /// embedded documents. Atlas Search includes scores of matching embedded
  /// documents only when computing the average. Atlas Search doesn't count
  /// embedded documents that don't satisfy query predicates as documents with
  /// scores of zero.
  ///
  /// If omitted, this field defaults to sum.
  ///
  /// [outerScore] - Specifies the score modification to apply after applying
  /// the aggregation strategy.
  Embedded({String aggregate = 'sum', AtlasScoreOption? outerScore})
      : super(optEmbedded, {
          if (aggregate != 'sum') 'aggregate': valueToContent(aggregate),
          if (outerScore != null) 'outerScore': valueToContent(outerScore),
        });
}
