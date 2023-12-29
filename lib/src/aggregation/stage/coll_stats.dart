import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_stage.dart';

/// `$collStats ` aggregation stage
///
/// ### Stage description
///
/// Returns statistics regarding a collection or view.
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/collStats /
class $collStats extends AggregationStage {
  /// Creates `$collStats ` aggregation stage
  ///
  /// [latencyStats] - Adds latency statistics to the return document.
  /// [histograms] - Adds latency histogram information to the embedded
  /// documents in latencyStats if true. Implies latencyStats = True if not null
  /// [storageStats] - Adds storage statistics to the return document.
  /// [scaleFactor] - Implies storageStats = true if not null.
  /// - Specify an empty document (i.e. storageStats: {}) to use the default
  /// scale factor of 1 for the various size data.
  /// Scale factor of 1 displays the returned sizes in bytes.
  /// (StorageStats = true, scaleFactor = null)
  /// - Specify the scale factor (i.e. storageStats: { scale: <number> }) to
  /// use the specified scale factor for the various size data. For example,
  /// to display kilobytes rather than bytes, specify a scale value of 1024.
  ///
  /// The scale factor does not affect those sizes that specify the unit of
  /// measurement in the field name, such as "bytes currently in the cache".
  /// [count] - Adds the total number of documents in the collection to the
  /// return document. Is based on the collection's metadata, which provides a
  /// fast but sometimes inaccurate count for sharded clusters.
  /// [queryExecStats] - Adds query execution statistics to the return document.
  /// New in version 4.4.
  $collStats(
      {bool? latencyStats,
      bool? histograms,
      bool? storageStats,
      int? scaleFactor,
      bool? count,
      bool? queryExecStats})
      : super(
            st$collStats,
            MapExpression({
              if ((latencyStats != null && latencyStats) || histograms != null)
                'latencyStats': {
                  if (histograms != null) 'histograms': histograms
                },
            }));
  $collStats.raw(MongoDocument raw) : super.raw(st$collStats, raw);
}
