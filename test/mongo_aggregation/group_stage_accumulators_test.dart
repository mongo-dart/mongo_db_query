import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('addToSet', () {
    expect($addToSet(TestExpr()).build(), {'\$addToSet': '\$field'});
  });

  test('avg', () {
    expect($avg(TestExpr()).build(), {'\$avg': '\$field'});
    expect($avg([TestExpr(), 2]).build(), {
      '\$avg': ['\$field', 2]
    });
  });

  test('first', () {
    expect($first(TestExpr()).build(), {'\$first': '\$field'});
  });

  test('last', () {
    expect($last(TestExpr()).build(), {'\$last': '\$field'});
  });

  test('max', () {
    expect($max(TestExpr()).build(), {'\$max': '\$field'});
    expect($max([TestExpr(), 2]).build(), {
      '\$max': ['\$field', 2]
    });
  });

  test('min', () {
    expect($min(TestExpr()).build(), {'\$min': '\$field'});
    expect($min([TestExpr(), 2]).build(), {
      '\$min': ['\$field', 2]
    });
  });

  test('push', () {
    expect($push(TestExpr()).build(), {'\$push': '\$field'});
    expect($push([TestExpr(), 1]).build(), {
      '\$push': ['\$field', 1]
    });
    expect($push({'field': TestExpr(), 'num': 1}).build(), {
      '\$push': {'field': '\$field', 'num': 1}
    });
  });

  test('stdDevPop', () {
    expect($stdDevPop(TestExpr()).build(), {'\$stdDevPop': '\$field'});
    expect($stdDevPop([TestExpr(), 2]).build(), {
      '\$stdDevPop': ['\$field', 2]
    });
  });

  test('stdDevSamp', () {
    expect($stdDevSamp(TestExpr()).build(), {'\$stdDevSamp': '\$field'});
    expect($stdDevSamp([TestExpr(), 2]).build(), {
      '\$stdDevSamp': ['\$field', 2]
    });
  });

  test('sum', () {
    expect($sum(TestExpr()).build(), {'\$sum': '\$field'});
    expect($sum([TestExpr(), 2]).build(), {
      '\$sum': ['\$field', 2]
    });
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
