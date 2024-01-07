import 'package:mongo_db_query/src/aggregation/atlas/options/score_modify.dart';

import '../../../base/common/operators_def.dart';
import '../../base/atlas_operator.dart';

/// The exists operator tests if a path to a specified indexed field name
/// exists in a document. If the specified field exists but is not indexed,
/// the document is not included with the result set. exists is often used
/// as part of a compound query in conjunction with other search clauses.
///
/// Example
///
/// Expected result:
/// ```
/// "exists": {
///   "path": "type"
///   }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/exists/
class Exists extends AtlasOperator {
  /// [path] - Indexed field to search.
  ///
  /// [score] - Score to assign to matching search results. To learn more
  /// about the options to modify the default score
  Exists({required String path, ScoreModify? score})
      : super(opExists, {
          'path': path,
          if (score != null) ...score.build(),
        });
}
