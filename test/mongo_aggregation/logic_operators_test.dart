import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('and', () {
    expect($and([TestExpr(), false]).rawContent, {
      '\$and': ['\$field', false]
    });
  });

  test('or', () {
    expect($or([TestExpr(), false]).rawContent, {
      '\$or': ['\$field', false]
    });
  });

  test('not', () {
    expect($not(TestExpr()).rawContent, {'\$not': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
