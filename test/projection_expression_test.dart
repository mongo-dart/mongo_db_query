library test_lib;

import 'package:test/test.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

void main() {
  group('Projection Expression', () {
    group('Projection Operators', () {
      test(r'$', () {
        var projection = ProjectionExpression()..$('grades');
        expect(projection.build(), equals({r'grades.$': 1}));
      });
      test(r'$elemMatch', () {
        var projection = ProjectionExpression()
          ..$elemMatch('games', FilterExpression()..$gt('score', 5));
        expect(
            projection.build(),
            equals({
              'games': {
                r'$elemMatch': {
                  'score': {r'$gt': 5}
                }
              }
            }));
        projection = ProjectionExpression()
          ..$elemMatch(
              'students',
              FilterExpression()
                ..$eq('school', 5)
                ..$gt('age', 10));
        expect(projection.build(), {
          'students': {
            r'$elemMatch': {
              'school': {r'$eq': 5},
              'age': {r'$gt': 10}
            }
          }
        });
      });
      test(r'$slice', () {
        var projection = ProjectionExpression()..$slice(r'instock.$', 1);
        expect(
            projection.build(),
            equals({
              r'instock.$': {r'$slice': 1}
            }));
        projection = ProjectionExpression()
          ..$slice(r'comments', -1, elementsToSkip: 3);
        expect(
            projection.build(),
            equals({
              'comments': {
                r'$slice': [-1, 3]
              }
            }));
      });
    });
  });
}
