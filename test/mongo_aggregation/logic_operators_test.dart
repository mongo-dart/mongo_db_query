import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('and', () {
    expect(And([TestExpr(), false]).build(), {
      '\$and': ['\$field', false]
    });
  });

  test('or', () {
    expect(Or([TestExpr(), false]).build(), {
      '\$or': ['\$field', false]
    });
  });

  test('not', () {
    expect(Not(TestExpr()).build(), {'\$not': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  String build() => '\$field';

  @override
  // TODO: implement rawContent
  get rawContent => throw UnimplementedError();
}
