import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('cmp', () {
    expect(Cmp(TestExpr(), 5).rawContent, {
      '\$cmp': ['\$field', 5]
    });
  });

  test('eq', () {
    expect(Eq(TestExpr(), 5).rawContent, {
      '\$eq': ['\$field', 5]
    });
  });

  test('gt', () {
    expect(Gt(TestExpr(), 5).rawContent, {
      '\$gt': ['\$field', 5]
    });
  });

  test('gte', () {
    expect(Gte(TestExpr(), 5).rawContent, {
      '\$gte': ['\$field', 5]
    });
  });

  test('lt', () {
    expect(Lt(TestExpr(), 5).rawContent, {
      '\$lt': ['\$field', 5]
    });
  });

  test('lte', () {
    expect(Lte(TestExpr(), 5).rawContent, {
      '\$lte': ['\$field', 5]
    });
  });

  test('ne', () {
    expect(Ne(TestExpr(), 5).rawContent, {
      '\$ne': ['\$field', 5]
    });
  });

  test('cond', () {
    expect(
        Cond(ifExpr: TestExpr(), thenExpr: TestExpr(), elseExpr: TestExpr())
            .rawContent,
        {
          '\$cond': ['\$field', '\$field', '\$field']
        });
  });

  test('ifNull', () {
    expect(IfNull(TestExpr(), 'replacement').rawContent, {
      '\$ifNull': ['\$field', 'replacement']
    });
  });

  test('switch', () {
    expect(
        Switch(
                branches: [Case(caseExpr: TestExpr(), thenExpr: 'expr')],
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
  String build() => '\$field';

  @override
  get rawContent => '\$field';
}
