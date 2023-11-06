library test_lib;

import 'package:test/test.dart';
import 'package:bson/bson.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

void main() {
  test('SelectorBuilder Creation', () {
    var selector = where;
    //expect(selector.map is Map, isTrue);
    expect(selector.filter.build(), isEmpty);
  });

  test('testSelectorBuilderOnObjectId', () {
    var id = ObjectId();
    var selector = where..id(id);
    //expect(selector.map is Map, isTrue);
    expect(selector.filter.build().length, greaterThan(0));
    expect(
        selector.filter.build(),
        equals({
          r'$query': {'_id': id}
        }));
  });

  test('testSelectorBuilderRawMap', () {
    var selector = where
      ..raw({
        r'$query': {'name': 'joe'}
      });

    var id = ObjectId();
    selector.id(id);
    //expect(selector.map is Map, isTrue);
    expect(selector.filter.build().length, 1);
    expect(selector.filter.build(), {
      r'$and': [
        {'name': 'joe'},
        {'_id': id}
      ]
    });
  });

  test('testQueries', () {
    var selector = where
      ..$gt('my_field', 995)
      ..sortBy('my_field');
    expect(selector.filter.build(), {
      r'$query': {
        'my_field': {r'$gt': 995}
      },
      'orderby': {'my_field': 1}
    });
    selector = where
      ..inRange('my_field', 700, 703, minInclude: false)
      ..sortBy('my_field');
    expect(selector.filter.build(), {
      r'$query': {
        'my_field': {r'$gt': 700, r'$lt': 703}
      },
      'orderby': {'my_field': 1}
    });
    selector = where
      ..$eq('my_field', 17)
      ..selectFields(['str_field']);
    expect(selector.filter.build(), {'my_field': 17});
    expect(selector.fields, {'str_field': 1});

    selector = where
      ..$regex('address', 'john.doe@nowhere.com', escapePattern: true);
    expect(selector.filter.build(), {
      r'$query': {
        'address': {r'$regex': RegExp('john\\.doe@nowhere\\.com')}
      }
    });

    selector = where
      ..sortBy('a')
      ..skip(300);
    expect(
        selector.filter.build(),
        equals({
          '\$query': {},
          'orderby': {'a': 1}
        }));
    /*  selector = where.hint('bar').hint('baz', descending: true).explain();
    expect(
        selector.filter.build(),
        equals({
          '\$query': {},
          '\$hint': {'bar': 1, 'baz': -1},
          '\$explain': true
        })); */
    /*  selector = where.hintIndex('foo');
    expect(selector.filter.build(), equals({'\$query': {}, '\$hint': 'foo'})); */
  });

  test('testQueryComposition', () {
    var selector = where
      ..$gt('a', 995)
      ..$eq('b', 'bbb');
    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            '\$and': [
              {
                'a': {r'$gt': 995}
              },
              {'b': 'bbb'}
            ]
          }
        }));
    selector = where
      ..$gt('a', 995)
      ..$lt('a', 1000);
    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            '\$and': [
              {
                'a': {r'$gt': 995}
              },
              {
                'a': {r'$lt': 1000}
              }
            ]
          }
        }));
    selector = where
      ..$gt('a', 995)
      ..and(where
        ..$lt('b', 1000)
        ..or(where..$gt('c', 2000)));
    expect(selector.filter.build(), {
      '\$query': {
        '\$and': [
          {
            'a': {'\$gt': 995}
          },
          {
            '\$or': [
              {
                'b': {'\$lt': 1000}
              },
              {
                'c': {'\$gt': 2000}
              }
            ]
          }
        ]
      }
    });
    selector = where
      ..$lt('b', 1000)
      ..or(where..$gt('c', 2000))
      ..and(where..$gt('a', 995));
    expect(selector.filter.build(), {
      '\$query': {
        '\$and': [
          {
            '\$or': [
              {
                'b': {'\$lt': 1000}
              },
              {
                'c': {'\$gt': 2000}
              }
            ]
          },
          {
            'a': {'\$gt': 995}
          }
        ]
      }
    });
    selector = where
      ..$lt('b', 1000)
      ..or(where..$gt('c', 2000))
      ..$gt('a', 995);
    expect(selector.filter.build(), {
      '\$query': {
        '\$and': [
          {
            '\$or': [
              {
                'b': {'\$lt': 1000}
              },
              {
                'c': {'\$gt': 2000}
              }
            ]
          },
          {
            'a': {'\$gt': 995}
          }
        ]
      }
    });
    selector = where
      ..$lt('b', 1000)
      ..or(where..$gt('c', 2000))
      ..or(where..$gt('a', 995));
    expect(selector.filter.build(), {
      '\$query': {
        '\$or': [
          {
            'b': {'\$lt': 1000}
          },
          {
            'c': {'\$gt': 2000}
          },
          {
            'a': {'\$gt': 995}
          }
        ]
      }
    });
    selector = where
      ..$eq('price', 1.99)
      ..and(where
        ..$lt('qty', 20)
        ..or(where..$eq('sale', true)));
    expect(selector.filter.build(), {
      '\$query': {
        '\$and': [
          {'price': 1.99},
          {
            '\$or': [
              {
                'qty': {'\$lt': 20}
              },
              {'sale': true}
            ]
          }
        ]
      }
    });
    selector = where
      ..$eq('price', 1.99)
      ..and(where..$lt('qty', 20))
      ..and(where..$eq('sale', true));
    expect(selector.filter.build(), {
      '\$query': {
        '\$and': [
          {'price': 1.99},
          {
            'qty': {'\$lt': 20}
          },
          {'sale': true}
        ]
      }
    });
    selector = where
      ..$eq('price', 1.99)
      ..$lt('qty', 20)
      ..$eq('sale', true);
    expect(selector.filter.build(), {
      '\$query': {
        '\$and': [
          {'price': 1.99},
          {
            'qty': {'\$lt': 20}
          },
          {'sale': true}
        ]
      }
    });
    selector = where
      ..$eq('foo', 'bar')
      ..or(where..$eq('foo', null))
      ..$eq('name', 'jack');
    expect(selector.filter.build(), {
      r'$query': {
        r'$and': [
          {
            r'$or': [
              {'foo': 'bar'},
              {'foo': null}
            ]
          },
          {'name': 'jack'}
        ]
      }
    });
  });

  group('Modifier Builder', () {
    test('set unset', () {
      var modifier = modify
        ..$set('a', 995)
        ..$set('b', 'bbb');
      expect(
          modifier.raw,
          equals({
            r'$set': {'a': 995, 'b': 'bbb'}
          }));
      modifier = modify
        ..$unset('a')
        ..$unset('b');
      expect(
          modifier.raw,
          equals({
            r'$unset': {'a': 1, 'b': 1}
          }));
    });
    test('mul', () {
      var modifier = modify
        ..$set('a', 995)
        ..$mul('b', 5);
      expect(
          modifier.raw,
          equals({
            r'$set': {'a': 995},
            r'$mul': {'b': 5}
          }));
      modifier = modify
        ..$mul('a', 7.0)
        ..$mul('b', 3);
      expect(
          modifier.raw,
          equals({
            r'$mul': {'a': 7.0, 'b': 3}
          }));
    });
    test('addEachToSet', () {
      var modifier = modify..addEachToSet('a', [1, 2, 3]);
      expect(
          modifier.raw,
          equals({
            r'$addToSet': {
              'a': {
                r'$each': [1, 2, 3]
              }
            },
          }));
    });
  });
  test('testGetQueryString', () {
    var selector = where..$eq('foo', 'bar');
    expect(selector.getQueryString(), r'{"$query":{"foo":"bar"}}');
    selector = where..$lt('foo', 2);
    expect(selector.getQueryString(), r'{"$query":{"foo":{"$lt":2}}}');
    var id = ObjectId();
    selector = where..id(id);
    expect(selector.getQueryString(), '{"\$query":{"_id":"${id.oid}"}}');
//  var dbPointer = new DbRef('Dummy',id);
//  selector = where.eq('foo',dbPointer);
//  expect(selector.getQueryString(),'{"\$query":{"foo":$dbPointer}}');
  });

  test('sortByMetaTextScore', () {
    var fieldName = 'fName';
    var searchText = 'sText';
    var selector = where
      ..sortBy(fieldName)
      ..$eq('\$text', {'\$search': searchText})
      ..selectMetaTextScore('score');

    expect(selector.getQueryString(),
        r'{"$query":{"$text":{"$search":"sText"}},"orderby":{"fName":1}}');
  });

  test('copyWith_clone', () {
    var selector = where
      ..$eq('field', 'value')
      ..$gt('num_field', 5)
      ..and(where..$nearSphere('geo_obj', Geometry.point([35.0, 35.0])));

    var copied = QueryExpression.copyWith(selector);

    expect(selector.getQueryString(), equals(copied.getQueryString()));
  });

  test('nearSphere', () {
    var selector = where
      ..$nearSphere(
          'geo_field',
          Geometry(type: GeometryObjectType.Polygon, coordinates: [
            [0, 0],
            [1, 8],
            [12, 30],
            [0, 0]
          ]),
          maxDistance: 1000,
          minDistance: 500);

    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            'geo_field': {
              r'$nearSphere': {
                r'$geometry': {
                  'type': 'Polygon',
                  'coordinates': [
                    [0, 0],
                    [1, 8],
                    [12, 30],
                    [0, 0]
                  ]
                },
                r'$minDistance': 500,
                r'$maxDistance': 1000
              }
            }
          }
        }));
  });

  test('Match', () {
    var selector = where..$regex('testField', 'john.doe@noone.com');
    expect(selector.filter.build()[r'$query']['testField'][r'$regex'].pattern,
        RegExp('john.doe@noone.com').pattern);
    selector = where
      ..$regex('testField', 'john.doe@noone.com', escapePattern: true);
    expect(selector.filter.build()[r'$query']['testField'][r'$regex'].pattern,
        RegExp(r'john\.doe@noone\.com').pattern);
  });
  test('geoIntersects', () {
    var selector = where
      ..$geoIntersects(
          'geo_field',
          Geometry(type: GeometryObjectType.Polygon, coordinates: [
            [0, 0],
            [1, 8],
            [12, 30],
            [0, 0]
          ]));

    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            'geo_field': {
              r'$geoIntersects': {
                r'$geometry': {
                  'type': 'Polygon',
                  'coordinates': [
                    [0, 0],
                    [1, 8],
                    [12, 30],
                    [0, 0]
                  ]
                }
              }
            }
          }
        }));
  });

  test('geoWithin_geometry', () {
    var selector = where
      ..$geoWithin(
          'geo_field',
          Geometry(type: GeometryObjectType.Polygon, coordinates: [
            [0, 0],
            [1, 8],
            [12, 30],
            [0, 0]
          ]));

    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            'geo_field': {
              r'$geoWithin': {
                r'$geometry': {
                  'type': 'Polygon',
                  'coordinates': [
                    [0, 0],
                    [1, 8],
                    [12, 30],
                    [0, 0]
                  ]
                }
              }
            }
          }
        }));
  });

  test('geoWithin_box', () {
    var selector = where
      ..$geoWithin(
          'geo_field', Box(bottomLeft: [5, 8], upperRight: [8.8, 10.5]));

    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            'geo_field': {
              r'$geoWithin': {
                r'$box': [
                  [5, 8],
                  [8.8, 10.5]
                ]
              }
            }
          }
        }));
  });

  test('geoWithin_center', () {
    var selector = where
      ..$geoWithin('geo_field', Center(center: [5, 8], radius: 50.2));

    expect(
        selector.filter.build(),
        equals({
          r'$query': {
            'geo_field': {
              r'$geoWithin': {
                r'$center': [
                  [5, 8],
                  50.2
                ]
              }
            }
          }
        }));
  });
}
