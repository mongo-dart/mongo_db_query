import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('addToSet', () {
    expect(AddToSet(TestExpr()).rawContent, {'\$addToSet': '\$field'});
  });

  test('avg', () {
    expect(Avg(TestExpr()).rawContent, {'\$avg': '\$field'});
    expect(Avg([TestExpr(), 2]).rawContent, {
      '\$avg': ['\$field', 2]
    });
  });

  test('first', () {
    expect(First(TestExpr()).rawContent, {'\$first': '\$field'});
  });

  test('last', () {
    expect(Last(TestExpr()).rawContent, {'\$last': '\$field'});
  });

  test('max', () {
    expect(Max(TestExpr()).rawContent, {'\$max': '\$field'});
    expect(Max([TestExpr(), 2]).rawContent, {
      '\$max': ['\$field', 2]
    });
  });

  test('min', () {
    expect(Min(TestExpr()).rawContent, {'\$min': '\$field'});
    expect(Min([TestExpr(), 2]).rawContent, {
      '\$min': ['\$field', 2]
    });
  });

  test('push', () {
    expect(Push(TestExpr()).rawContent, {'\$push': '\$field'});
    expect(Push.list([TestExpr(), 1]).rawContent, {
      '\$push': ['\$field', 1]
    });
    expect(Push.object({'field': TestExpr(), 'num': 1}).rawContent, {
      '\$push': {'field': '\$field', 'num': 1}
    });
  });

  test('stdDevPop', () {
    expect(StdDevPop(TestExpr()).rawContent, {'\$stdDevPop': '\$field'});
    expect(StdDevPop([TestExpr(), 2]).rawContent, {
      '\$stdDevPop': ['\$field', 2]
    });
  });

  test('stdDevSamp', () {
    expect(StdDevSamp(TestExpr()).rawContent, {'\$stdDevSamp': '\$field'});
    expect(StdDevSamp([TestExpr(), 2]).rawContent, {
      '\$stdDevSamp': ['\$field', 2]
    });
  });

  test('sum', () {
    expect(Sum(TestExpr()).rawContent, {'\$sum': '\$field'});
    expect(Sum([TestExpr(), 2]).rawContent, {
      '\$sum': ['\$field', 2]
    });
  });
}

class TestExpr implements ExpressionContent {
  @override
  String build() => '\$field';

  @override
  get rawContent => '\$field';
}
