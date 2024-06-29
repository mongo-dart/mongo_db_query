import 'package:meta/meta.dart';

import '../base/abstract/builder.dart';
import 'base/aggregation_stage.dart';

typedef AggregationPipeline = List<AggregationStage>;

AggregationPipelineBuilder pipelineBuilder = AggregationPipelineBuilder();

/// Aggregation pipeline builder
class AggregationPipelineBuilder implements Builder {
  AggregationPipelineBuilder([AggregationPipeline? stages])
      : stages = stages ?? <AggregationStage>[];
  @protected
  final AggregationPipeline stages;

  /// Adds stage to the pipeline
  void addStage(AggregationStage stage) => stages.add(stage);

  /// Builds pipeline
  ///
  /// Returns aggregation pipeline in format suitable for mongodb aggregate
  /// query
  @override
  List<Map<String, dynamic>> build() =>
      [for (var stage in stages) stage.build()];
}
