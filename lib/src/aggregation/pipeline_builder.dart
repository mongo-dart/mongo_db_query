import 'package:meta/meta.dart';

import '../base/builder.dart';
import 'aggregation_base.dart';

/// Aggregation pipeline builder
class AggregationPipelineBuilder implements Builder {
  @protected
  final stages = <AggregationStage>[];

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
  List<Map<String, dynamic>> build() =>
      [for (var stage in stages) stage.build()];
}
