import 'package:mongo_db_query/src/aggregation/base/atlas_score_options.dart';

import '../../../base/common/operators_def.dart';
import '../../base/atlas_option.dart';

/// The following score modifying options are available to all operators.
/// - boost
/// - constant
/// - embedded
/// - function
///
/// Example
///
/// Expected result:
/// ```
/// "score": { "boost": { "value": 3 } }
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/score/modify-score/
class ScoreModify extends AtlasOption {
  /// [scoreOption] - The option to be used for modifications
  ScoreModify({required AtlasScoreOption scoreOption})
      : super(optScore, {...scoreOption.build()});
}
