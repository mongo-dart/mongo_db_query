import 'package:mongo_db_query/src/aggregation/atlas_operator_collector.dart';
import 'package:test/test.dart';

void main() {
  group('Atlas operator', () {
    test('autocomplete', () {
      expect(Autocomplete('off', 'title').build(), {
        "autocomplete": {'path': 'title', 'query': 'off'}
      });
      expect(
          Autocomplete('pre', 'title',
                  fuzzy:
                      Fuzzy(maxEdits: 1, prefixLength: 1, maxExpansions: 256))
              .build(),
          {
            "autocomplete": {
              "path": "title",
              "query": "pre",
              "fuzzy": {"maxEdits": 1, "prefixLength": 1, "maxExpansions": 256}
            }
          });
    });
    test('compound', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('embedded documents', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('equals', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('exists', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('geo shape', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('geo within', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('in', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('more like this', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('near', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('phrase', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('query string', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('range', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('regex', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('text', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
    test('wildcard', () {
      //expect($expr(TestExpr()).build(), {'\$expr': '\$field'});
    });
  });
}
