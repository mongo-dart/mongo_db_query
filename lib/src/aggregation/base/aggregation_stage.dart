import 'package:meta/meta.dart';

import '../../base/common/document_types.dart';
import '../../base/field_expression.dart';
import '../../base/map_expression.dart';

/// Aggregation stage base
class AggregationStage extends FieldExpression {
  @protected
  AggregationStage(super.fieldName, super.value);
  String get stageName => entry.key;

  AggregationStage.raw(String stageName, MongoDocument raw)
      : super(stageName, MapExpression(raw));
}
