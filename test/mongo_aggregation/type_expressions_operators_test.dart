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
            .build(),
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
    expect(ToBool(TestExpr()).build(), {'\$toBool': '\$field'});
  });

  test('toDecimal', () {
    expect(ToDecimal(TestExpr()).build(), {'\$toDecimal': '\$field'});
  });

  test('toDouble', () {
    expect(ToDouble(TestExpr()).build(), {'\$toDouble': '\$field'});
  });

  test('toInt', () {
    expect(ToInt(TestExpr()).build(), {'\$toInt': '\$field'});
  });

  test('toLong', () {
    expect(ToLong(TestExpr()).build(), {'\$toLong': '\$field'});
  });

  test('toObjectId', () {
    expect(ToObjectId(TestExpr()).build(), {'\$toObjectId': '\$field'});
  });

  test('type', () {
    expect(Type(TestExpr()).build(), {'\$type': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  String build() => '\$field';

  @override
  // TODO: implement rawContent
  get rawContent => throw UnimplementedError();
}
