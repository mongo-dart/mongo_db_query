import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/list_expression.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_stage.dart';

/// `$listSessions` aggregation stage
///
/// ### Stage description.
///
/// Lists all sessions stored in the system.sessions collection in the config
/// database. These sessions are visible to all members of the MongoDB
/// deployment.
///
/// Example:
///
/// Dart code
/// ```dart
/// $listSessions(allUsers: true).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $listSessions: { allUsers: true } }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/listSessions/
class $listSessions extends AggregationStage {
  $listSessions({List<MongoDocument>? users, bool? allUsers})
      : super(
            st$listSessions,
            MapExpression({
              if (allUsers != null)
                'allUsers': allUsers
              else if (users != null)
                'users': ListExpression(users)
            }));
  $listSessions.raw(MongoDocument raw) : super.raw(st$listSessions, raw);
}
