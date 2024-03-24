library test_lib;

import 'package:test/test.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

void main() {
  group('Filter Expression', () {
    group('Comparison Operators', () {
      test(r'$eq', () {
        var filter = FilterExpression()..$eq('a', 995);
        expect(
            filter.build(),
            equals({
              'a': {r'$eq': 995}
            }));
        filter = FilterExpression()
          ..$eq('a', 7.0)
          ..$eq('b', 3);
        expect(
            filter.build(),
            equals({
              'a': {r'$eq': 7.0},
              'b': {r'$eq': 3}
            }));
      });
    });
  });
}
