import '../../base/common/document_types.dart';
import '../../base/field_expression.dart';
import '../../base/map_expression.dart';

/// Aggregation stage base
abstract class AggregationStage extends FieldExpression {
  AggregationStage(super.fieldName, super.value);
  String get stageName => entry.key;

  AggregationStage.raw(String fieldName, MongoDocument raw)
      : super(fieldName, MapExpression(raw));
}
