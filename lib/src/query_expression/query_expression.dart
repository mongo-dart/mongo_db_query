import 'dart:convert';

import 'package:bson/bson.dart';

import '../aggregation/support_classes/geo/geo_shape.dart';
import '../aggregation/support_classes/geo/geometry.dart';
import '../base/common/constant.dart';
import '../base/common/document_types.dart';
import '../base/expression_content.dart';
import '../base/list_expression.dart';
import '../base/map_expression.dart';
import '../base/operator_expression.dart';
import '../base/set_expression.dart';
import '../base/value_expression.dart';
import 'filter_expression.dart';
import 'projection_expression.dart';
import 'sort_expression.dart';

QueryExpression get where => QueryExpression();

ExpressionContent valueToContent(dynamic value) {
  if (value is ExpressionContent) {
    return value;
  } else if (value is MongoDocument) {
    return MapExpression(value);
  } else if (value is List) {
    return ListExpression(value);
  } else if (value is Set) {
    return SetExpression(value);
  } else if (value is QueryExpression) {
    return value.filter;
  }
  return ValueExpression.create(value);
}

class QueryExpression {
  static final RegExp objectIdRegexp = RegExp('.ObjectId...([0-9a-f]{24})....');

  FilterExpression filter = FilterExpression();
  QueryFilter get rawFilter => filter.build();

  SortExpression sortExp = SortExpression();
  ProjectionExpression fields = ProjectionExpression();
  int _skip = 0;
  int _limit = 0;

  /// Returns a Json version of the filter
  String getQueryString() => json.encode(filter.build());

  /// Inserts a raw document as filter
  void raw(MongoDocument document) => filter.addDocument(document);

  // ***************************************************
  // ***************** Parenthesis
  // ***************************************************
  void get open => filter.open;
  void get close => filter.close;

  // ***************************************************
  // ***************** Comparison Operators
  // ***************************************************

  /// Matches values that are equal to a specified value.
  void $eq(String fieldName, value) => filter.$eq(fieldName, value);

  void id(value) => $eq(field_id, value);

  /// Matches values that are greater than a specified value.
  void $gt(String fieldName, value) => filter.$gt(fieldName, value);

  /// Matches values that are greater than or equal to a specified value.
  void $gte(String fieldName, value) => filter.$gte(fieldName, value);

  /// Matches any of the values specified in an array.
  void $in(String fieldName, List values) => filter.$in(fieldName, values);

  /// Matches values that are less than a specified value.
  void $lt(String fieldName, value) => filter.$lt(fieldName, value);

  /// Matches values that are less than or equal to a specified value.
  void $lte(String fieldName, value) => filter.$lte(fieldName, value);

  /// Matches all values that are not equal to a specified value.
  void $ne(String fieldName, value) => filter.$ne(fieldName, value);

  /// Matches none of the values specified in an array.
  void $nin(String fieldName, List values) => filter.$nin(fieldName, values);

  // ***************************************************
  // ***************** Logical Operators
  // ***************************************************

  /// $and performs a logical AND operation and selects the documents that
  /// satisfy all the expressions.
  void get $and => filter.logicAnd();

  /// $not Inverts the effect of a query expression and returns documents
  /// that do not match the query expression.
  void $not(OperatorExpression operatorExp) => filter.logicNot(operatorExp);

  /// $nor performs a logical NOR operation on an array of one or
  /// more query expression and selects the documents that fail all the
  /// query expressions in the array.
  void get $nor => filter.logicNor();

  /// $or operator performs a logical OR operation on an array of one or
  /// more expressions and selects the documents that satisfy at least one
  /// of the expressions.
  void get $or => filter.logicOr();

  // ***************************************************
  // ***************** Element Query Operators
  // ***************************************************

  /// $exists matches the documents that contain the field,
  /// including documents where the field value is null.
  void $exists(String fieldName) => filter.$exists(fieldName);

