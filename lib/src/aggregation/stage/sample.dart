import 'package:mongo_db_query/src/base/map_expression.dart';

import '../../base/common/operators_def.dart';
import '../base/aggregation_stage.dart';

/// `$sample` aggregation stage
///
/// ### Stage description
///
/// Randomly selects the specified number of documents from the input documents.
///
/// Example:
///
/// Dart code:
/// ```
/// $sample(3).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $sample: { size: 3 } }
/// ```
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/sample/
class $sample extends AggregationStage {
  /// Creates `$sample` aggregation stage
  ///
  /// [size] - a positive integer that specifies the number of documents to
  /// randomly select
  $sample(int size) : super(st$sample, MapExpression({'size': size}));
}
