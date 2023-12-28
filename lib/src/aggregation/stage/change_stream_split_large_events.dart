import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_base.dart';

/// `$changeStreamSplitLargeEvent ` aggregation stage
///
/// ### Stage description.
///
/// New in version 7.0.
///
/// If a change stream has large events that exceed 16 MB, a BSONObjectTooLarge
/// exception is returned. Starting in MongoDB 7.0, you can use a
/// $changeStreamSplitLargeEvent stage to split the events into smaller
/// fragments.
/// You should only use $changeStreamSplitLargeEvent when strictly necessary.
/// For example, if your application requires full document pre- or
/// post-images, and generates large events that exceed 16 MB,
/// use $changeStreamSplitLargeEvent.
///
/// Before you decide to use $changeStreamSplitLargeEvent, you should first
/// try to reduce the change event size. For example:
///
/// - Don't request document pre- or post-images unless your application
/// requires them. This generates fullDocument and fullDocumentBeforeChange
/// fields in more cases, which are typically the largest objects in a
/// change event.
///
/// - Use a $project stage to include only the fields necessary for your
/// application. This reduces the change event size and avoids the additional
/// time to split large events into fragments.
/// This allows more change events to be returned in each batch.
///
/// You can only have one $changeStreamSplitLargeEvent stage in your pipeline,
/// and it must be the last stage.
/// You can only use $changeStreamSplitLargeEvent in a $changeStream pipeline.
///
/// Example:
///
/// Dart code
/// ```dart
/// $changeStreamSplitLargeEvent().build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  $changeStreamSplitLargeEvent: {}
/// }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/changeStreamSplitLargeEvent/
class $changeStreamSplitLargeEvent extends AggregationStage {
  $changeStreamSplitLargeEvent()
      : super(st$changeStreamSplitLargeEvent, MapExpression({}));
}
