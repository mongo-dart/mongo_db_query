import 'expression.dart';
import 'common/document_types.dart';
import 'expression_container.dart';
import 'expression_content.dart';
import 'value_expression.dart';

/// A container for a Map
///
/// It can contain empty maps, with only one element or even more.
class MapExpression extends ExpressionContainer {
  // Constructor must be designed like this, so that the
  // valueMap Map continues beeing of type MongoDocument.
  // If not, we could have problems with the addAll method
  MapExpression(MongoDocument value) : valueMap = {...value};
  MapExpression.empty() : valueMap = emptyMongoDocument;

  MongoDocument valueMap;
  int get length => valueMap.length;

  @override
  MongoDocument get rawContent => {
        for (var entry in valueMap.entries)
          if (entry.value is Expression)
            entry.key: entry.value.build()
          else if (entry.value is ExpressionContent)
            entry.key: entry.value.rawContent
          else
            entry.key: entry.value
      };

  @override
  bool get isEmpty => valueMap.isEmpty;

  @override
  bool get isNotEmpty => valueMap.isNotEmpty;

  bool get hasOneKeyOnly => valueMap.length == 1;
  bool get canBePromotedToExpression => hasOneKeyOnly;

  Expression? toExpression() => !canBePromotedToExpression
      ? null
      : Expression(
          valueMap.keys.first, ValueExpression.create(valueMap.values.first));

  /// Set a Map
  /// Clears the original content and add the new one
  void setMap(MongoDocument map) => valueMap = {...map};

  /// Set a MapExpression -
  /// Clears the original content and add the new one
  void setMapExpression(MapExpression expression) =>
      setMap({...expression.rawContent});

  /// Set a key-value pair
  ///Clears the original content and add the key value pair received
  void setEntry(String key, value) => setMap({key: value});

  /// Set a Map entry
  /// The Content is cleared and the single key-value pair is inserted
  void setMapEntry(MapEntry<String, dynamic> entry) =>
      setMap({entry.key: entry.value});

  /// Set an Expression
  /// clears the original content and add the expression
  /// as expressionKey : expressionContent (as map)
  void setExpression(Expression operatorExp) => setMap(operatorExp.build());

  /// Add a Map
  /// Add a map content to the actual content.
  /// If any key alreay exists, it is substituted
  void addMap(MongoDocument map) => valueMap.addAll(map);

  /// Add a MapExpression -
  /// Add a map expression content to the actual content.
  /// If any key alreay exists, it is substituted
  void addMapExpression(MapExpression expression) =>
      addMap(expression.rawContent);

  /// Add a key-value pair
  /// If the key already exists, the value is substituted
  void addEntry(String key, value) => valueMap[key] = value;

  /// Add an Expression -
  /// Add an expression key-value pair to the actual content.
  /// If they key alreay exists, its value is substituted
  void addExpression(Expression operatorExp) => addMap(operatorExp.build());

  /// Add a key-value pair
  /// If the key already exists, the value is substituted
  void addMapEntry(MapEntry<String, dynamic> entry) =>
      addEntry(entry.key, entry.value);

  /// Tries to merge the contents if they both are resolvable
  /// to a Map, otherwise acts like an addEntry method
  ///
  /// Checks if there is not the key
  /// If not adds the key - content pair to the actual content.
  /// Otherwise checks if acrual and received contents are resolvable
  /// to a Map. If not, it acts like an addEntry method.
  ///
  /// If yes it adds the new content to the actual content
  /// If a key of the content is already present its value is overwritten
  void merge(key, content) {
    if (!valueMap.containsKey(key)) {
      addEntry(key, content);
      return;
    }
    /* if (content is! Map &&
        content is! MapExpression &&
        content is! MapEntry &&
        content is! Expression) {
      addEntry(key, content);
      return;
    } */
    MongoDocument contentMap;
    if (content is MongoDocument) {
      contentMap = content;
    } else if (content is Expression) {
      contentMap = content.build();
    } else if (content is MapExpression) {
      contentMap = content.rawContent;
    } else if (content is MapEntry) {
      contentMap = {content.key: content.value};
    } else {
      addEntry(key, content);
      return;
    }
    var origin = valueMap[key];

    /*   if (origin is Map) {
      addEntry(key, {...origin, ...contentMap});
    } else if (origin is Expression) {
      addEntry(key, {...origin.raw, ...contentMap});
    } else if (origin is MapExpression) {
      addEntry(key, {...origin.rawContent, ...contentMap});
    } else if (origin is MapEntry) {
      addEntry(key, {origin.key: origin.value, ...contentMap});
    } else {
      // TODO check
      addEntry(key, contentMap);
      //var entry = contentMap.entries.first;
      //addEntry(entry.key, entry.value);
    }
 */
    if (origin is Map) {
      contentMap = {...origin, ...contentMap};
    } else if (origin is Expression) {
      contentMap = {...origin.build(), ...contentMap};
    } else if (origin is MapExpression) {
      contentMap = {...origin.rawContent, ...contentMap};
    } else if (origin is MapEntry) {
      contentMap = {origin.key: origin.value, ...contentMap};
    }
    addEntry(key, contentMap);
  }

  /// Merges the entry in this mapExpression.
  void mergeEntry(MapEntry entry) => merge(entry.key, entry.value);

  /// Merges a MongoDocument into this MapExpression
  void mergeDocument(MongoDocument document) {
    for (var entry in document.entries) {
      mergeEntry(entry);
    }
  }

  /// Merges a MapExpression into this MapExpression
  void mergeMapExpression(MapExpression expression) =>
      mergeDocument(expression.rawContent);

  /// Merges a MapExpression into this MapExpression
  void mergeExpression(Expression expression) =>
      merge(expression.key, expression.content);
}
