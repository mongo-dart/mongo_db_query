import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('expr', () {
    expect($expr(TestExpr()).rawContent, {'\$expr': '\$field'});
  });

  test('let', () {
    expect($let(vars: {'var': TestExpr()}, inExpr: TestExpr()).rawContent, {
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
