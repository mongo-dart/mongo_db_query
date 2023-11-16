import 'package:mongo_db_query/src/aggregation/ae_list.dart';
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

  test('AEList filter null elements', () {
    expect(AEList([1, 'string', null, 2]).build(),
        containsAllInOrder([1, 'string', 2]));
  });

  test('AEObject filter null values', () {
    expect(
        AEObject({'num': 1, 'string': 'value', 'null': null, 'two': 2}).build(),
        {'num': 1, 'string': 'value', 'two': 2});
  });

  test('AElist#build', () {
    expect(AEList([1, TestExpr(), 'string']).build(),
        containsAllInOrder([1, 'test', 'string']));
  });

  test('AEObject#build', () {
    expect(AEObject({'num': 1, 'expr': TestExpr(), 'string': 'value'}).build(),
        {'num': 1, 'expr': 'test', 'string': 'value'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  String get rawContent => 'test';

  @override
  dynamic build() => rawContent;
}
