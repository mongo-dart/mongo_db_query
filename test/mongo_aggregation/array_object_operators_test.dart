import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:test/test.dart';

void main() {
  test('arrayToObjects', () {
    expect($arrayToObject(Field('products')).build(),
        {'\$arrayToObject': '\$products'});
    expect(
        $arrayToObject([
          ['item', 'abc123'],
          ['qty', 25]
        ]).build(),
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
        ]).build(),
        {
          '\$arrayToObject': [
            {'k': 'item', 'v': 'abc123'},
            {'k': 'qty', 'v': 25}
          ]
        });
  });

  test('arrayElemAt', () {
    expect($arrayElemAt(TestExpr(), 0).build(), {
      '\$arrayElemAt': ['\$field', 0]
    });
    expect($arrayElemAt([1, 2, 3], 1).build(), {
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
        ]).build(),
        {
          '\$concatArrays': [
            '\$field',
            [1, 2]
          ]
        });
  });

  test('filter', () {
    expect($filter(input: TestExpr(), as: 'test', cond: TestExpr()).build(), {
      '\$filter': {'input': '\$field', 'as': 'test', 'cond': '\$field'}
    });
  });

  test('in', () {
    expect($in(TestExpr(), TestExpr()).build(), {
      '\$in': ['\$field', '\$field']
    });
    expect($in('string', ['string', TestExpr()]).build(), {
      '\$in': [
        'string',
        ['string', '\$field']
      ]
    });
  });

  test('indexOfArray', () {
    expect($indexOfArray(TestExpr(), TestExpr(), 2, 3).build(), {
      '\$indexOfArray': ['\$field', '\$field', 2, 3]
    });
    expect($indexOfArray([1, 2, TestExpr()], 'value', 2, 3).build(), {
      '\$indexOfArray': [
        [1, 2, '\$field'],
        'value',
        2,
        3
      ]
    });
  });

  test('isArray', () {
    expect($isArray(TestExpr()).build(), {'\$isArray': '\$field'});
  });

  test('map', () {
    expect($map(input: TestExpr(), as: 'val', inExpr: TestExpr()).build(), {
      '\$map': {'input': '\$field', 'as': 'val', 'in': '\$field'}
    });
  });

  test('range', () {
    expect($range(1, TestExpr(), 2).build(), {
      '\$range': [1, '\$field', 2]
    });
  });

  test('reduce', () {
    expect(
        $reduce(input: TestExpr(), initialValue: 0, inExpr: TestExpr()).build(),
        {
          '\$reduce': {'input': '\$field', 'initialValue': 0, 'in': '\$field'}
        });
  });

  test('reverseArray', () {
    expect($reverseArray(TestExpr()).build(), {'\$reverseArray': '\$field'});
    expect($reverseArray([1, 2, TestExpr()]).build(), {
      '\$reverseArray': [1, 2, '\$field']
    });
  });

  test('slice', () {
    expect($slice(TestExpr(), 5, 2).build(), {
      '\$slice': ['\$field', 2, 5]
    });
    expect($slice([1, TestExpr()], 5, 2).build(), {
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
            defaults: ['a', 'b']).build(),
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
    expect(
        $objectToArray(Field('order')).build(), {'\$objectToArray': '\$order'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