  ///  notExist reTurns only the documents that do not contain the field.
  void notExists(String fieldName) => filter.notExists(fieldName);

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
  void $type(String fieldName, List types) => filter.$type(fieldName, types);

  // ***************************************************
  // ***************** Evaluation Query Operators
  // ***************************************************

  void $expr(OperatorExpression aggregationExpression) =>
      filter.$expr(aggregationExpression);

  /// The $jsonSchema operator matches documents that satisfy the
  /// specified JSON Schema.
  // TODO check if String or Map are required
  void $jsonSchema(String schemaObject) => filter.$jsonSchema(schemaObject);

  /// Select documents where the value of a field divided by a divisor
  /// has the specified remainder (i.e. perform a modulo operation to
  /// select documents).
  /// The reminder defaults to zero
  void $mod(String fieldName, int value, {int reminder = 0}) =>
      filter.$mod(fieldName, value, reminder: reminder);

  /// Provides regular expression capabilities for pattern matching
  /// strings in queries. MongoDB uses Perl compatible regular expressions
  /// (i.e. "PCRE" ) version 8.42 with UTF-8 support.
  void $regex(String fieldName, String pattern,
          {bool caseInsensitive = false,
          bool multiLineAnchorMatch = false,
          bool extendedIgnoreWhiteSpace = false,
          bool dotMatchAll = false,
          bool escapePattern = false}) =>
      filter.$regex(fieldName, pattern,
          caseInsensitive: caseInsensitive,
          multiLineAnchorMatch: multiLineAnchorMatch,
          extendedIgnoreWhiteSpace: extendedIgnoreWhiteSpace,
          dotMatchAll: dotMatchAll,
          escapePattern: escapePattern);

  void $text(String search,
          {String? language, bool? caseSensitive, bool? diacriticSensitive}) =>
      filter.$text(search,
          language: language,
          caseSensitive: caseSensitive,
          diacriticSensitive: diacriticSensitive);

  /// Use the $where operator to pass either a string containing a JavaScript
  /// expression or a full JavaScript function to the query system.
  /// The $where provides greater flexibility, but requires that the database
  /// processes the JavaScript expression or function for each document
  /// in the collection.
  /// Reference the document in the JavaScript expression or function
  /// using either this or obj .
  void $where(String function) => filter.$where(function);

  // ***************************************************
  // ***************** Geo Spatial
  // ***************************************************

  /// Geospatial operators return data based on geospatial expression conditions
  void $geoIntersects(String fieldName, Geometry geometry) =>
      filter.$geoIntersects(fieldName, geometry);

  /// Selects documents with geospatial data that exists entirely
  /// within a specified shape.
  /// Only support GeoShape
  /// Available ShapeOperator instances: Box , Center, CenterSphere, Geometry
  void $geoWithin(String fieldName, GeoShape shape) =>
      filter.$geoWithin(fieldName, shape);

  /// Specifies a point for which a geospatial query returns the documents
  /// from nearest to farthest.
  void $near(String fieldName, var value,
      {double? maxDistance, double? minDistance}) {
    filter.$near(fieldName, value,
        maxDistance: maxDistance, minDistance: minDistance);
  }

  /// Specifies a point for which a geospatial query returns the documents
  /// from nearest to farthest.
  /// Only support geometry of point
  void $nearSphere(String fieldName, GeoPoint point,
          {double? maxDistance, double? minDistance}) =>
      filter.$nearSphere(fieldName, point,
          maxDistance: maxDistance, minDistance: minDistance);

  // ***************************************************
  // ***************** Array Query Operator
  // ***************************************************

  /// The $all operator selects the documents where the value of a field is
  /// an array that contains all the specified elements.
  void $all(String fieldName, List values) => filter.$all(fieldName, values);

  /// The $elemMatch operator matches documents that contain an array
  /// field with at least one element that matches all the specified query criteria.
  void $elemMatch(String fieldName, List values) =>
      filter.$elemMatch(fieldName, values);

  void $size(String fieldName, int numElements) =>
      filter.$size(fieldName, numElements);

