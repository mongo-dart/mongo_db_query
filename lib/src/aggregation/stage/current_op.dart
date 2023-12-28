import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_base.dart';

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
