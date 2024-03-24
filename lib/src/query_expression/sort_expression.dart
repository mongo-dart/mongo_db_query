import '../base/builder.dart';
import '../base/common/document_types.dart';
import '../base/expression_container.dart';
import '../base/map_expression.dart';

class SortExpression implements ExpressionContainer, Builder {
  SortExpression();

  final _expression = MapExpression.empty();

  bool expressionProcessed = false;
  final _sequence = <MapExpression>[];

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
  }

  void processExpression() {
    expressionProcessed = true;
    _expression.setMap({});

    for (var element in _sequence) {
      _expression.addMapExpression(element);
    }
  }

  void sortBy(Object field) {
    if (field is String) {
      addField(field);
    } else if (field is IndexDocument) {
      for (var entry in field.entries) {
        if (entry.value is int) {
          if (entry.value == -1) {
            addField(entry.key, descending: true);
          } else {
            addField(entry.key);
          }
        } else if (entry.value is IndexDocument) {
          if ((entry.value as IndexDocument).length == 1 &&
              (entry.value as IndexDocument).entries.first.key == r'$meta' &&
              (entry.value as IndexDocument).entries.first.value ==
                  'textScore') {
            add$meta(entry.key);
          } else {
            throw ArgumentError(
                'The received document seems to be not correct ("${entry.value}")');
          }
        }
      }
    } else {
      throw ArgumentError(
          'The received field seems to be not correct ("$field")');
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
