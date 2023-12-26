import 'package:bson/bson.dart';

import '../base/common/document_types.dart';
import '../base/common/operators_def.dart';
import '../base/list_expression.dart';
import '../base/map_expression.dart';
import 'aggregation_base.dart';

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

/// `$currentOp ` aggregation stage
///
/// ### Stage description.
///
/// Returns a stream of documents containing information on active and/or
/// dormant operations as well as inactive sessions that are holding locks as
/// part of a transaction. The stage returns a document for each operation or
/// session. To run $currentOp, use the db.aggregate() helper on the admin
/// database.
///
/// The $currentOp aggregation stage is preferred over the currentOp command.
/// Because the currentOp command and db.currentOp() helper method return the
/// results in a single document, the total size of the currentOp result set is
/// subject to the maximum 16MB BSON size limit for documents. The $currentOp
/// stage returns a cursor over a stream of documents, each of which reports
/// a single operation. Each operation document is subject to the 16MB BSON
/// limit, but unlike the currentOp command, there is no limit on the overall
/// size of the result set.
///
/// $currentOp also enables you to perform arbitrary transformations of the
/// results as the documents pass through the pipeline.
///
/// Example:
///
/// Dart code
/// ```dart
/// $currentOp(allUsers: true, idleSessions: true).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///  { $currentOp : { allUsers: true, idleSessions: true } }
/// }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/currentOp/
class $currentOp extends AggregationStage {
  /// Creates `$changeStream` aggregation stage
  ///
  /// [allUsers] - If set to false, $currentOp only reports on operations/idle
  /// connections/idle cursors/idle sessions belonging to the user who ran
  /// the command. If set to true, $currentOp reports operations belonging
  /// to all users. Defaults to false.
  /// [idleConnections] -  If set to false, $currentOp only reports active
  /// operations. If set to true, $currentOp returns all operations,
  /// including idle connections. Defaults to false.
  /// [idleCursors] - If set to true, $currentOp reports on cursors that are
  /// "idle"; i.e. open but not currently active in a getMore operation.
  /// Information on idle cursors have the type set to "idleCursor".
  /// Information on cursors currently active in a getMore operation
  /// information have the type set to "op" and op set to getmore.
  /// Defaults to false.
  /// [idleSessions] - If set to true, in addition to active/dormant operations,
  /// $currentOp reports on:
  /// - Inactive sessions that are holding locks as part of a transaction.
  /// Each inactive session appears as a separate document in the $currentOp
  /// stream.
  /// - The document for a session includes information on the session ID in
  /// the lsid field and the transaction in the transaction field.
  /// - Information on idle sessions have the type set to "idleSession".
  /// - $currentOp.twoPhaseCommitCoordinator in inactive state
  ///
  /// If set to false, $currentOp doesn't report on:
  /// - Inactive sessions
  /// - $currentOp.twoPhaseCommitCoordinator information in inactive state
  ///
  /// Defaults to true.
  /// [localOps] - If set to true for an aggregation running on mongos,
  /// $currentOp reports only operations running locally on that mongos.
  /// If false, then $currentOp instead reports operations running on the
  /// shards. The localOps parameter has no effect for $currentOp aggregations
  /// running on mongod.
  ///
  /// Defaults to false.
  ///  /// [backtrace] - Determines whether callstack information is returned
  /// as part of the waitingForLatch output field.
  /// If set to true, $currentOp includes waitingForLatch.backtrace field that
  /// contains the callstack information, if available. If unavailable,
  /// the field contains an empty array.
  ///   If set to false, $currentOp omits the waitingForLatch.backtrace field.
  ///
  /// Defaults to false.

  $currentOp(
      {bool? allUsers,
      bool? idleConnections,
      bool? idleCursors,
      bool? idleSessions,
      bool? localOps,
      bool? backtrace})
      : super(
            st$currentOp,
            MapExpression({
              if (allUsers != null) 'allUsers': allUsers,
              if (idleConnections != null) 'idleConnections': idleConnections,
              if (idleCursors != null) 'idleCursors': idleCursors,
              if (idleSessions != null) 'idleSessions': idleSessions,
              if (localOps != null) 'localOps': localOps,
              if (backtrace != null) 'backtrace': backtrace,
            }));
  $currentOp.raw(MongoDocument raw) : super.raw(st$currentOp, raw);
}

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

/// `$listLocalSessions` aggregation stage
///
/// ### Stage description.
///
/// Lists the sessions cached in memory by the mongod or mongos instance.
///
/// Example:
///
/// Dart code
/// ```dart
/// $listLocalSessions([ { x: 10 }, { x: 2 }, { x: 5 } ]).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $listLocalSessions: { allUsers: true } }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/listLocalSessions/
class $listLocalSessions extends AggregationStage {
  $listLocalSessions({List<MongoDocument>? users, bool? allUsers})
      : super(
            st$listLocalSessions,
            MapExpression({
              if (allUsers != null)
                'allUsers': allUsers
              else if (users != null)
                'users': ListExpression(users)
            }));
  $listLocalSessions.raw(MongoDocument raw)
      : super.raw(st$listLocalSessions, raw);
}
