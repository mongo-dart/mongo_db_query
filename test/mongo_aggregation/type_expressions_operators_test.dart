import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/abstract/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('convert', () {
    expect(
        $convert(
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
    expect($toBool(TestExpr()).build(), {'\$toBool': '\$field'});
  });

  test('toDecimal', () {
    expect($toDecimal(TestExpr()).build(), {'\$toDecimal': '\$field'});
  });

  test('toDouble', () {
    expect($toDouble(TestExpr()).build(), {'\$toDouble': '\$field'});
  });

  test('toInt', () {
    expect($toInt(TestExpr()).build(), {'\$toInt': '\$field'});
  });

  test('toLong', () {
    expect($toLong(TestExpr()).build(), {'\$toLong': '\$field'});
  });

  test('toObjectId', () {
    expect($toObjectId(TestExpr()).build(), {'\$toObjectId': '\$field'});
  });

  test('type', () {
    expect($type(TestExpr()).build(), {'\$type': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
