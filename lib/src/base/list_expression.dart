import 'expression.dart';
import 'common/document_types.dart';
import 'common/operators_def.dart';
import 'expression_container.dart';
import 'expression_content.dart';
import 'field_expression.dart';
import 'map_expression.dart';

class ListExpression extends ExpressionContainer {
  ListExpression(this.values);
  ListExpression.empty() : values = [];

  final List values;

  int get length => values.length;

  @override
  bool get isEmpty => values.isEmpty;

  @override
  bool get isNotEmpty => values.isNotEmpty;
  bool get canBeSimplified {
    var keys = keysList;
    if (keys == null) {
      return false;
    }
    if (keys.length == 1) {
      return true;
    }
    for (int pos = 0; pos < keys.length - 1; pos++) {
      if (keys[pos] == '') {
        continue;
      }
      if (keys.sublist(pos + 1).contains(keys[pos])) return false;
    }
    /* var value = keys..(
        (element) => element != '' && keys.contains(element),
        orElse: () => '');
    return value == ''; */
    return true;
  }

  /* {
    var rawTemp = raw;
    var localKeys = <String>[];
    for (var element in rawTemp) {
      if (element is! Map) {
        return false;
      }
      if (element.keys.length > 1) {
        return false;
      }
      if (element.isEmpty) {
        continue;
      }
      var key = element.keys.first;
      if (key is! String) {
        return false;
      }
      if (localKeys.contains(key)) {
        return false;
      }
      localKeys.add(key);
    }
    return true;
  } */

  List<String>? get keysList {
    var rawTemp = rawContent;
    var localKeys = <String>[];
    for (var element in rawTemp) {
      if (element is! Map) {
        return null;
      }
      if (element.keys.length > 1) {
        return null;
      }
      if (element.isEmpty) {
        localKeys.add('');
        continue;
      }
      var key = element.keys.first;
      if (key is! String) {
        return null;
      }
      localKeys.add(key);
    }
    return localKeys;
  }

  void add(value) => values.add(value);

  @override
  List get rawContent => [
        for (var element in values)
          element is Expression
              ? element.build()
              : (element is ExpressionContent ? element.rawContent : element)
      ];

  MongoDocument get content2map => {
        for (var element in values)
          if (element is Expression)
            ...(element.build())
          else if (element is MongoDocument)
            ...element
          else if (element is MapExpression)
            ...element.rawContent
          else if (element is ExpressionContent)
            'key': element.rawContent
          else
            'key': element
      };

  MongoDocument get mergeContent2map {
    var ret = MapExpression.empty();

    for (var element in values) {
      if (element is Expression) {
        ret.mergeExpression(element);
      } else if (element is MongoDocument) {
        for (var entity in element.entries) {
          ret.merge(entity.key, entity.value);
        }
      } else if (element is MapExpression) {
        for (var entity in element.rawContent.entries) {
          ret.merge(entity.key, entity.value);
        }
      } else if (element is ExpressionContent) {
        ret.merge('key', element.rawContent);
      } else {
        ret.merge('key', element);
      }
    }
    MongoDocument allAnd = emptyMongoDocument;
    for (var entry in ret.valueMap.entries) {
      if (entry.key != op$and) {
        break;
      }
      allAnd = {
        ...allAnd,
        if (entry.value is List)
          for (var element in entry.value) ...element
        else
          ...entry.value
      };
    }
    if (allAnd.isNotEmpty) {
      return allAnd;
    }

    return ret.rawContent;
  }

  bool mergeAtElement(ExpressionContent expression, int index) {
    var toBeMerged = values.elementAt(index);
    if (toBeMerged is MapExpression) {
      if (toBeMerged.length != 1) {
        return false;
      }
      if (expression is Expression) {
        toBeMerged.mergeExpression(expression);
      } else if (expression is MapExpression) {
        toBeMerged.mergeMapExpression(expression);
      }
      return true;
    }
    if (toBeMerged is Expression) {
      MapExpression mapExpression;
      if (toBeMerged.content is! MapExpression) {
        // here we need the content
        // ignore: deprecated_member_use_from_same_package
        mapExpression = MapExpression(toBeMerged.rawContent);
      } else {
        mapExpression = toBeMerged.content as MapExpression;
      }
      if (expression is FieldExpression && expression.content is Expression) {
        mapExpression.mergeExpression(expression.content as Expression);
      } else if (expression is Expression) {
        // TODO check
        mapExpression.mergeExpression(expression);
      } else if (expression is MapExpression) {
        if (mapExpression.length != 1) {
          return false;
        }
        mapExpression.mergeMapExpression(expression);
      }
      values[index] = Expression(toBeMerged.key, mapExpression);
      return true;
    }
    return false;
  }
}
