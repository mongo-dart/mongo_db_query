import 'package:mongo_db_query/src/aggregation/atlas/expression/add.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/constant.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/gaussian.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/log.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/log1p.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/multiply.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/path.dart';
import 'package:mongo_db_query/src/aggregation/atlas/expression/score.dart';
import 'package:test/test.dart';

void main() {
  group('Atlas expression', () {
    test('add', () {
      expect(Add(expressions: [Path(value: 'rating'), Score()]).build(), {
        'add': [
          {'path': 'rating'},
          {'score': 'relevance'}
        ]
      });
    });
    test('constant', () {
      expect(Constant(constant: -23.78).build(), {"constant": -23.78});
    });
    test('gaussian', () {
      expect(
          Gaussian(
                  path: Path(value: 'rating', undefined: 50),
                  origin: 95,
                  scale: 5,
                  offset: 5,
                  decay: 0.65)
              .build(),
          {
            "gauss": {
              "path": {"value": "rating", "undefined": 50},
              "origin": 95,
              "scale": 5,
              "offset": 5,
              "decay": 0.65
            }
          });
    });
    test('log', () {
      expect(
          Log(
              expression: Multiply(expressions: [
            Path(value: 'popularity'),
            Constant(constant: 0.5),
            Score()
          ])).build(),
          {
            'log': {
              'multiply': [
                {'path': 'popularity'},
                {'constant': 0.5},
                {'score': 'relevance'}
              ]
            }
          });
    });
    test('log1p', () {
      expect(Log1p(expression: Path(value: 'rating', undefined: 4)).build(), {
        'log1p': {
          'path': {'value': 'rating', 'undefined': 4}
        }
      });
    });
    test('multiply', () {
      expect(
          Multiply(expressions: [
            Path(value: 'popularity', undefined: 2.5),
            Score(),
            Constant(constant: 0.75)
          ]).build(),
          {
            'multiply': [
              {
                'path': {'value': 'popularity', 'undefined': 2.5}
              },
              {'score': 'relevance'},
              {"constant": 0.75}
            ]
          });
    });
    test('path', () {
      expect(Path(value: 'quantity', undefined: 2).build(), {
        "path": {'value': 'quantity', 'undefined': 2}
      });
    });
    test('score', () {
      expect(Score().build(), {"score": "relevance"});
    });
  });
}
