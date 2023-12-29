import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/list_expression.dart';
import '../base/aggregation_stage.dart';

/// `$documents ` aggregation stage
///
/// ### Stage description.
///
/// Returns literal documents from input values.
///
/// Example:
///
/// Dart code
/// ```dart
/// $documents([ { x: 10 }, { x: 2 }, { x: 5 } ]).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  { $documents: [ { x: 10 }, { x: 2 }, { x: 5 } ] }
/// }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/currentOp/
class $documents extends AggregationStage {
  $documents(List<MongoDocument> objects)
      : super(st$documents, ListExpression(objects));
}
