import 'package:mongo_db_query/src/aggregation/atlas/options/embedded.dart';
import 'package:mongo_db_query/src/aggregation/atlas/options/score_modify.dart';
import 'package:mongo_db_query/src/aggregation/atlas_operator_collector.dart';
import 'package:mongo_db_query/src/aggregation/base/atlas_score_options.dart';
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
      expect(
          Compound(filter: [
            QueryString(defaultPath: 'role', query: 'CLIENT OR PROFESSIONAL')
          ]).build(),
          {
            "compound": {
              "filter": [
                {
                  'queryString': {
                    'defaultPath': 'role',
                    'query': 'CLIENT OR PROFESSIONAL'
                  }
                }
              ]
            }
          });
      expect(
          Compound(
              must: [Text(path: 'description', query: 'varieties')],
              mustNot: [Text(path: 'description', query: 'apples')]).build(),
          {
            "compound": {
              "must": [
                {
                  "text": {"query": "varieties", "path": "description"}
                }
              ],
              "mustNot": [
                {
                  "text": {"query": "apples", "path": "description"}
                }
              ]
            }
          });
    });
    test('embedded documents', () {
      expect(
          EmbeddedDocument(
                  path: 'items',
                  operator: Compound(
                      must: [Text(path: 'items.tags', query: 'school')],
                      should: [Text(path: 'items.name', query: 'backpack')]),
                  score: ScoreModify(scoreOption: Embedded(aggregate: 'mean')))
              .build(),
          {
            "embeddedDocument": {
              'path': 'items',
              'operator': {
                'compound': {
                  'must': [
                    {
                      'text': {'path': 'items.tags', 'query': 'school'}
                    }
                  ],
                  'should': [
                    {
                      'text': {'path': 'items.name', 'query': 'backpack'}
                    }
                  ]
                }
              },
              'score': {
                'embedded': {'aggregate': 'mean'}
              }
            }
          });
    });
    test('equals', () {
      expect(Equals(path: 'verified_user', value: true).build(), {
        "equals": {'path': 'verified_user', 'value': true}
      });
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
