import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('arrayToObjects', () {
    expect(ArrayToObject(Field('products')).rawContent,
        {'\$arrayToObject': '\$products'});
    expect(
        ArrayToObject([
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
        ArrayToObject([
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
    expect(ArrayElemAt(TestExpr(), 0).rawContent, {
      '\$arrayElemAt': ['\$field', 0]
    });
    expect(ArrayElemAt([1, 2, 3], 1).rawContent, {
      '\$arrayElemAt': [
        [1, 2, 3],
        1
      ]
    });
  });

  test('concatArrays', () {
    expect(
        ConcatArrays([
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
    expect(Filter(input: TestExpr(), as: 'test', cond: TestExpr()).rawContent, {
      '\$filter': {'input': '\$field', 'as': 'test', 'cond': '\$field'}
    });
  });

  test('in', () {
    expect(In(TestExpr(), TestExpr()).rawContent, {
      '\$in': ['\$field', '\$field']
    });
    expect(In('string', ['string', TestExpr()]).rawContent, {
      '\$in': [
        'string',
        ['string', '\$field']
      ]
    });
  });

  test('indexOfArray', () {
    expect(IndexOfArray(TestExpr(), TestExpr(), 2, 3).rawContent, {
      '\$indexOfArray': ['\$field', '\$field', 2, 3]
    });
    expect(IndexOfArray([1, 2, TestExpr()], 'value', 2, 3).rawContent, {
      '\$indexOfArray': [
        [1, 2, '\$field'],
        'value',
        2,
        3
      ]
    });
  });

  test('isArray', () {
    expect(IsArray(TestExpr()).rawContent, {'\$isArray': '\$field'});
  });

  test('map', () {
    expect(MapOp(input: TestExpr(), as: 'val', inExpr: TestExpr()).rawContent, {
      '\$map': {'input': '\$field', 'as': 'val', 'in': '\$field'}
    });
  });

  test('range', () {
    expect(Range(1, TestExpr(), 2).rawContent, {
      '\$range': [1, '\$field', 2]
    });
  });

  test('reduce', () {
    expect(
        Reduce(input: TestExpr(), initialValue: 0, inExpr: TestExpr())
            .rawContent,
        {
          '\$reduce': {'input': '\$field', 'initialValue': 0, 'in': '\$field'}
        });
  });

  test('reverseArray', () {
    expect(ReverseArray(TestExpr()).rawContent, {'\$reverseArray': '\$field'});
    expect(ReverseArray([1, 2, TestExpr()]).rawContent, {
      '\$reverseArray': [1, 2, '\$field']
    });
  });

  test('slice', () {
    expect(Slice(TestExpr(), 5, 2).rawContent, {
      '\$slice': ['\$field', 2, 5]
    });
    expect(Slice([1, TestExpr()], 5, 2).rawContent, {
      '\$slice': [
        [1, '\$field'],
        2,
        5
      ]
    });
  });

  test('zip', () {
    expect(
        Zip(
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
    expect(ObjectToArray(Field('order')).rawContent,
        {'\$objectToArray': '\$order'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
