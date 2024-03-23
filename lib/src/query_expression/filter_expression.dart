import '../aggregation/support_classes/geo/geo_shape.dart';
import '../aggregation/support_classes/geo/geometry.dart';
import '../base/builder.dart';
import '../base/common/constant.dart';
import '../base/common/document_types.dart';
import '../base/common/operators_def.dart';
import '../base/expression_container.dart';
import '../base/expression_content.dart';
import '../base/field_expression.dart';
import '../base/list_expression.dart';
import '../base/logical_expression.dart';
import '../base/map_expression.dart';
import '../base/operator_expression.dart';
import '../base/value_expression.dart';
import 'query_expression.dart';

enum LogicType { and, or, nor }

// a = 5 and b = 6 or a = 7 and (b = 9 or c = 4) or c = 2

class FilterExpression
    implements ExpressionContainer, Builder /* MapExpression */ {
  FilterExpression({this.level = 0}) /* : super.empty() */;

  final _expression = MapExpression.empty();

  LogicType? logicType;
  int level = 0;

  /// Or or Nor Nodes int the top level
  bool topNodes = false;
  bool expressionProcessed = false;
  final /* List<Expression> */ _sequence = <ExpressionContent>[];
  FilterExpression? _openChild;

  bool get isOpenSublevel => _openChild != null;
  @Deprecated('use isNotEmpty() instead')
  bool get notEmpty => _sequence.isNotEmpty;
  /*  MongoDocument get content =>
      expressionProcessed ? <String, dynamic>{...valueMap} : rawContent; */

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
  MongoDocument build() /*get  rawContent */ {
    if (isOpenSublevel) {
      _sequence
          .add(MapExpression(_openChild!.build() /* _openChild!.rawContent */));
      _openChild = null;
      expressionProcessed = false;
    }
    if (!expressionProcessed) {
      processExpression();
    }
    //return key == op$And ? content.mergeContent2map : super.raw;
    return _expression.rawContent; //valueMap;
  }

  // TODO Revert after debug
  //@override
  //String toString() => 'UpdateExpression($raw)';

  // TODO check
  void processExpression() {
    LogicalExpression? actualContainer;
    expressionProcessed = true;
    for (var element in _sequence) {
      if (element is AndExpression) {
        if (actualContainer == null) {
          actualContainer = element;
          continue;
        } else if (actualContainer is AndExpression) {
          actualContainer.add(element.content);
        } else if (actualContainer is OrExpression) {
          actualContainer.add(element.content);
        } else if (actualContainer is NorExpression) {
          actualContainer.add(element.content);
        }
      } else if (element is OrExpression) {
        if (actualContainer == null) {
          actualContainer = element;
          continue;
        } else if (actualContainer is AndExpression) {
          element.add(actualContainer.content);
          actualContainer = element;
        } else if (actualContainer is OrExpression) {
          actualContainer.add(element.content);
        } else if (actualContainer is NorExpression) {
          element.add(actualContainer.content);
          actualContainer = element;
        }
      } else if (element is NorExpression) {
        if (actualContainer == null) {
          actualContainer = element;
          continue;
        } else if (actualContainer is AndExpression) {
          element.add(actualContainer.content);
          actualContainer = element;
        } else if (actualContainer is NorExpression) {
          actualContainer.add(element.content);
        } else if (actualContainer is OrExpression) {
          element.add(actualContainer.content);
          actualContainer = element;
        }
      } else {
        if (actualContainer == null) {
          //content.addAll(element.raw);
          actualContainer = AndExpression()..add(element);
        } else if (actualContainer is AndExpression) {
          actualContainer.add(element);
        } else if (actualContainer is OrExpression) {
          if (actualContainer.content.values.last is AndExpression) {
            (actualContainer.content.values.last as AndExpression).add(element);
          } else {
            actualContainer.add(AndExpression([element]));
          }
        } else if (actualContainer is NorExpression) {
          if (actualContainer.content.values.last is AndExpression) {
            (actualContainer.content.values.last as AndExpression).add(element);
          } else {
            actualContainer.add(element);
          }
        }
      }
    }
    //valueMap.addAll(actualContainer?.build() ?? emptyMongoDocument);
    _expression.setMap(actualContainer?.build() ?? emptyMongoDocument);
  }

  void addDocument(MongoDocument document) {
    for (var element in document.entries) {
      if (element.key.startsWith(r'$')) {
        _sequence.add(OperatorExpression(
            element.key, ValueExpression.create(element.value)));
      } else {
        _sequence.add(FieldExpression(
            element.key, ValueExpression.create(element.value)));
      }
    }
  }

  void _addFieldOperator(FieldExpression expression) => isOpenSublevel
      ? _openChild!._addFieldOperator(expression)
      : _sequence.add(expression);

  void addOperator(OperatorExpression expression) {
    if (isOpenSublevel) {
      _openChild!.addOperator(expression);
      return;
    }
    assert(expression is! LogicalExpression,
        'Here should not be a Logical Expression');
    _sequence.add(expression);
  }

  // ***************************************************
  // ***************** Parenthesis
  // ***************************************************

  void get open {
    if (isOpenSublevel) {
      return _openChild!.open;
    }
    _openChild = FilterExpression(level: level + 1);
  }

  void get close {
    if (isOpenSublevel && _openChild!.isOpenSublevel) {
      return _openChild!.close;
    }
    if (_openChild == null) {
      throw StateError('No open parenthesis found');
    }
    if (_openChild!.isNotEmpty) {
      _openChild!.processExpression();
      _sequence.add(MapExpression(_openChild!.build()));
    }

    _openChild = null;
  }

  // ***************************************************
  // ***************** Logical Operators
  // ***************************************************

  /// $not Inverts the effect of a query expression and returns documents
  /// that do not match the query expression.
  void logicNot(OperatorExpression operatorExp) =>
      addOperator(OperatorExpression(op$not, operatorExp));

  /// $and performs a logical AND operation and selects the documents that
  /// satisfy all the expressions.
  void logicAnd() {
    if (isOpenSublevel) {
      return _openChild!.logicAnd();
    }
    // if the previous is a logical expression or there is no previous
    // expression, ignore it.
    var andExp = AndExpression();
    while (_sequence.isNotEmpty) {
      var last = _sequence.removeLast();
      if (last is OrExpression || last is NorExpression) {
        if (andExp.isNotEmpty) {
          (last as LogicalExpression).content.add(andExp);
          andExp = AndExpression();
          _sequence.add(last);
          break;
        }
      }
      if (last is AndExpression) {
        if (andExp.isNotEmpty) {
          last.add(andExp.content);
        }
        andExp = last;
      } else {
        andExp.add(last);
      }
    }
    if (andExp.isEmpty) {
      return;
    }
    //if (key == op$And) {
    //  content.add(andExp.content);
    //  return;
    //}
    _sequence.add(andExp);
  }

  /// $or operator performs a logical OR operation on an array of one or
  /// more expressions and selects the documents that satisfy at least one
  /// of the expressions.
  void logicOr() {
    if (isOpenSublevel) {
      return _openChild!.logicOr();
    }
    // if the previous is a logical expression or there is no previous
    // expression, ignore it.
    if (_sequence.isEmpty || _sequence.last is OrExpression) {
      return;
    }
    var orExp = OrExpression();
    var tempAndExp = AndExpression();
    while (_sequence.isNotEmpty) {
      var last = _sequence.removeLast();
      if (last is OrExpression) {
        if (orExp.isNotEmpty) {
          last.add(orExp.content);
        }
        orExp = last;
      } else {
        tempAndExp.add(last);
      }
    }
    if (tempAndExp.isNotEmpty) {
      //if (tempAndExp.content.values.length == 1) {
      orExp.add(MapExpression(tempAndExp.content.content2map));
      //} else {
      //  orExp.add(tempAndExp);
      //}
    }
    if (orExp.isEmpty) {
      return;
    }
    //if (key == op$And) {
    //  content.add(andExp.content);
    //  return;
    //}
    _sequence.add(orExp);
  }

  /// $nor performs a logical NOR operation on an array of one or
  /// more query expression and selects the documents that fail all the
  /// query expressions in the array.
  void logicNor() {
    if (isOpenSublevel) {
      return _openChild!.logicNor();
    }
    // if the previous is a logical expression or there is no previous
    // expression, ignore it.
    if (_sequence.isEmpty || _sequence.last is LogicalExpression) {
      return;
    }
  }

  // ***************************************************
  // ***************** Comparison Operators
  // ***************************************************

  /// Matches values that are equal to a specified value.
  void $eq(String fieldName, value) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$eq, valueToContent(value))));

  void id(value) => $eq(field_id, value);

  /// Matches values that are greater than a specified value.
  void $gt(String fieldName, value) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$gt, valueToContent(value))));

  /// Matches values that are greater than or equal to a specified value.
  void $gte(String fieldName, value) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$gte, valueToContent(value))));

  /// Matches any of the values specified in an array.
  void $in(String fieldName, List values) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$in, ListExpression(values))));

  /// Matches values that are less than a specified value.
  void $lt(String fieldName, value) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$lt, valueToContent(value))));

  /// Matches values that are less than or equal to a specified value.
  void $lte(String fieldName, value) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$lte, valueToContent(value))));

  /// Matches all values that are not equal to a specified value.
  void $ne(String fieldName, value) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$ne, valueToContent(value))));

  /// Matches none of the values specified in an array.
  void $nin(String fieldName, List values) => addOperator(OperatorExpression(
      op$nin, FieldExpression(fieldName, ListExpression(values))));

  // ***************************************************
  // ***************** Element Query Operators
  // ***************************************************

  /// $exists matches the documents that contain the field,
  /// including documents where the field value is null.
  void $exists(String fieldName) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$exists, valueToContent(true))));

  ///  notExist reTurns only the documents that do not contain the field.
  void notExists(String fieldName) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$exists, valueToContent(false))));

  /// $type selects documents where the value of the field is an instance
  /// of the specified BSON type(s). Querying by data type is useful
  /// when dealing with highly unstructured data where data types
  /// are not predictable.
  /// You can user either the identification number o the type alias:
  /// BSON Type       Id Number        Alias              Const
  ///   Double          1             "double"          bsonDataNumber
  ///   String          2             "string"          bsonDataString
  ///   Object          3             "object"          bsonDataObject
  ///   Array           4             "array"           bsonDataArray
  ///   Binary Data     5             "binData"         bsonDataBinary
  ///   ObjectId        7             "objectId"        bsonDataObjectId
  ///   Boolean         8             "bool"            bsonDataBool
  ///   Date            9             "date"            bsonDataDate
  ///   Null           10             "null"            bsonDataNull
  ///   Regular Exp    11             "regex"           bsonDataRegExp
  ///   32-bit integer 16             "int"             bsonDataInt
  ///   Timestamp      17             "timestamp"       bsonDataTimestamp
  ///   64-bit integer 18             "long"            bsonDataLong
  ///   Decimal128     19             "decimal"         bsonDecimal128
  void $type(String fieldName, List types) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$type, ListExpression(types))));
  // ***************************************************
  // ***************** Evaluation Query Operators
  // ***************************************************

  void $expr(OperatorExpression aggregationExpression) =>
      addOperator(OperatorExpression(
          op$expr, MapExpression(aggregationExpression.build())));

  /// The $jsonSchema operator matches documents that satisfy the
  /// specified JSON Schema.
  // TODO check if String or Map are required
  void $jsonSchema(String schemaObject) => addOperator(
      OperatorExpression(op$jsonSchema, valueToContent(schemaObject)));

  /// Select documents where the value of a field divided by a divisor
  /// has the specified remainder (i.e. perform a modulo operation to
  /// select documents).
  /// The reminder defaults to zero
  void $mod(String fieldName, int value, {int reminder = 0}) =>
      _addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$mod, ListExpression([value, reminder]))));

  /// Provides regular expression capabilities for pattern matching
  /// strings in queries. MongoDB uses Perl compatible regular expressions
  /// (i.e. "PCRE" ) version 8.42 with UTF-8 support.
  void $regex(String fieldName, String pattern,
      {bool caseInsensitive = false,
      bool multiLineAnchorMatch = false,
      bool extendedIgnoreWhiteSpace = false,
      bool dotMatchAll = false,
      bool escapePattern = false}) {
    var options = '${caseInsensitive ? 'i' : ''}'
        '${multiLineAnchorMatch ? 'm' : ''}'
        '${extendedIgnoreWhiteSpace ? 'x' : ''}'
        '${dotMatchAll ? 's' : ''}';

    _addFieldOperator(FieldExpression(
        fieldName,
        MapExpression({
          op$regex:
              valueToContent(escapePattern ? RegExp.escape(pattern) : pattern),
          if (options.isNotEmpty) op$options: options
        })));
  }

  void $text(String search,
          {String? language, bool? caseSensitive, bool? diacriticSensitive}) =>
      addOperator(OperatorExpression(
          op$text,
          MapExpression({
            op$search: search,
            if (language != null) op$language: language,
            if (caseSensitive != null && caseSensitive)
              op$caseSensitive: caseSensitive,
            if (diacriticSensitive != null && diacriticSensitive)
              op$diacriticSensitive: diacriticSensitive,
          })));

  /// Use the $where operator to pass either a string containing a JavaScript
  /// expression or a full JavaScript function to the query system.
  /// The $where provides greater flexibility, but requires that the database
  /// processes the JavaScript expression or function for each document
  /// in the collection.
  /// Reference the document in the JavaScript expression or function
  /// using either this or obj .
  void $where(String function) =>
      addOperator(OperatorExpression(op$where, valueToContent(function)));

  // ***************************************************
  // ***************** Geo Spatial
  // ***************************************************

  /// Geospatial operators return data based on geospatial expression conditions
  void $geoIntersects(String fieldName, Geometry geometry) =>
      _addFieldOperator(FieldExpression(
          fieldName,
          OperatorExpression(
              op$geoIntersects, MapExpression({op$geometry: geometry}))));

  /// Selects documents with geospatial data that exists entirely
  /// within a specified shape.
  /// Only support GeoShape
  /// Available ShapeOperator instances: Box , Center, CenterSphere, Geometry
  void $geoWithin(String fieldName, GeoShape shape) =>
      _addFieldOperator(FieldExpression(
          fieldName,
          OperatorExpression(
              op$geoWithin, MapExpression({op$geometry: shape}))));

  /// Specifies a point for which a geospatial query returns the documents
  /// from nearest to farthest.
  void $near(String fieldName, var value,
      {double? maxDistance, double? minDistance}) {
    _addFieldOperator(FieldExpression(
        fieldName,
        MapExpression({
          op$near: value,
          if (minDistance != null) op$minDistance: minDistance,
          if (maxDistance != null) op$maxDistance: maxDistance
        })));
  }

  /// Specifies a point for which a geospatial query returns the documents
  /// from nearest to farthest.
  /// Only support geometry of point
  void $nearSphere(String fieldName, GeoPoint point,
          {double? maxDistance, double? minDistance}) =>
      _addFieldOperator(FieldExpression(
          fieldName,
          OperatorExpression(
              op$nearSphere,
              MapExpression({
                op$geometry: point,
                if (minDistance != null) op$minDistance: minDistance,
                if (maxDistance != null) op$maxDistance: maxDistance
              }))));

  // ***************************************************
  // ***************** Array Query Operator
  // ***************************************************

  /// The $all operator selects the documents where the value of a field is
  /// an array that contains all the specified elements.
  void $all(String fieldName, List values) => _addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$all, ListExpression(values))));

  /// The $elemMatch operator matches documents that contain an array
  /// field with at least one element that matches all the specified query criteria.
  void $elemMatch(String fieldName, List values) =>
      _addFieldOperator(FieldExpression(
          fieldName, OperatorExpression(op$elemMatch, ListExpression(values))));

  void $size(String fieldName, int numElements) =>
      _addFieldOperator(FieldExpression(
          fieldName, OperatorExpression(op$size, valueToContent(numElements))));

  /*  void match(String fieldName, String pattern,
          {bool? multiLine,
          bool? caseInsensitive,
          bool? dotAll,
          bool? extended}) =>
      _addExpression(fieldName, {
        '\$regex': BsonRegexp(pattern,
            multiLine: multiLine,
            caseInsensitive: caseInsensitive,
            dotAll: dotAll,
            extended: extended)
      }); */

  void inRange(String fieldName, min, max,
      {bool minInclude = true, bool maxInclude = false}) {
    var mapExp = MapExpression.empty();
    if (minInclude) {
      mapExp.addExpression(OperatorExpression(op$gte, valueToContent(min)));
    } else {
      mapExp.addExpression(OperatorExpression(op$gt, valueToContent(min)));
    }
    if (maxInclude) {
      mapExp.addExpression(OperatorExpression(op$lte, valueToContent(max)));
    } else {
      mapExp.addExpression(OperatorExpression(op$lt, valueToContent(max)));
    }
    _addFieldOperator(FieldExpression(fieldName, mapExp));
  }

  // ***************************************************
  // **************    Bit wise operators
  // ***************************************************

  // TODO Missing  $bitsAllClear
  // TODO Missing $bitsAllSet
  // TODO Missing $bitsAnyClear
  // TODO Missing $bitsAnySet

  // ***************************************************
  // **************    Miscellaneous query operators
  // ***************************************************

  /// The $comment query operator associates a comment to any expression
  /// taking a query predicate.
  void $comment(String commentStr) {
    addOperator(OperatorExpression(op$comment, valueToContent(commentStr)));
  }
  // TODO Missing $rand
  // TODO Missing $natural
}
