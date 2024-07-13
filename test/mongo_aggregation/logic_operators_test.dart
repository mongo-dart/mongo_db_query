import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:test/test.dart';

void main() {
  test('and', () {
    expect($and([TestExpr(), false]).build(), {
      '\$and': ['\$field', false]
    });
  });

  test('or', () {
    expect($or([TestExpr(), false]).build(), {
      '\$or': ['\$field', false]
    });
  });

  test('not', () {
    expect($not(TestExpr()).build(), {'\$not': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
