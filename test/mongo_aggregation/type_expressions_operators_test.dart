import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('convert', () {
    expect(
        $convert(
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
    expect($toBool(TestExpr()).rawContent, {'\$toBool': '\$field'});
  });

  test('toDecimal', () {
    expect($toDecimal(TestExpr()).rawContent, {'\$toDecimal': '\$field'});
  });

  test('toDouble', () {
    expect($toDouble(TestExpr()).rawContent, {'\$toDouble': '\$field'});
  });

  test('toInt', () {
    expect($toInt(TestExpr()).rawContent, {'\$toInt': '\$field'});
  });

  test('toLong', () {
    expect($toLong(TestExpr()).rawContent, {'\$toLong': '\$field'});
  });

  test('toObjectId', () {
    expect($toObjectId(TestExpr()).rawContent, {'\$toObjectId': '\$field'});
  });

  test('type', () {
    expect($type(TestExpr()).rawContent, {'\$type': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
