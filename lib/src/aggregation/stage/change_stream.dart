import 'package:bson/bson.dart';

import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_stage.dart';

/// `$changeStream ` aggregation stage
///
/// ### Stage description.
///
/// Returns a Change Stream cursor on a collection, a database, or an entire
/// cluster. Must be used as the first stage in an aggregation pipeline.
///
/// Example:
///
/// Dart code
/// ```dart
/// $changeStream().build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  $changeStream: {}
/// }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/changeStream/
class $changeStream extends AggregationStage {
  /// Creates `$changeStream` aggregation stage
  ///
  /// [allChangesForCluster] - Sets whether the change stream should include
  /// all changes in the cluster. May only be opened on the admin database.
  /// [fullDocument] - Specifies whether change notifications include a copy
  /// of the full document when modified by update operations.
  /// - default: Change notifications do not include the full document for
  /// update operations.
  /// - required: Change notifications includes a copy of the modified document
  /// as it appeared immediately after the change. If the document cannot be
  /// found, the change stream throws an error.
  /// To use this option, you must first use the collMod command to enable the
  /// changeStreamPreAndPostImages option. New in version 6.0.
  ///
  /// - updateLookup: Change notifications includes a copy of the document
  /// modified by the change. This document is the current majority-committed
  /// document or null if it no longer exists.
  /// - whenAvailable: Change notification includes a copy of the modified
  /// document as it appeared immediately after the change or null if the
  /// document is unavailable. To use this option, you must first use the
  /// collMod command to enable the changeStreamPreAndPostImages option.
  ///  New in version 6.0.
  ///
  /// In the case of partial updates, the change notification also provides a
  /// description of the change.
  /// [fullDocumentBeforeChange] - Include the full document from before the
  /// change. This field accepts the following values:
  /// - off: Disables inclusion of the document from before the change.
  /// - whenAvailable: Includes document from before the change. The query
  /// does not fail if the unmodified document is not available.
  /// - required: Includes document from before the change. The query fails
  /// if the unmodified document is not available.
  /// [resumeAfter] - Specifies a resume token as the logical starting point
  /// for the change stream. Cannot be used with startAfter or
  /// startAtOperationTime fields.
  /// [showExpandedEvents] - Specifies whether to include additional
  /// change events, such as such as DDL and index operations.
  /// New in version 6.0.
  /// [startAfter] - Specifies a resume token as the logical starting point for
  /// the change stream. Cannot be used with resumeAfter or
  /// startAtOperationTime fields.
  /// [startAtOperationTime] - Specifies a time as the logical starting point
  /// for the change stream. Cannot be used with resumeAfter or startAfter
  /// fields.

  $changeStream(
      {bool? allChangesForCluster,
      String? fullDocument,
      String? fullDocumentBeforeChange,
      int? resumeAfter,
      bool? showExpandedEvents,
      MongoDocument? startAfter,
      Timestamp? startAtOperationTime})
      : super(
            st$changeStream,
            MapExpression({
              if (allChangesForCluster != null)
                'allChangesForCluster': allChangesForCluster,
              if (fullDocument != null) 'fullDocument': fullDocument,
              if (fullDocumentBeforeChange != null)
                'fullDocumentBeforeChange': fullDocumentBeforeChange,
              if (resumeAfter != null) 'resumeAfter': resumeAfter,
              if (showExpandedEvents != null)
                'showExpandedEvents': showExpandedEvents,
              if (startAfter != null) 'startAfter': MapExpression(startAfter),
              if (startAtOperationTime != null)
                'startAtOperationTime': startAtOperationTime,
            }));
  $changeStream.raw(MongoDocument raw) : super.raw(st$changeStream, raw);
}
