/* import '../base/builder.dart';
import '../base/common/constant.dart';
import '../base/common/document_types.dart';
import '../base/common/operators_def.dart';
import '../base/map_expression.dart';
import '../query_expression/filter_expression.dart';
import 'mixin/arithmetic_mixin.dart';
import 'mixin/date_time_mixin.dart';
import 'mixin/accumulator_mixin.dart';

part 'support_classes/aggregation_stages.dart';

StageExpression stage = StageExpression();

class Stage
    with ArithmeticMixin, DateTimeMixin, AccumulatorMixin
    implements Builder {
  Stage(
    this.stageName,
  );
  String stageName;

  StageExpression aggregationStage = StageExpression();

  @override
  build() => {stageName: aggregationStage.build()};

  @override
  List<MapExpression> get sequence => aggregationStage.sequence;
}

class StageExpression extends MapExpression implements Builder {
  StageExpression() : super.empty();

  bool expressionProcessed = false;
  final sequence = <MapExpression>[];

  bool get notEmpty => sequence.isNotEmpty;
  MongoDocument get content =>
      expressionProcessed ? <String, dynamic>{...valueMap} : rawContent;

  @override
  MongoDocument build() => content;

  @override
  MongoDocument get rawContent {
    if (!expressionProcessed) {
      processExpression();
    }
    return content;
  }

  @override
  String toString() => 'AggregationStage($rawContent)';

  void processExpression() {
    expressionProcessed = true;
    valueMap.clear();
    for (var element in sequence) {
      var insertMap = <String, dynamic>{...element.rawContent};
      valueMap.addAll(insertMap);
    }
  }

  /// Set a Map
  /// Clears the original content and add the new one
  @override
  void setMap(MongoDocument map) => valueMap = <String, dynamic>{...map};

  /// Add a Map
  /// Add a map content to the actual content.
  /// If any key alreay exists, it is substituted
  @override
  void addMap(MongoDocument map) => valueMap.addAll(map);

  /// adds a {$meta : testScore} for search score projection
  void add$metaTextScore(String fieldName) => sequence.add(MapExpression({
        fieldName: {op$meta: 'textScore'}
      }));

  /// adds a {$meta : testScore} for search score projection
  void add$metaIndexKey(String fieldName) => sequence.add(MapExpression({
        fieldName: {op$meta: 'indexKey'}
      }));

  /// Include a field in the returned field list
  /// For embedded Documents use the  dot notation (ex. "<docName>.<field>")
  void includeField(String fieldName) =>
      sequence.add(MapExpression({fieldName: 1}));

  /// Exclude a field from the returned field list
  /// For embedded Documents use the dot notation (ex. "<docName>.<field>")
  void excludeField(String fieldName) =>
      sequence.add(MapExpression({fieldName: 0}));

  /// Exclude the "_id" field from the returned field list
  /// By, default, if not excluded explicitely,
  /// the "_id" field is always returned.
  void excludeId() => sequence.add(MapExpression({field_id: 0}));

  /// The positional $ operator limits the contents of an <array> to return
  /// the first element that matches the query condition on the array.
  void $(String fieldName) => sequence.add(MapExpression({'$fieldName.\$': 1}));

  /// The $elemMatch operator limits the contents of an <array> to return
  /// the first element that matches the given selection.
  /// The $elemMatch projection operator takes an explicit condition argument.
  /// This allows you to project based on a condition not in the query,
  /// or if you need to project based on multiple fields in the array's
  /// embedded documents.
  void $elemMatch(String fieldName, FilterExpression condition) =>
      sequence.add(MapExpression({
        fieldName: {op$elemMatch: condition.rawContent}
      }));

  /// The $slice projection operator specifies the number of elements in an
  ///   array to return in the query result.
  /// For embedded Documents use the  dot notation (ex. "<docName>.<field>")
  void $slice(String fieldName, int elementsToReturn, {int? elementsToSkip}) =>
      sequence.add(MapExpression({
        fieldName: {
          if (elementsToSkip == null)
            op$slice: elementsToReturn
          else
            op$slice: [elementsToReturn, elementsToSkip]
        }
      }));
}
 */