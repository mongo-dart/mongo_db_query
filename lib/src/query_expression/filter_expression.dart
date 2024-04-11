import 'package:bson/bson.dart';
import 'package:mongo_db_query/src/base/abstract/shape_operator.dart';
import 'package:mongo_db_query/src/base/not_expression.dart';
import 'package:mongo_db_query/src/base/abstract/unary_expression.dart';

import '../aggregation/support_classes/geo/geo_shape.dart';
import '../aggregation/support_classes/geo/geometry.dart';
import '../base/abstract/builder.dart';
import '../base/and_expression.dart';
import '../base/common/constant.dart';
import '../base/common/document_types.dart';
import '../base/common/operators_def.dart';
import '../base/abstract/expression_container.dart';
import '../base/abstract/expression_content.dart';
import '../base/field_expression.dart';
import '../base/list_expression.dart';
import '../base/logical_expression.dart';
import '../base/map_expression.dart';
import '../base/nor_expression.dart';
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
  final _sequence = <ExpressionContent>[];
  FilterExpression? _openChild;

  bool get isOpenSublevel => _openChild != null;
  @Deprecated('use isNotEmpty() instead')
  bool get notEmpty => _sequence.isNotEmpty;

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
    List<UnaryExpression> unaryExps = <UnaryExpression>[];

    ExpressionContent resolveUnaries(ExpressionContent elementToResolve) {
      if (elementToResolve is OperatorExpression) {
        for (var idx = unaryExps.length - 1; idx >= 0; idx--) {
          elementToResolve = unaryExps
              .removeLast()
              .setOperator(elementToResolve as OperatorExpression);
        }
      } else if (elementToResolve is FieldExpression &&
          elementToResolve.content is OperatorExpression) {
        var fieldContent = elementToResolve.content as OperatorExpression;
        for (var idx = unaryExps.length - 1; idx >= 0; idx--) {
          fieldContent = unaryExps.removeLast().setOperator(fieldContent);
        }
        elementToResolve =
            FieldExpression(elementToResolve.fieldName, fieldContent);
      }
      return elementToResolve;
    }

    for (var element in _sequence) {
      if (element is LogicalExpression) {
        // If any uncompleted unary expression, it is lost.
        unaryExps.clear();
      }
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
      } else if (element is UnaryExpression) {
        unaryExps.add(element);
      } else {
        if (actualContainer == null) {
          //content.addAll(element.raw);
          actualContainer = AndExpression()..add(resolveUnaries(element));
        } else if (actualContainer is AndExpression) {
          actualContainer.add(resolveUnaries(element));
        } else if (actualContainer is OrExpression) {
          if (actualContainer.content.values.last is AndExpression) {
            (actualContainer.content.values.last as AndExpression)
                .add(resolveUnaries(element));
          } else {
            actualContainer.add(AndExpression([resolveUnaries(element)]));
          }
        } else if (actualContainer is NorExpression) {
          if (actualContainer.content.values.last is AndExpression) {
            (actualContainer.content.values.last as AndExpression)
                .add(resolveUnaries(element));
          } else {
            actualContainer.add(resolveUnaries(element));
          }
        }
      }
    }
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

  void addFieldOperator(FieldExpression expression) => isOpenSublevel
      ? _openChild!.addFieldOperator(expression)
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

  ExpressionContent _resolveUnaries(ExpressionContent elementToResolve) {
    if (elementToResolve is OperatorExpression) {
      while (_sequence.isNotEmpty && _sequence.last is UnaryExpression) {
        var unary = _sequence.removeLast() as UnaryExpression;
        elementToResolve =
            unary.setOperator(elementToResolve as OperatorExpression);
      }
    } else if (elementToResolve is FieldExpression &&
        elementToResolve.content is OperatorExpression) {
      var fieldContent = elementToResolve.content as OperatorExpression;

      while (_sequence.isNotEmpty && _sequence.last is UnaryExpression) {
        var unary = _sequence.removeLast() as UnaryExpression;
        fieldContent = unary.setOperator(fieldContent);
      }
      elementToResolve =
          FieldExpression(elementToResolve.fieldName, fieldContent);
    }
    return elementToResolve;
  }

  /// $not Inverts the effect of a query expression and returns documents
  /// that do not match the query expression.
  void get $not => _sequence.add(NotExpression.placeHolder());

  /// $and performs a logical AND operation and selects the documents that
  /// satisfy all the expressions.
  void get $and {
    if (isOpenSublevel) {
      return _openChild!.$and;
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
      } else if (last is UnaryExpression) {
        if (last.isInvalid) {
          continue;
        }
        assert(true, 'Should never pass by here');
      } else {
        andExp.add(_resolveUnaries(last));
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
  void get $or {
    if (isOpenSublevel) {
      return _openChild!.$or;
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
      } else if (last is UnaryExpression) {
        if (last.isInvalid) {
          continue;
        }
        assert(true, 'Should never pass by here');
      } else {
        tempAndExp.add(_resolveUnaries(last));
      }
    }
    if (tempAndExp.isNotEmpty) {
      orExp.add(MapExpression(tempAndExp.content.content2map));
    }
    if (orExp.isEmpty) {
      return;
    }
    _sequence.add(orExp);
  }

  /// $nor performs a logical NOR operation on an array of one or
  /// more query expression and selects the documents that fail all the
  /// query expressions in the array.
  void get $nor {
    if (isOpenSublevel) {
      return _openChild!.$nor;
    }
    // if the previous is a logical expression or there is no previous
    // expression, ignore it.
    if (_sequence.isEmpty || _sequence.last is NorExpression) {
      return;
    }
    var norExp = NorExpression();
    var tempAndExp = AndExpression();
    while (_sequence.isNotEmpty) {
      var last = _sequence.removeLast();
      if (last is NorExpression) {
        if (norExp.isNotEmpty) {
          last.add(norExp.content);
        }
        norExp = last;
      } else if (last is UnaryExpression) {
        if (last.isInvalid) {
          continue;
        }
        assert(true, 'Should never pass by here');
      } else {
        tempAndExp.add(_resolveUnaries(last));
      }
    }
    if (tempAndExp.isNotEmpty) {
      norExp.add(MapExpression(tempAndExp.content.content2map));
    }
    if (norExp.isEmpty) {
      return;
    }
    _sequence.add(norExp);
  }

  // ***************************************************
  // ***************** Comparison Operators
  // ***************************************************

  /// Matches values that are equal to a specified value.
  void $eq(String fieldName, value) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$eq, valueToContent(value))));

  void id(value) => $eq(field_id, value);

  /// Matches values that are greater than a specified value.
  void $gt(String fieldName, value) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$gt, valueToContent(value))));

  /// Matches values that are greater than or equal to a specified value.
  void $gte(String fieldName, value) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$gte, valueToContent(value))));

  /// Matches any of the values specified in an array.
  void $in(String fieldName, List values) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$in, ListExpression(values))));

  /// Matches values that are less than a specified value.
  void $lt(String fieldName, value) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$lt, valueToContent(value))));

  /// Matches values that are less than or equal to a specified value.
  void $lte(String fieldName, value) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$lte, valueToContent(value))));

  /// Matches all values that are not equal to a specified value.
  void $ne(String fieldName, value) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$ne, valueToContent(value))));

  /// Matches none of the values specified in an array.
  void $nin(String fieldName, List values) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$nin, ListExpression(values))));

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
    addFieldOperator(FieldExpression(fieldName, mapExp));
  }

  // ***************************************************
  // ***************** Element Query Operators
  // ***************************************************

  /// $exists matches the documents that contain the field,
  /// including documents where the field value is null.
  void $exists(String fieldName) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$exists, valueToContent(true))));

  ///  notExist reTurns only the documents that do not contain the field.
  void notExists(String fieldName) => addFieldOperator(FieldExpression(
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
  void $type(String fieldName, type) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$type, valueToContent(type))));

  // ***************************************************
  // ***************** Evaluation Query Operators
  // ***************************************************

  void $expr(OperatorExpression aggregationExpression) =>
      addOperator(OperatorExpression(
          op$expr, MapExpression(aggregationExpression.build())));

  /// The $jsonSchema operator matches documents that satisfy the
  /// specified JSON Schema.
  void $jsonSchema(Map<String, dynamic> schemaObject) => addOperator(
      OperatorExpression(op$jsonSchema, valueToContent(schemaObject)));

  /// Select documents where the value of a field divided by a divisor
  /// has the specified remainder (i.e. perform a modulo operation to
  /// select documents).
  /// The reminder defaults to zero
  void $mod(String fieldName, int value, {int reminder = 0}) =>
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$mod, ListExpression([value, reminder]))));

  /// Provides regular expression capabilities for pattern matching
  /// strings in queries. MongoDB uses Perl compatible regular expressions
  /// (i.e. "PCRE" ) version 8.42 with UTF-8 support.
  ///
  /// Escape Patterns automatically escapes all the key pattern characters
  /// using RegExp.escape()
  void $regex(String fieldName, String pattern,
      {bool caseInsensitive = false,
      bool multiLineAnchorMatch = false,
      bool extendedIgnoreWhiteSpace = false,
      bool dotMatchAll = false,
      bool escapePattern = false}) {
    // Supports Unicode (u). This flag is accepted, but is redundant.
    // UTF is set by default in the $regex operator,
    //making the u option unnecessary.
    var options = '${caseInsensitive ? 'i' : ''}'
        '${multiLineAnchorMatch ? 'm' : ''}'
        '${extendedIgnoreWhiteSpace ? 'x' : ''}'
        '${dotMatchAll ? 's' : ''}';

    addFieldOperator(FieldExpression(
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
      addFieldOperator(FieldExpression(
          fieldName,
          OperatorExpression(
              op$geoIntersects, MapExpression({op$geometry: geometry}))));

  /// Selects documents with geospatial data that exists entirely
  /// within a specified shape.
  /// Only support GeoShape
  /// Available ShapeOperator instances: Box , Center, CenterSphere, Geometry
  void $geoWithin(String fieldName, shape) {
    if (shape is GeoShape) {
      addFieldOperator(FieldExpression(
          fieldName,
          OperatorExpression(
              op$geoWithin, MapExpression({op$geometry: shape}))));
    } else if (shape is ShapeOperator) {
      addFieldOperator(
          FieldExpression(fieldName, OperatorExpression(op$geoWithin, shape)));
    } else {
      throw ArgumentError('The value is not an expected type '
          '(GeoPolygon, GeoMultiPolygon, GeoShape, ShapeOperator)');
    }
  }

  /// Specifies a point for which a geospatial query returns the documents
  /// from nearest to farthest.
  void $near(String fieldName, GeoPoint value,
      {double? maxDistance, double? minDistance}) {
    addFieldOperator(FieldExpression(
        fieldName,
        MapExpression({
          op$near: MapExpression({
            op$geometry: value,
            if (minDistance != null) op$minDistance: minDistance,
            if (maxDistance != null) op$maxDistance: maxDistance
          }),
        })));
  }

  /// Specifies a point point using legacy coordinates.
  void nearLegacy(String fieldName, List<double> values,
      {double? maxDistance}) {
    addFieldOperator(FieldExpression(
        fieldName,
        MapExpression({
          op$near: values,
          if (maxDistance != null) op$maxDistance: maxDistance
        })));
  }

  /// Specifies a point for which a geospatial query returns the documents
  /// from nearest to farthest.
  /// Only support geometry of point
  void $nearSphere(String fieldName, GeoPoint point,
          {double? maxDistance, double? minDistance}) =>
      addFieldOperator(FieldExpression(
          fieldName,
          OperatorExpression(
              op$nearSphere,
              MapExpression({
                op$geometry: point,
                if (minDistance != null) op$minDistance: minDistance,
                if (maxDistance != null) op$maxDistance: maxDistance
              }))));

  /// Specifies a point point using legacy coordinates.
  void nearSphereLegacy(String fieldName, List<double> values,
      {double? maxDistance, double? minDistance}) {
    addFieldOperator(FieldExpression(
        fieldName,
        MapExpression({
          op$nearSphere: values,
          if (minDistance != null) op$minDistance: minDistance,
          if (maxDistance != null) op$maxDistance: maxDistance
        })));
  }

  // ***************************************************
  // ***************** Array Query Operator
  // ***************************************************

  /// The $all operator selects the documents where the value of a field is
  /// an array that contains all the specified elements.
  void $all(String fieldName, List values) => addFieldOperator(FieldExpression(
      fieldName, OperatorExpression(op$all, ListExpression(values))));

  /// The $elemMatch operator matches documents that contain an array
  /// field with at least one element that matches all the specified
  /// query criteria.
  void $elemMatch(String fieldName, Map<String, dynamic> values) =>
      addFieldOperator(FieldExpression(
          fieldName, OperatorExpression(op$elemMatch, MapExpression(values))));

  void $size(String fieldName, int numElements) =>
      addFieldOperator(FieldExpression(
          fieldName, OperatorExpression(op$size, valueToContent(numElements))));

  // ***************************************************
  // **************    Bit wise operators
  // ***************************************************

  /// $bitsAllClear matches documents where all of the bit positions given by
  /// the query are clear (i.e. 0) in field.
  /// ```
  ///  { <field>: { $bitsAllClear: <numeric bitmask> } }
  ///  { <field>: { $bitsAllClear: < BsonBinary bitmask> } }
  ///  { <field>: { $bitsAllClear: [ <position1>, <position2>, ... ] } }
  /// ```
  /// The field value must be either numeric or a BinData instance. Otherwise,
  /// $bitsAllClear will not match the current document.
  ///
  /// __Numeric Bitmask__
  /// You can provide a numeric bitmask to be matched against the operand field.
  /// It must be representable as a non-negative 32-bit signed integer.
  /// Otherwise, $bitsAllClear will return an error.
  ///
  /// __BinData Bitmask__
  /// You can also use an arbitrarily large BinData instance as a bitmask.
  ///
  /// __Position List__
  /// If querying a list of bit positions, each <position> must be a
  /// non-negative integer. Bit positions start at 0 from the least significant
  /// bit. For example, the decimal number 254 would have the following
  /// bit positions:
  ///
  ///   Bit Value  1  1  1  1  1  1  1  0
  ///   Position   7  6  5  4  3  2  1  0
  ///
  /// ***Behavior***
  ///
  /// __Indexes__
  /// Queries cannot use indexes for the $bitsAllClear portion of a query,
  /// although the other portions of a query can use indexes, if applicable.
  ///
  /// __Floating Point Values__
  /// $bitsAllClear will not match numerical values that cannot be represented as
  /// a signed 64-bit integer. This can be the case if a value is either too
  /// large or too small to fit in a signed 64-bit integer, or if it has a
  /// fractional component.
  ///
  /// __Sign Extension__
  /// Numbers are sign extended. For example, $bitsAllClear considers bit
  /// position 200 to be set for the negative number -5, but bit position 200 to
  /// be clear for the positive number +5.
  /// In contrast, BinData instances are zero-extended. For example, given the
  /// following document:
  /// ```
  /// db.collection.insertOne({ x:  BsonBinary.fromHexString('11'),
  ///            binaryValueofA: "00010001" })
  /// ```
  /// $bitsAllClear will consider all bits outside of x to be clear.
  ///
  /// [see](https://www.mongodb.com/docs/rapid/reference/operator/query/bitsAllClear/)
  void $bitsAllClear(String fieldName, bitMask) {
    if (bitMask is int) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAllClear, valueToContent(bitMask))));
    } else if (bitMask is BsonBinary) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAllClear, valueToContent(bitMask))));
    } else if (bitMask is List<int>) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAllClear, valueToContent(bitMask))));
    } else {
      throw ArgumentError(
          'Unexpected type ${bitMask.runtimeType} in operator "bitsAllClear"');
    }
  }

  /// $bitsAllSet matches documents where all of the bit positions given by
  /// the query are set (i.e. 1) in field.
  /// ```
  ///  { <field>: { $bitsAllSet: <numeric bitmask> } }
  ///  {  <field>: { $bitsAllSet: < BinData bitmask> } }
  ///  { <field>: { $bitsAllSet: [ <position1>, <position2>, ... ] } }
  /// ```
  /// The field value must be either numeric or a BinData instance. Otherwise,
  /// $bitsAllSet will not match the current document.
  ///
  /// __Numeric Bitmask__
  /// You can provide a numeric bitmask to be matched against the operand
  /// field. It must be representable as a non-negative 32-bit signed integer.
  /// Otherwise, $bitsAllSet will return an error.
  ///
  /// __BinData Bitmask__
  /// You can also use an arbitrarily large BinData instance as a bitmask.
  ///
  /// __Position List__
  /// If querying a list of bit positions, each <position> must be a
  /// non-negative integer. Bit positions start at 0 from the least significant
  /// bit. For example, the decimal number 254 would have the following bit
  /// positions:
  ///
  ///   Bit Value  1  1  1  1  1  1  1  0
  ///   Position   7  6  5  4  3  2  1  0
  ///
  /// ***Behavior***
  ///
  /// __Indexes__
  /// Queries cannot use indexes for the $bitsAllSet portion of a query,
  /// although the other portions of a query can use indexes, if applicable.
  ///
  /// __Floating Point Values__
  /// $bitsAllSet will not match numerical values that cannot be represented
  /// as a signed 64-bit integer. This can be the case if a value is either
  /// too large or too small to fit in a signed 64-bit integer, or if it has
  /// a fractional component.
  ///
  /// __Sign Extension__
  /// Numbers are sign extended. For example, $bitsAllSet considers bit
  /// position 200 to be set for the negative number -5, but bit position 200
  /// to be clear for the positive number +5.
  /// In contrast, BinData instances are zero-extended. For example, given the
  /// following document:
  /// ```
  /// db.collection.insertOne({ x: BinData(0, "ww=="),
  ///              binaryValueofA: "11000011" })
  /// ```
  /// $bitsAllSet will consider all bits outside of x to be clear.
  ///
  /// [see](https://www.mongodb.com/docs/rapid/reference/operator/query/bitsAllSet/)
  void $bitsAllSet(String fieldName, bitMask) {
    if (bitMask is int) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAllSet, valueToContent(bitMask))));
    } else if (bitMask is BsonBinary) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAllSet, valueToContent(bitMask))));
    } else if (bitMask is List<int>) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAllSet, valueToContent(bitMask))));
    } else {
      throw ArgumentError(
          'Unexpected type ${bitMask.runtimeType} in operator "bitsAllSet"');
    }
  }

  /// $bitsAnyClear matches documents where any of the bit positions given by
  /// the query are clear (i.e. 0) in field.
  /// ```
  ///  { <field>: { $bitsAnyClear: <numeric bitmask> } }
  ///  {  <field>: { $bitsAnyClear: < BinData bitmask> } }
  ///  { <field>: { $bitsAnyClear: [ <position1>, <position2>, ... ] } }
  /// ```
  /// The field value must be either numeric or a BinData instance. Otherwise,
  /// $bitsAnyClear will not match the current document.
  ///
  /// __Numeric Bitmask__
  /// You can provide a numeric bitmask to be matched against the operand field.
  /// It must be representable as a non-negative 32-bit signed integer.
  /// Otherwise, $bitsAnyClear will return an error.
  ///
  /// __BinData Bitmask__
  ///     You can also use an arbitrarily large BinData instance as a bitmask.
  ///
  /// __Position List__
  /// If querying a list of bit positions, each <position> must be a
  /// non-negative integer. Bit positions start at 0 from the least significant
  /// bit. For example, the decimal number 254 would have the following
  /// bit positions:
  ///
  ///   Bit Value  1  1  1  1  1  1  1  0
  ///   Position   7  6  5  4  3  2  1  0
  ///
  /// ***Behavior***
  ///
  /// __Indexes__
  /// Queries cannot use indexes for the $bitsAnyClear portion of a query,
  /// although the other portions of a query can use indexes, if applicable.
  ///
  /// __Floating Point Values__
  /// $bitsAnyClear will not match numerical values that cannot be represented
  /// as a signed 64-bit integer. This can be the case if a value is either too
  /// large or too small to fit in a signed 64-bit integer, or if it has a
  /// fractional component.
  ///
  /// __Sign Extension__
  /// Numbers are sign extended. For example, $bitsAnyClear considers bit
  /// position 200 to be set for the negative number -5, but bit position 200
  /// to be clear for the positive number +5.
  /// In contrast, BinData instances are zero-extended. For example, given
  /// the following document:
  /// ```
  /// db.collection.insertOne({ x: BinData(0, "ww=="),
  ///                       binaryValueofA: "11000011" })
  /// ```
  /// $bitsAnyClear will consider all bits outside of x to be clear.
  ///
  /// [see](https://www.mongodb.com/docs/rapid/reference/operator/query/bitsAnyClear/)
  void $bitsAnyClear(String fieldName, bitMask) {
    if (bitMask is int) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAnyClear, valueToContent(bitMask))));
    } else if (bitMask is BsonBinary) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAnyClear, valueToContent(bitMask))));
    } else if (bitMask is List<int>) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAnyClear, valueToContent(bitMask))));
    } else {
      throw ArgumentError(
          'Unexpected type ${bitMask.runtimeType} in operator "bitsAnyClear"');
    }
  }

  /// $bitsAnySet matches documents where any of the bit positions given by
  /// the query are set (i.e. 1) in field.
  /// ```
  ///  { <field>: { $bitsAnySet: <numeric bitmask> } }
  ///  { <field>: { $bitsAnySet: < BinData bitmask> } }
  ///  { <field>: { $bitsAnySet: [ <position1>, <position2>, ... ] } }
  /// ```
  /// The field value must be either numeric or a BinData instance. Otherwise,
  /// $bitsAnySet will not match the current document.
  ///
  /// __Numeric Bitmask__
  /// You can provide a numeric bitmask to be matched against the operand field.
  /// It must be representable as a non-negative 32-bit signed integer.
  /// Otherwise, $bitsAnySet will return an error.
  ///
  /// __BinData Bitmask__
  /// You can also use an arbitrarily large BinData instance as a bitmask.
  ///
  /// __Position List__
  /// If querying a list of bit positions, each <position> must be a
  /// non-negative integer. Bit positions start at 0 from the least significant
  /// bit. For example, the decimal number 254 would have the following bit
  /// positions:
  ///
  ///   Bit Value  1  1  1  1  1  1  1  0
  ///   Position   7  6  5  4  3  2  1  0
  ///
  /// ***Behavior***
  ///
  /// __Indexes__
  /// Queries cannot use indexes for the $bitsAnySet portion of a query,
  /// although the other portions of a query can use indexes, if applicable.
  ///
  /// __Floating Point Values__
  /// $bitsAnySet will not match numerical values that cannot be represented
  /// as a signed 64-bit integer. This can be the case if a value is either
  /// too large or too small to fit in a signed 64-bit integer, or if it has
  /// a fractional component.
  ///
  /// __Sign Extension__
  /// Numbers are sign extended. For example, $bitsAnySet considers bit
  ///  position 200 to be set for the negative number -5, but bit position 200
  /// to be clear for the positive number +5.
  /// In contrast, BinData instances are zero-extended. For example, given the
  /// following document:
  /// ```
  /// db.collection.insertOne({ x: BinData(0, "ww=="),
  ///                       binaryValueofA: "11000011" })
  /// ```
  /// $bitsAnySet will consider all bits outside of x to be clear.
  ///
  /// [see](https://www.mongodb.com/docs/rapid/reference/operator/query/bitsAnySet/)
  void $bitsAnySet(String fieldName, bitMask) {
    if (bitMask is int) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAnySet, valueToContent(bitMask))));
    } else if (bitMask is BsonBinary) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAnySet, valueToContent(bitMask))));
    } else if (bitMask is List<int>) {
      addFieldOperator(FieldExpression(fieldName,
          OperatorExpression(op$bitsAnySet, valueToContent(bitMask))));
    } else {
      throw ArgumentError(
          'Unexpected type ${bitMask.runtimeType} in operator "bitsAnySet"');
    }
  }

  // ***************************************************
  // **************    Miscellaneous query operators
  // ***************************************************

  /// The $comment query operator associates a comment to any expression
  /// taking a query predicate.
  void $comment(String commentStr) =>
      addOperator(OperatorExpression(op$comment, valueToContent(commentStr)));

  /// $rand returns a random float between 0 and 1.
  void $rand() => addOperator(OperatorExpression(op$rand, valueToContent({})));

  /// Use in conjunction with cursor.hint() to perform a collection scan to
  /// return documents in natural order.
  ///
  /// For usage, see Force Collection Scans example in the cursor.hint()
  /// reference page.
  ///
  /// You can specify a $natural sort when running a find operation against a
  /// view.
  void $natural({bool ascending = true}) => addOperator(
      OperatorExpression(op$natural, valueToContent(ascending ? 1 : -1)));
}
