import 'package:meta/meta.dart';

import '../base/builder.dart';
import 'base/aggregation_stage.dart';

typedef AggregationPipeline = List<AggregationStage>;

/// Aggregation pipeline builder
class AggregationPipelineBuilder implements Builder {
  @protected
  final AggregationPipeline stages = <AggregationStage>[];

  /// Adds stage to the pipeline
  AggregationPipelineBuilder addStage(AggregationStage stage) {
    stages.add(stage);
    return this;
  }

  /// Builds pipeline
  ///
  /// Returns aggregation pipeline in format suitable for mongodb aggregate
  /// query
  @override
  List<Map<String, Object>> build() => [
        for (var stage in stages) <String, Object>{...stage.build()}
      ];
}
