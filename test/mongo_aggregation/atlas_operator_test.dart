import 'package:bson/bson.dart';
import 'package:test/test.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

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
      expect(Exists(path: 'type').build(), {
        'exists': {'path': 'type'}
      });
    });
    test('geo shape', () {
      expect(
          GeoShape(
                  relation: GeometryRelation.disjoint,
                  geometry: Geometry.polygon([
                    [
                      [-161.323242, 22.512557],
                      [-152.446289, 22.065278],
                      [-156.09375, 17.811456],
                      [-161.323242, 22.512557]
                    ]
                  ]),
                  path: 'address.location')
              .build(),
          {
            'geoShape': {
              'relation': 'disjoint',
              "geometry": {
                'type': 'Polygon',
                'coordinates': [
                  [
                    [-161.323242, 22.512557],
                    [-152.446289, 22.065278],
                    [-156.09375, 17.811456],
                    [-161.323242, 22.512557]
                  ]
                ]
              },
              'path': 'address.location'
            }
          });
    });
    test('geo within', () {
      expect(
          GeoWithin(
                  path: 'address.location',
                  box: Box(GeoPoint.coordinates([112.467, -55.050]),
                      GeoPoint(GeoPosition(168.000, -9.133))))
              .build(),
          {
            'geoWithin': {
              'path': 'address.location',
              'box': {
                'bottomLeft': {
                  'type': 'Point',
                  'coordinates': [112.467, -55.050]
                },
                'topRight': {
                  'type': 'Point',
                  'coordinates': [168.000, -9.133]
                }
              }
            }
          });
    });
    test('in', () {
      expect(
          In(path: 'name', value: ['james sanchez', 'jennifer lawrence'])
              .build(),
          {
            'in': {
              'path': 'name',
              'value': ['james sanchez', 'jennifer lawrence']
            }
          });
    });
    test('more like this', () {
      expect(
          MoreLikeThis(like: [
            {
              '_id': ObjectId.parse('573a1396f29313caabce4a9a'),
              'genres': ['Crime', 'Drama'],
              'title': 'The Godfather'
            }
          ]).build(),
          {
            'moreLikeThis': {
              'like': [
                {
                  '_id': ObjectId.parse('573a1396f29313caabce4a9a'),
                  'genres': ['Crime', 'Drama'],
                  'title': 'The Godfather'
                }
              ]
            }
          });
    });
    test('near', () {
      expect(
          Near(
                  origin: GeoPoint.coordinates([-8.61308, 41.1413]),
                  path: 'address.location',
                  pivot: 1000)
              .build(),
          {
            "near": {
              "origin": {
                "type": "Point",
                "coordinates": [-8.61308, 41.1413]
              },
              'pivot': 1000,
              'path': 'address.location'
            }
          });
    });
    test('phrase', () {
      expect(Phrase(path: 'title', query: 'new york').build(), {
        'phrase': {'path': 'title', 'query': 'new york'}
      });
    });
    test('query string', () {
      expect(
          QueryString(
                  defaultPath: 'plot',
                  query: 'title:"The Italian" AND genres:Drama')
              .build(),
          {
            'queryString': {
              'defaultPath': 'plot',
              'query': 'title:"The Italian" AND genres:Drama'
            }
          });
    });
    test('range', () {
      expect(
          Range(
                  path: 'released',
                  gt: DateTime.parse('2010-01-01T00:00:00.000Z'),
                  lt: DateTime.parse('2015-01-01T00:00:00.000Z'))
              .build(),
          {
            'range': {
              'path': 'released',
              'gt': DateTime.parse('2010-01-01T00:00:00.000Z'),
              'lt': DateTime.parse('2015-01-01T00:00:00.000Z')
            }
          });
    });
    test('regex', () {
      expect(Regex(path: 'title', query: '(.*) Seattle').build(), {
        'regex': {'path': 'title', 'query': '(.*) Seattle'}
      });
    });
    test('text', () {
      expect(Text(path: 'title', query: 'surfer').build(), {
        'text': {'path': 'title', 'query': 'surfer'}
      });
    });
    test('wildcard', () {
      expect(Wildcard(path: 'title', query: 'Green D*').build(), {
        'wildcard': {'path': 'title', 'query': 'Green D*'}
      });
    });
  });
}
