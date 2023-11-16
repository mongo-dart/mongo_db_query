import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('convert', () {
    expect(
        Convert(
                input: TestExpr(),
                to: 'string',
                onError: TestExpr(),
                onNull: TestExpr())
            .rawContent,
        {
          '\$convert': {
            'input': '\$field',
            'to': 'string',
            'onError': '\$field',
            'onNull': '\$field'
          }
        });
  });

  test('toBool', () {
    expect(ToBool(TestExpr()).rawContent, {'\$toBool': '\$field'});
  });

  test('toDecimal', () {
    expect(ToDecimal(TestExpr()).rawContent, {'\$toDecimal': '\$field'});
  });

  test('toDouble', () {
    expect(ToDouble(TestExpr()).rawContent, {'\$toDouble': '\$field'});
  });

  test('toInt', () {
    expect(ToInt(TestExpr()).rawContent, {'\$toInt': '\$field'});
  });

  test('toLong', () {
    expect(ToLong(TestExpr()).rawContent, {'\$toLong': '\$field'});
  });

  test('toObjectId', () {
    expect(ToObjectId(TestExpr()).rawContent, {'\$toObjectId': '\$field'});
  });

  test('type', () {
    expect(Type(TestExpr()).rawContent, {'\$type': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  String build() => '\$field';

  @override
  get rawContent => '\$field';
}
