import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('arrayToObjects', () {
    expect($arrayToObject(Field('products')).rawContent,
        {'\$arrayToObject': '\$products'});
    expect(
        $arrayToObject([
          ['item', 'abc123'],
          ['qty', 25]
        ]).rawContent,
        {
          '\$arrayToObject': [
            ['item', 'abc123'],
            ['qty', 25]
          ]
        });
    expect(
        $arrayToObject([
          {'k': 'item', 'v': 'abc123'},
          {'k': 'qty', 'v': 25}
        ]).rawContent,
        {
          '\$arrayToObject': [
            {'k': 'item', 'v': 'abc123'},
            {'k': 'qty', 'v': 25}
          ]
        });
  });

  test('arrayElemAt', () {
    expect($arrayElemAt(TestExpr(), 0).rawContent, {
      '\$arrayElemAt': ['\$field', 0]
    });
    expect($arrayElemAt([1, 2, 3], 1).rawContent, {
      '\$arrayElemAt': [
        [1, 2, 3],
        1
      ]
    });
  });

  test('concatArrays', () {
    expect(
        $concatArrays([
          TestExpr(),
          [1, 2]
        ]).rawContent,
        {
          '\$concatArrays': [
            '\$field',
            [1, 2]
          ]
        });
  });

  test('filter', () {
    expect(
        $filter(input: TestExpr(), as: 'test', cond: TestExpr()).rawContent, {
      '\$filter': {'input': '\$field', 'as': 'test', 'cond': '\$field'}
    });
  });

  test('in', () {
    expect($in(TestExpr(), TestExpr()).rawContent, {
      '\$in': ['\$field', '\$field']
    });
    expect($in('string', ['string', TestExpr()]).rawContent, {
      '\$in': [
        'string',
        ['string', '\$field']
      ]
    });
  });

  test('indexOfArray', () {
    expect($indexOfArray(TestExpr(), TestExpr(), 2, 3).rawContent, {
      '\$indexOfArray': ['\$field', '\$field', 2, 3]
    });
    expect($indexOfArray([1, 2, TestExpr()], 'value', 2, 3).rawContent, {
      '\$indexOfArray': [
        [1, 2, '\$field'],
        'value',
        2,
        3
      ]
    });
  });

  test('isArray', () {
    expect($isArray(TestExpr()).rawContent, {'\$isArray': '\$field'});
  });

  test('map', () {
    expect($map(input: TestExpr(), as: 'val', inExpr: TestExpr()).rawContent, {
      '\$map': {'input': '\$field', 'as': 'val', 'in': '\$field'}
    });
  });

  test('range', () {
    expect($range(1, TestExpr(), 2).rawContent, {
      '\$range': [1, '\$field', 2]
    });
  });

  test('reduce', () {
    expect(
        $reduce(input: TestExpr(), initialValue: 0, inExpr: TestExpr())
            .rawContent,
        {
          '\$reduce': {'input': '\$field', 'initialValue': 0, 'in': '\$field'}
        });
  });

  test('reverseArray', () {
    expect($reverseArray(TestExpr()).rawContent, {'\$reverseArray': '\$field'});
    expect($reverseArray([1, 2, TestExpr()]).rawContent, {
      '\$reverseArray': [1, 2, '\$field']
    });
  });

  test('slice', () {
    expect($slice(TestExpr(), 5, 2).rawContent, {
      '\$slice': ['\$field', 2, 5]
    });
    expect($slice([1, TestExpr()], 5, 2).rawContent, {
      '\$slice': [
        [1, '\$field'],
        2,
        5
      ]
    });
  });

  test('zip', () {
    expect(
        $zip(
            inputs: [
              TestExpr(),
              [1, 2]
            ],
            useLongestLength: true,
            defaults: ['a', 'b']).rawContent,
        {
          '\$zip': {
            'inputs': [
              '\$field',
              [1, 2]
            ],
            'useLongestLength': true,
            'defaults': ['a', 'b']
          }
        });
  });

  test('mergeObjects', () {
    expect($mergeObjects(TestExpr()).build(), {'\$mergeObjects': '\$field'});
    expect(
        $mergeObjects([
          TestExpr(),
          {'a': TestExpr(), 'b': 2}
        ]).build(),
        {
          '\$mergeObjects': [
            '\$field',
            {'a': '\$field', 'b': 2}
          ]
        });
  });

  test('objectToArray', () {
    expect($objectToArray(Field('order')).rawContent,
        {'\$objectToArray': '\$order'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
