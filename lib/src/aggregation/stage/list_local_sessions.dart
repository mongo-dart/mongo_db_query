import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/list_expression.dart';
import '../../base/map_expression.dart';
import '../base/aggregation_stage.dart';

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
/// $listLocalSessions(allUsers: true).build()
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