  void inRange(String fieldName, min, max,
          {bool minInclude = true, bool maxInclude = false}) =>
      filter.inRange(fieldName, min, max,
          minInclude: minInclude, maxInclude: maxInclude);

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
  void $bitsAllClear(String fieldName, bitMask) =>
      filter.$bitsAllClear(fieldName, bitMask);

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
  void $bitsAllSet(String fieldName, bitMask) =>
      filter.$bitsAllSet(fieldName, bitMask);

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
  void $bitsAnyClear(String fieldName, bitMask) =>
      filter.$bitsAnyClear(fieldName, bitMask);

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
  void $bitsAnySet(String fieldName, bitMask) =>
      filter.$bitsAnySet(fieldName, bitMask);

  // ***************************************************
  // **************    Miscellaneous query operators
  // ***************************************************

  /// The $comment query operator associates a comment to any expression
  /// taking a query predicate.
  void $comment(String commentStr) => filter.$comment(commentStr);

  /// $rand returns a random float between 0 and 1.
  void $rand() => filter.$rand();

  /// Use in conjunction with cursor.hint() to perform a collection scan to
  /// return documents in natural order.
  ///
  /// For usage, see Force Collection Scans example in the cursor.hint()
  /// reference page.
  ///
  /// You can specify a $natural sort when running a find operation against a
  /// view.
  void $ranatura({bool ascending = true}) =>
      filter.$natural(ascending: ascending);

  // ***************************************************
  // **************         Sort          **************
  // ***************************************************

  void sortBy(Object field) => sortExp.sortBy(field);

  // ***************************************************
  // **************        Project        **************
  // ***************************************************

  void selectMetaTextScore(String fieldName) =>
      fields.selectMetaTextScore(fieldName);

  void selectFields(List<String> fieldList) => fields.selectFields(fieldList);

  void excludeFields(List<String> fieldList) => excludeFields(fieldList);

  // ***************************************************
  // **************        Limit         **************
  // ***************************************************
  void limit(int limit) => _limit = limit;
  int getLimit() => _limit;

  // ***************************************************
  // **************         Skip          **************
  // ***************************************************
  void skip(int skip) => _skip = skip;
  int getSkip() => _skip;

  // ***************************************************
  // **************         Copy           **************
  // ***************************************************

  /// Copy to new instance
  static QueryExpression copyWith(QueryExpression other) {
    return QueryExpression()
      ..filter.addDocument(other.filter.build())
      ..sortExp.addMap(other.sortExp.build())
      ..fields.addMap(other.fields.build())
      ..limit(other.getLimit())
      ..skip(other.getSkip());
  }

  /// Duplicate this instance
  QueryExpression clone() => copyWith(this);

  // *************************
  // ************** CHECK

  // TODO revert after debug
  //@override
  //String toString() => 'QueryExpresion($filter.raw)';

  /*  void _addExpression(String fieldName, value) {
    var exprMap = emptyMongoDocument;
    exprMap[fieldName] = value;
    if (rawFilter.isEmpty) {
      rawFilter[fieldName] = value;
    } else {
      _addExpressionMap(exprMap);
    }
  } */

  void _addExpressionMap(Map<String, dynamic> expr) {
    if (rawFilter.containsKey('\$and')) {
      var expressions = rawFilter['\$and'] as List;
      expressions.add(expr);
    } else {
      var expressions = [rawFilter];
      expressions.add(expr);
      filter.build()['\$query'] = {'\$and': expressions};
    }
  }

  void explain() {
    rawFilter;
    filter.build()['\$explain'] = true;
  }

  void snapshot() {
    rawFilter;
    filter.build()['\$snapshot'] = true;
  }

  void showDiskLoc() {
    rawFilter;
    filter.build()['\$showDiskLoc'] = true;
  }

  void returnKey() {
    rawFilter;
    filter.build()['\$sreturnKey'] = true;
  }

  void jsQuery(String javaScriptCode) =>
      rawFilter['\$where'] = JsCode(javaScriptCode);
}
