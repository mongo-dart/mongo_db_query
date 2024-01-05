import '../base/builder.dart';
import '../base/common/document_types.dart';
import '../base/expression_container.dart';
import '../base/map_expression.dart';

class SortExpression
    implements ExpressionContainer, Builder /* MapExpression */ {
  SortExpression() /* : super.empty() */;

  final _expression = MapExpression.empty();

  bool expressionProcessed = false;
  final _sequence = <MapExpression>[];

  @Deprecated('use isNotEmpty() instead')
  bool get notEmpty => _sequence.isNotEmpty;
  /* IndexDocument get content =>
      expressionProcessed ? <String, Object>{...valueMap} : rawContent; */

  @override
  bool get isEmpty =>
      expressionProcessed ? _expression.isEmpty : _sequence.isEmpty;

  @override
  bool get isNotEmpty =>
      expressionProcessed ? _expression.isNotEmpty : _sequence.isNotEmpty;

  @override
  @Deprecated('use build() instead')
  MongoDocument get rawContent => build();

  @override
  IndexDocument build() {
    if (!expressionProcessed) {
      processExpression();
    }
    return <String, Object>{..._expression.rawContent};

    /*  return content; */
  }

  //@override
  //String toString() => 'SortExpression($rawContent)';

  void processExpression() {
    expressionProcessed = true;
    //valueMap.clear();
    _expression.setMap({});

    for (var element in _sequence) {
      //var insertMap = <String, Object>{...element.rawContent};
      //valueMap.addAll(insertMap);
      _expression.addMapExpression(element);
    }
  }

  /// Set a Map
  /// Clears the original content and add the new one
  void setMap(MongoDocument map) =>
      _expression.setMap(<String, Object>{...map});

  /// Add a Map
  /// Add a map content to the actual content.
  /// If any key alreay exists, it is substituted
  void addMap(MongoDocument map) => _expression.addMap(map as IndexDocument);

  /// Add a key-value pair
  /// If the key already exists, the value is substituted
  void addEntry(String key, value) => _expression.addEntry(key, value);

  /// adds a {$meta : testScore} for field text search
  void add$meta(String fieldName) => _sequence.add(MapExpression({
        fieldName: {r'$meta': 'textScore'}
      }));
  void addField(String fieldName, {bool descending = false}) =>
      _sequence.add(MapExpression({fieldName: descending ? -1 : 1}));
}
