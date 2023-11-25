import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:test/test.dart';

void main() {
  test('field', () {
    expect(Field('field').rawContent, '\$field');
  });

  test('literal', () {
    expect(Literal('\$value').rawContent, {'\$literal': '\$value'});
  });

  test('variable', () {
    expect(Var('variable').rawContent, '\$\$variable');
  });

  test('system variables', () {
    expect(Var.now.rawContent, '\$\$NOW');
    expect(Var.clusterTime.rawContent, '\$\$CLUSTER_TIME');
    expect(Var.root.rawContent, '\$\$ROOT');
    expect(Var.current.rawContent, '\$\$CURRENT');
    expect(Var.remove.rawContent, '\$\$REMOVE');
    expect(Var.discend.rawContent, '\$\$DISCEND');
    expect(Var.prune.rawContent, '\$\$PRUNE');
    expect(Var.keep.rawContent, '\$\$KEEP');
  });

  test('valueToContent filter null elements', () {
    expect(valueToContent([1, 'string', null, 2]).rawContent,
        containsAllInOrder([1, 'string', 2]));
  });

  test('valueToContent filter null values in Map', () {
    expect(
        valueToContent({'num': 1, 'string': 'value', 'null': null, 'two': 2})
            .rawContent,
        {'num': 1, 'string': 'value', 'two': 2});
  });

  test('valueToContent#rawContet', () {
    expect(valueToContent([1, TestExpr(), 'string']).rawContent,
        containsAllInOrder([1, 'test', 'string']));
  });

  test('valueToContent#rawContet in Map', () {
    expect(
        valueToContent({'num': 1, 'expr': TestExpr(), 'string': 'value'})
            .rawContent,
        {'num': 1, 'expr': 'test', 'string': 'value'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  String get rawContent => 'test';
}
