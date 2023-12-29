import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$limit` aggregation stage
///
/// ### Stage description
///
/// lRestricts entire documents or content within documents from being
/// outputted based on information stored in the documents themselves.
///
/// Example:
///
/// Dart code:
/// ```
/// $limit(5).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {$limit: 5}
/// ```
/// or
/// ```
/// $limit.query(where..limit(5)).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $redact: {
///        $cond: {
///           if: { $gt: [ { $size: { $setIntersection: [ "$tags", [ "STLW", "G" ] ] } }, 0 ] },
///           then: "$$DESCEND",
///           else: "$$PRUNE"
///         }
///       }
///     }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/limit/
class $redact extends AggregationStage {
  /// Creates `$redact` aggregation stage
  ///
  /// [expr] -  can be any valid expression as long as it resolves to the
  /// $$DESCEND, $$PRUNE, or $$KEEP system variables.
  $redact(OperatorExpression expr) : super(st$redact, valueToContent(expr));

  $redact.raw(MongoDocument raw) : super.raw(st$redact, raw);
}
