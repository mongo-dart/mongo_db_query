import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('cmp', () {
    expect($cmp(TestExpr(), 5).rawContent, {
      '\$cmp': ['\$field', 5]
    });
  });

  test('eq', () {
    expect($eq(TestExpr(), 5).rawContent, {
      '\$eq': ['\$field', 5]
    });
  });

  test('gt', () {
    expect($gt(TestExpr(), 5).rawContent, {
      '\$gt': ['\$field', 5]
    });
  });

  test('gte', () {
    expect($gte(TestExpr(), 5).rawContent, {
      '\$gte': ['\$field', 5]
    });
  });

  test('lt', () {
    expect($lt(TestExpr(), 5).rawContent, {
      '\$lt': ['\$field', 5]
    });
  });

  test('lte', () {
    expect($lte(TestExpr(), 5).rawContent, {
      '\$lte': ['\$field', 5]
    });
  });

  test('ne', () {
    expect($ne(TestExpr(), 5).rawContent, {
      '\$ne': ['\$field', 5]
    });
  });

  test('cond', () {
    expect(
        $cond(ifExpr: TestExpr(), thenExpr: TestExpr(), elseExpr: TestExpr())
            .rawContent,
        {
          '\$cond': ['\$field', '\$field', '\$field']
        });
  });

  test('ifNull', () {
    expect($ifNull(TestExpr(), 'replacement').rawContent, {
      '\$ifNull': ['\$field', 'replacement']
    });
  });

  test('switch', () {
    expect(
        $switch(
                branches: [$case(caseExpr: TestExpr(), thenExpr: 'expr')],
                defaultExpr: 'default')
            .rawContent,
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
