import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('expr', () {
    expect(Expr(TestExpr()).build(), {'\$expr': '\$field'});
  });

  test('let', () {
    expect(Let(vars: {'var': TestExpr()}, inExpr: TestExpr()).build(), {
      '\$let': {
        'vars': {'var': '\$field'},
        'in': '\$field'
      }
    });
  });
}

class TestExpr implements ExpressionContent {
  @override
  String build() => '\$field';

  @override
  // TODO: implement rawContent
  get rawContent => throw UnimplementedError();
}
