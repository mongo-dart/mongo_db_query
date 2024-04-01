import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/abstract/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('expr', () {
    expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
  });

  test('let', () {
    expect($let(vars: {'var': TestExpr()}, inExpr: TestExpr()).build(), {
      '\$let': {
        'vars': {'var': '\$field'},
        'in': '\$field'
      }
    });
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
