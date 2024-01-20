import 'package:mongo_db_query/src/aggregation/atlas_operator_collector.dart';
import 'package:test/test.dart';

void main() {
  group('Atlas collector', () {
    group('facet', () {
      test('string', () {
        expect(
            Facet([StringFacet('genresFacet', 'genres')],
                    operator: Range(path: 'year', gte: 2000, lte: 2015))
                .build(),
            {
              'facet': {
                'operator': {
                  'range': {'path': 'year', 'gte': 2000, 'lte': 2015}
                },
                'facets': {
                  'genresFacet': {'type': 'string', 'path': 'genres'}
                }
              }
            });
      });
      test('numeric', () {
        expect(
            Facet([
              NumericFacet('yearFacet', 'year', [1980, 1990, 2000],
                  additionalBucket: 'other')
            ], operator: Range(path: 'year', gte: 1980, lte: 2000))
                .build(),
            {
              'facet': {
                'operator': {
                  'range': {'path': 'year', 'gte': 1980, 'lte': 2000}
                },
                'facets': {
                  'yearFacet': {
                    'type': 'number',
                    'path': 'year',
                    'boundaries': [1980, 1990, 2000],
                    'default': 'other'
                  }
                }
              }
            });
      });
      test('date', () {
        expect(
            Facet([
              DateFacet(
                  'yearFacet',
                  'released',
                  [
                    DateTime.parse('2000-01-01'),
                    DateTime.parse('2005-01-01'),
                    DateTime.parse('2010-01-01'),
                    DateTime.parse('2015-01-01')
                  ],
                  additionalBucket: 'other')
            ],
                    operator: Range(
                        path: 'released',
                        gte: DateTime.parse('2000-01-01T00:00:00.000Z'),
                        lte: DateTime.parse('2015-01-31T00:00:00.000Z')))
                .build(),
            {
              'facet': {
                'operator': {
                  'range': {
                    'path': 'released',
                    'gte': DateTime.parse('2000-01-01T00:00:00.000Z'),
                    'lte': DateTime.parse('2015-01-31T00:00:00.000Z')
                  }
                },
                'facets': {
                  'yearFacet': {
                    'type': 'date',
                    'path': 'released',
                    'boundaries': [
                      DateTime.parse('2000-01-01'),
                      DateTime.parse('2005-01-01'),
                      DateTime.parse('2010-01-01'),
                      DateTime.parse('2015-01-01')
                    ],
                    'default': 'other'
                  }
                }
              }
            });
      });
    });
  });
}
