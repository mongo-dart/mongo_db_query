import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/abstract/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('cmp', () {
    expect($cmp(TestExpr(), 5).build(), {
      '\$cmp': ['\$field', 5]
    });
  });

  test('eq', () {
    expect($eq(TestExpr(), 5).build(), {
      '\$eq': ['\$field', 5]
    });
  });

  test('gt', () {
    expect($gt(TestExpr(), 5).build(), {
      '\$gt': ['\$field', 5]
    });
  });

  test('gte', () {
    expect($gte(TestExpr(), 5).build(), {
      '\$gte': ['\$field', 5]
    });
  });

  test('lt', () {
    expect($lt(TestExpr(), 5).build(), {
      '\$lt': ['\$field', 5]
    });
  });

  test('lte', () {
    expect($lte(TestExpr(), 5).build(), {
      '\$lte': ['\$field', 5]
    });
  });

  test('ne', () {
    expect($ne(TestExpr(), 5).build(), {
      '\$ne': ['\$field', 5]
    });
  });

  test('cond', () {
    expect(
        $cond(ifExpr: TestExpr(), thenExpr: TestExpr(), elseExpr: TestExpr())
            .build(),
        {
          '\$cond': ['\$field', '\$field', '\$field']
        });
  });

  test('ifNull', () {
    expect($ifNull(TestExpr(), 'replacement').build(), {
      '\$ifNull': ['\$field', 'replacement']
    });
  });

  test('switch', () {
    expect(
        $switch(
                branches: [Case(caseExpr: TestExpr(), thenExpr: 'expr')],
                defaultExpr: 'default')
            .build(),
        {
          '\$switch': {
            'branches': [
              {'case': '\$field', 'then': 'expr'}
            ],
            'default': 'default'
          }
        });
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
