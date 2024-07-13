library test_lib;

import 'dart:convert';

import 'package:test/test.dart';
import 'package:bson/bson.dart';

import 'package:mongo_db_query/mongo_db_query.dart';

void main() {
  test('SelectorBuilder Creation', () {
    var selector = where;
    expect(selector.filter.build(), isMap);
    expect(selector.filter.build(), isEmpty);
  });

  test('testSelectorBuilderOnObjectId', () {
    var id = ObjectId();
    var selector = where..id(id);
    expect(selector.filter.build().isNotEmpty, isTrue);
    expect(
        selector.filter.build(),
        equals({
          '_id': {r'$eq': id}
        }));
  });

  test('testSelectorBuilderRawMap', () {
    var selector = where..raw({'name': 'joe'});

    var id = ObjectId();
    selector.id(id);
    //expect(selector.map is Map, isTrue);
    expect(selector.filter.build().isNotEmpty, isTrue);
    expect(
        selector.filter.build(),
        equals({
          'name': 'joe',
          '_id': {r'$eq': id}
        }));
  });

  test('testQueries', () {
    var selector = where
      ..$gt('my_field', 995)
      ..sortBy('my_field');
    expect(selector.filter.build(), {
      'my_field': {r'$gt': 995}
    });
    expect(selector.sortExp.build(), {'my_field': 1});
    selector = where
      ..inRange('my_field', 700, 703, minInclude: false)
      ..sortBy({'my_field': -1});
    expect(selector.filter.build(), {
      'my_field': {r'$gt': 700, r'$lt': 703}
    });
    expect(selector.sortExp.build(), {'my_field': -1});
    selector = where
      ..$eq('my_field', 17)
      ..selectFields(['str_field']);
    expect(selector.filter.build(), {
      'my_field': {r'$eq': 17}
    });
    expect(selector.fields.build(), {'str_field': 1});
    selector = where
      ..selectFields(['str_field'])
      ..$slice('check', 3);
    expect(selector.filter.build(), {});
    expect(selector.fields.build(), {
      'str_field': 1,
      'check': {r'$slice': 3}
    });
    selector = where..$slice('check', 3, elementsToSkip: 2);
    expect(selector.filter.build(), {});
    expect(selector.fields.build(), {
      'check': {
        r'$slice': [3, 2]
      }
    });
    selector = where
      ..sortBy('a')
      ..skip(300);
    expect(selector.filter.build(), {});
    expect(selector.sortExp.build(), {'a': 1});
    expect(selector.getSkip(), 300);

    /* selector = where
      ..hint('bar')
      ..hint('baz', descending: true)
      ..explain();
    expect(
        selector.filter.build(),
        equals({
          '\$query': {},
          '\$hint': {'bar': 1, 'baz': -1},
          '\$explain': true
        })); */
    /*   selector = where..hintIndex('foo');
    expect(
        selector.filter.build(), equals({'\$query': {}, '\$hint': 'foo'})); */
  });

  test('testQueryComposition', () {
    var selector = where
      ..$gt('a', 995)
      ..$eq('b', 'bbb');
    expect(selector.filter.build(), {
      'a': {r'$gt': 995},
      'b': {r'$eq': 'bbb'}
    });
  });

  test('testQueryComposition 2', () {
    var selector = where
      ..$gt('a', 995)
      ..$lt('a', 1000);
    expect(
        selector.filter.build(),
        equals({
          'a': {r'$gt': 995, r'$lt': 1000},
        }));
  });

  test('testQueryComposition 3', () {
    var selector = where
      ..$gt('a', 995)
      ..$and
      ..open
      ..$lt('b', 1000)
      ..$or
      ..$gt('c', 2000)
      ..close;

    expect(selector.filter.build(), {
      'a': {r'$gt': 995},
      r'$or': [
        {
          'b': {r'$lt': 1000}
        },
        {
          'c': {r'$gt': 2000}
        }
      ]
    });
  });

  test('testQueryComposition 4', () {
    var selector = where
      ..open
      ..$lt('b', 1000)
      ..$or
      ..$gt('c', 2000)
      ..close
      ..$gt('a', 995);
    expect(selector.filter.build(), {
      r'$or': [
        {
          'b': {r'$lt': 1000}
        },
        {
          'c': {r'$gt': 2000}
        }
      ],
      'a': {r'$gt': 995}
    });
  });

  test('testQueryComposition 5', () {
    var selector = where
      ..$lt('b', 1000)
      ..$or
      ..$gt('c', 2000)
      ..$and
      ..$gt('a', 995);
    expect(selector.filter.build(), {
      r'$or': [
        {
          'b': {r'$lt': 1000}
        },
        {
          'c': {r'$gt': 2000},
          'a': {r'$gt': 995}
        }
      ],
    });
  });
  test('testQueryComposition 5a', () {
    var selector = where
      ..$lt('b', 1000)
      ..$or
      ..$gt('c', 2000)
      ..$and
      ..$lt('c', 995);
    expect(selector.filter.build(), {
      r'$or': [
        {
          'b': {r'$lt': 1000}
        },
        {
          'c': {r'$gt': 2000, r'$lt': 995}
        }
      ],
    });
  });

  test('testQueryComposition 6', () {
    var selector = where
      ..$lt('b', 1000)
      ..$or
      ..$gt('c', 2000)
      ..$or
      ..$gt('a', 995);
    expect(selector.filter.build(), {
      r'$or': [
        {
          'b': {r'$lt': 1000}
        },
        {
          'c': {r'$gt': 2000}
        },
        {
          'a': {r'$gt': 995}
        }
      ]
    });
  });

  test('testQueryComposition 7', () {
    var selector = where
      ..$eq('price', 1.99)
      ..$and
      ..open
      ..$lt('qty', 20)
      ..$or
      ..$eq('sale', true)
      ..close;
    expect(selector.filter.build(), {
      'price': {r'$eq': 1.99},
      r'$or': [
        {
          'qty': {r'$lt': 20}
        },
        {
          'sale': {r'$eq': true}
        }
      ]
    });
  });
  test('testQueryComposition 7 bis', () {
    var selector = where
      ..$eq('price', 1.99)
      ..open
      ..$lt('qty', 20)
      ..$or
      ..$eq('sale', true);
    expect(selector.filter.build(), {
      'price': {r'$eq': 1.99},
      r'$or': [
        {
          'qty': {r'$lt': 20}
        },
        {
          'sale': {r'$eq': true}
        }
      ]
    });
  });

  test('testQueryComposition 8', () {
    var selector = where
      ..$eq('price', 1.99)
      ..$and
      ..$lt('qty', 20)
      ..$and
      ..$eq('sale', true);
    expect(selector.filter.build(), {
      'price': {r'$eq': 1.99},
      'qty': {r'$lt': 20},
      'sale': {r'$eq': true}
    });
  });

  test('testQueryComposition 9', () {
    var selector = where
      ..$eq('price', 1.99)
      ..$lt('qty', 20)
      ..$eq('sale', true);
    expect(selector.filter.build(), {
      'price': {r'$eq': 1.99},
      'qty': {'\$lt': 20},
      'sale': {r'$eq': true}
    });
  });

  test('testQueryComposition 10', () {
    var selector = where
      ..$eq('foo', 'bar')
      ..$or
      ..$eq('foo', null)
      ..$eq('name', 'jack');
    expect(selector.filter.build(), {
      r'$or': [
        {
          'foo': {r'$eq': 'bar'}
        },
        {
          'foo': {r'$eq': null},
          'name': {r'$eq': 'jack'}
        }
      ],
    });
  });

  test('testQueryComposition 10 b', () {
    var selector = where
      ..$eq('foo', 'bar')
      ..$or
      ..$eq('foo', null)
      ..$and
      ..$eq('name', 'jack');
    expect(selector.filter.build(), {
      r'$or': [
        {
          'foo': {r'$eq': 'bar'}
        },
        {
          'foo': {r'$eq': null},
          'name': {r'$eq': 'jack'}
        }
      ],
    });
  });
  test('testQueryComposition 10 c', () {
    var selector = where
      ..$eq('foo', 'bar')
      ..$or
      ..$eq('foo', 'test')
      ..$or
      ..$eq('name', 'jack');
    expect(selector.filter.build(), {
      r'$or': [
        {
          'foo': {r'$eq': 'bar'}
        },
        {
          'foo': {r'$eq': 'test'}
        },
        {
          'name': {r'$eq': 'jack'}
        }
      ],
    });
  });
  test('testQueryComposition 10 d', () {
    var selector = where
      ..$eq('foo', 'bar')
      ..$or
      ..$eq('foo', null)
      ..$eq('name', 'jack')
      ..$or
      ..$eq('name', 'Tom');
    expect(selector.filter.build(), {
      r'$or': [
        {
          'foo': {r'$eq': 'bar'}
        },
        {
          'foo': {r'$eq': null},
          'name': {r'$eq': 'jack'}
        },
        {
          'name': {r'$eq': 'Tom'}
        }
      ],
    });
  });
  test('testQueryComposition 10 e', () {
    var selector = where
      ..$eq('foo', 'bar')
      ..$or
      ..$eq('name', 'Tom')
      ..$or
      ..$eq('foo', null)
      ..$eq('name', 'jack');
    expect(selector.filter.build(), {
      r'$or': [
        {
          'foo': {r'$eq': 'bar'}
        },
        {
          'name': {r'$eq': 'Tom'}
        },
        {
          'foo': {r'$eq': null},
          'name': {r'$eq': 'jack'}
        }
      ],
    });
  });
  test('testQueryComposition 10 f', () {
    var selector = where
      ..$eq('foo', null)
      ..$eq('name', 'jack')
      ..$or
      ..$eq('foo', 'bar')
      ..$or
      ..$eq('name', 'Tom');
    expect(selector.filter.build(), {
      r'$or': [
        {
          'foo': {r'$eq': null},
          'name': {r'$eq': 'jack'}
        },
        {
          'foo': {r'$eq': 'bar'}
        },
        {
          'name': {r'$eq': 'Tom'}
        }
      ],
    });
  });
  test('testGetQueryString', () {
    var selector = where..$eq('foo', 'bar');
    expect(selector.getQueryString(), r'{"foo":{"$eq":"bar"}}');
    selector = where..$lt('foo', 2);
    expect(selector.getQueryString(), r'{"foo":{"$lt":2}}');

    var id = ObjectId();
    selector = where..id(id);
    expect(selector.getQueryString(), '{"_id":{"\$eq":"${id.oid}"}}');

    var dbRef = DbRef('Dummy', id);
    selector = where..$eq('foo', dbRef);
    expect(selector.getQueryString(),
        '{"foo":{"\$eq":${json.encode(dbRef.toJson())}}}');
  });

  test('sortByMetaTextScore', () {
    var fieldName = 'fName';
    var searchText = 'sText';
    var selector = where
      ..sortBy(fieldName)
      ..$text(searchText)
      ..sortExp.add$meta('score');

    expect(selector.getQueryString(), r'{"$text":{"$search":"sText"}}');
    expect(selector.sortExp.build(), {
      "fName": 1,
      'score': {r'$meta': 'textScore'}
    });
  });

  test('copyWith_clone', () {
    var selector = where
      ..$eq('field', 'value')
      ..$gt('num_field', 5)
      ..$and
      ..$nearSphere('geo_obj', Geometry.point([35.0, 35.0]));

    var copied = QueryExpression.copyWith(selector);

    expect(selector.getQueryString(), equals(copied.getQueryString()));
  });

  test('nearSphere', () {
    var selector = where
      ..$nearSphere(
          'geo_field',
          GeoPoint.coordinates(
            [0, 0],
          ),
          maxDistance: 1000,
          minDistance: 500);

    expect(
        selector.filter.build(),
        equals({
          'geo_field': {
            r'$nearSphere': {
              r'$geometry': {
                'type': 'Point',
                'coordinates': [0, 0]
              },
              r'$minDistance': 500,
              r'$maxDistance': 1000
            }
          }
        }));
  });

  test('geoIntersects', () {
    var selector = where
      ..$geoIntersects(
          'geo_field',
          Geometry(type: GeoJsonType.polygon, coordinates: [
            [0, 0],
            [1, 8],
            [12, 30],
            [0, 0]
          ]));

    expect(
        selector.filter.build(),
        equals({
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
        }));
  });

  test('geoWithin_geometry', () {
    var selector = where
      ..$geoWithin(
          'geo_field',
          GeoPolygon.coordinates([
            [
              [0, 0],
              [1, 8],
              [12, 30],
              [0, 0]
            ]
          ]));

    expect(
        selector.filter.build(),
        equals({
          'geo_field': {
            r'$geoWithin': {
              r'$geometry': {
                'type': 'Polygon',
                'coordinates': [
                  [
                    [0, 0],
                    [1, 8],
                    [12, 30],
                    [0, 0]
                  ]
                ]
              }
            }
          }
        }));
  });

  test('geoWithin_box', () {
    var selector = where
      ..$geoWithin(
          'geo_field', $box(bottomLeft: [5, 8], upperRight: [8.8, 10.5]));

    expect(
        selector.filter.build(),
        equals({
          'geo_field': {
            r'$geoWithin': {
              r'$box': [
                [5, 8],
                [8.8, 10.5]
              ]
            }
          }
        }));
  });

  test('geoWithin_center', () {
    var selector = where
      ..$geoWithin('geo_field', $center(center: [5, 8], radius: 50.2));

    expect(
        selector.filter.build(),
        equals({
          'geo_field': {
            r'$geoWithin': {
              r'$center': [
                [5, 8],
                50.2
              ]
            }
          }
        }));
  });
  group('Query Expression', () {
    group('Comparison Operators', () {
      test(r'$eq', () {
        var query = where..$eq('a', 995);
        expect(
            query.rawFilter,
            equals({
              'a': {r'$eq': 995}
            }));
        query = where
          ..$eq('a', 7.0)
          ..$eq('b', 3);
        expect(
            query.rawFilter,
            equals({
              'a': {r'$eq': 7.0},
              'b': {r'$eq': 3}
            }));
        query = where..$eq('qty', 20);
        expect(query.rawFilter, {
          'qty': {r'$eq': 20}
        });
      });
      test(r'id', () {
        var query = where..id(995);
        expect(
            query.rawFilter,
            equals({
              '_id': {r'$eq': 995}
            }));
      });
      test(r'$gt', () {
        var query = where..$gt('quantity', 20);
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$gt': 20}
            }));
      });
      test(r'$gte', () {
        var query = where..$gte('quantity', 20);
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$gte': 20}
            }));
      });
      test(r'$in', () {
        var query = where..$in('quantity', [5, 15]);
        expect(
            query.rawFilter,
            equals({
              'quantity': {
                r'$in': [5, 15]
              }
            }));
      });
      test(r'$lt', () {
        var query = where..$lt('quantity', 20);
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$lt': 20}
            }));
        query = where..$lt('age', 40);
        expect(
            query.rawFilter,
            equals({
              'age': {r'$lt': 40}
            }));
      });
      test(r'$lte', () {
        var query = where..$lte('quantity', 20);
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$lte': 20}
            }));
      });
      test(r'$ne', () {
        var query = where..$ne('quantity', 20);
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$ne': 20}
            }));
      });
      test(r'$nin', () {
        var query = where..$nin('quantity', [5, 15]);
        expect(
            query.rawFilter,
            equals({
              'quantity': {
                r'$nin': [5, 15]
              }
            }));
      });
      test(r'inRange', () {
        var query = where..inRange('quantity', 5, 15);
        expect(
            query.rawFilter,
            equals({
              'quantity': {
                r'$gte': 5,
                r'$lt': 15,
              }
            }));

        query = where
          ..inRange('quantity', 5, 15, minInclude: false, maxInclude: true);
        expect(
            query.rawFilter,
            equals({
              'quantity': {
                r'$gt': 5,
                r'$lte': 15,
              }
            }));
      });
    });
    group('Logical Query Operators', () {
      test(r'$and', () {
        var query = where
          ..$ne('price', 1.99)
          ..$and
          ..$exists('price');
        expect(
            query.rawFilter,
            equals({
              'price': {r'$ne': 1.99, r'$exists': true}
            }));
        query = where
          ..$ne('price', 1.99)
          ..$exists('price');
        expect(
            query.rawFilter,
            equals({
              'price': {r'$ne': 1.99, r'$exists': true}
            }));
        query = where
          ..$ne('price', 1.99)
          ..$exists('quantity');
        expect(
            query.rawFilter,
            equals({
              'price': {r'$ne': 1.99},
              'quantity': {r'$exists': true}
            }));
      });
      test(r'$not', () {
        var query = where
          ..$not
          ..$gt('price', 1.99);
        expect(
            query.rawFilter,
            equals({
              'price': {
                r'$not': {r'$gt': 1.99}
              }
            }));

        var schemaMap = {
          'required': ["name", "major", "gpa", "address"],
          'properties': {
            'name': {
              'bsonType': "string",
              'description': "must be a string and is required"
            },
            'address': {
              'bsonType': "object",
              'required': ["zipcode"],
              'properties': {
                "street": {'bsonType': "string"},
                "zipcode": {'bsonType': "string"}
              }
            }
          }
        };
        query = where
          ..$not
          ..$jsonSchema(schemaMap);
        expect(
            query.rawFilter,
            equals({
              r'$not': {r'$jsonSchema': schemaMap}
            }));
      });
      test(r'$not 7', () {
        var filter = where
          ..$gt('price', 1.99)
          ..$not;
        expect(
            filter.rawFilter,
            equals({
              'price': {r'$gt': 1.99}
            }));
      });
      test(r'$not 8', () {
        var query = where
          ..$gt('price', 1.99)
          ..$and
          ..$not;
        expect(
            query.rawFilter,
            equals({
              'price': {r'$gt': 1.99}
            }));
      });

      test(r'$not 10', () {
        var filter = where
          ..$gt('price', 1.99)
          ..$not
          ..open
          ..$and
          ..$eq('quantity', 20)
          ..close;
        expect(
            filter.rawFilter,
            equals({
              'price': {r'$gt': 1.99},
              'quantity': {
                r'$not': {r'$eq': 20}
              }
            }));
      });
      test(r'$not - excluded and', () {
        var filter = where
          ..$gt('price', 1.99)
          ..$not;
        expect(() => filter..$and, throwsStateError);
      });

      test(r'$not - excluded - and - 2', () {
        var filter = where
          ..$not
          ..$gt('price', 1.99)
          ..$not;
        expect(() => filter..$and, throwsStateError);
      });
      test(r'$not - excluded - and - 3', () {
        var query = where
          ..$not
          ..$not;
        expect(query.rawFilter, {});
      });

      test(r'$not - excluded or', () {
        var query = where
          ..$gt('price', 1.99)
          ..$not;
        expect(() => query..$or, throwsStateError);
      });

      test(r'$not - excluded - or - 2', () {
        var query = where
          ..$not
          ..$gt('price', 1.99)
          ..$not;
        expect(() => query..$or, throwsStateError);
      });
      test(r'$not - excluded - or - 3', () {
        var query = where
          ..$not
          ..$not;
        expect(() => query..$or, throwsStateError);
      });

      test(r'$not - excluded nor', () {
        var query = where
          ..$gt('price', 1.99)
          ..$not;

        expect(() => query..$nor, throwsStateError);
      });

      test(r'$not - excluded - nor - 2', () {
        var query = where
          ..$not
          ..$gt('price', 1.99)
          ..$not;
        expect(() => query..$nor, throwsStateError);
      });
      test(r'$not - excluded - nor - 3', () {
        var query = where
          ..$not
          ..$not;
        expect(() => query..$nor, throwsStateError);
      });

      test(r'$nor', () {
        var query = where
          ..$ne('price', 1.99)
          ..$nor
          ..$exists('price');
        expect(
            query.rawFilter,
            equals({
              r'$nor': [
                {
                  'price': {r'$ne': 1.99}
                },
                {
                  'price': {r'$exists': true}
                }
              ]
            }));
        query = where
          ..$ne('price', 1.99)
          ..$nor
          ..$exists('price');
        expect(
            query.rawFilter,
            equals({
              r'$nor': [
                {
                  'price': {r'$ne': 1.99}
                },
                {
                  'price': {r'$exists': true}
                }
              ]
            }));
        query = where
          ..$ne('price', 1.99)
          ..$nor
          ..$exists('quantity');
        expect(
            query.rawFilter,
            equals({
              r'$nor': [
                {
                  'price': {r'$ne': 1.99}
                },
                {
                  'quantity': {r'$exists': true}
                }
              ]
            }));
      });
      test(r'$or', () {
        var query = where
          ..$ne('price', 1.99)
          ..$or
          ..$exists('price');
        expect(
            query.rawFilter,
            equals({
              r'$or': [
                {
                  'price': {r'$ne': 1.99}
                },
                {
                  'price': {r'$exists': true}
                }
              ]
            }));
        query = where
          ..$ne('price', 1.99)
          ..$or
          ..$exists('price');
        expect(
            query.rawFilter,
            equals({
              r'$or': [
                {
                  'price': {r'$ne': 1.99}
                },
                {
                  'price': {r'$exists': true}
                }
              ]
            }));
        query = where
          ..$ne('price', 1.99)
          ..$or
          ..$exists('quantity');
        expect(
            query.rawFilter,
            equals({
              r'$or': [
                {
                  'price': {r'$ne': 1.99}
                },
                {
                  'quantity': {r'$exists': true}
                }
              ]
            }));
      });
    });
    group('Element Query Operators', () {
      test(r'$exists', () {
        var query = where..$exists('quantity');
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$exists': true}
            }));
      });
      test('notExists', () {
        var query = where..notExists('quantity');
        expect(
            query.rawFilter,
            equals({
              'quantity': {r'$exists': false}
            }));
      });
      test(r'$type', () {
        var query = where..$type('zipCode', 2);
        expect(
            query.rawFilter,
            equals({
              'zipCode': {r'$type': 2}
            }));
        query = where..$type('zipCode', 'string');
        expect(
            query.rawFilter,
            equals({
              'zipCode': {r'$type': 'string'}
            }));
        query = where..$type('zipCode', [3, 'string']);
        expect(
            query.rawFilter,
            equals({
              'zipCode': {
                r'$type': [3, 'string']
              }
            }));
      });
    });
    group('Evaluation Query Operators', () {
      test(r'$expr', () {
        var query = where..$expr($gt(Field('spent'), r'$budget'));
        expect(
            query.rawFilter,
            equals({
              r'$expr': {
                r'$gt': [r'$spent', r'$budget']
              }
            }));
      });
      test(r'$jsonSchema', () {
        var schemaMap = {
          'required': ["name", "major", "gpa", "address"],
          'properties': {
            'name': {
              'bsonType': "string",
              'description': "must be a string and is required"
            },
            'address': {
              'bsonType': "object",
              'required': ["zipcode"],
              'properties': {
                "street": {'bsonType': "string"},
                "zipcode": {'bsonType': "string"}
              }
            }
          }
        };
        var query = where..$jsonSchema(schemaMap);
        expect(query.rawFilter, equals({r'$jsonSchema': schemaMap}));
      });
      test(r'$mod', () {
        var query = where..$mod('qty', 4);
        expect(
            query.rawFilter,
            equals({
              'qty': {
                r'$mod': [4, 0]
              }
            }));
        query = where..$mod('qty', 4, reminder: 1);
        expect(
            query.rawFilter,
            equals({
              'qty': {
                r'$mod': [4, 1]
              }
            }));
      });
      test(r'$regex', () {
        var query = where..$regex('name', 'acme.*corp', caseInsensitive: true);
        expect(
            query.rawFilter,
            equals({
              'name': {r'$regex': 'acme.*corp', r'$options': 'i'}
            }));
        query = where
          ..$regex('name', 'acme.*corp',
              caseInsensitive: true,
              multiLineAnchorMatch: true,
              extendedIgnoreWhiteSpace: true,
              dotMatchAll: true,
              escapePattern: true);
        expect(
            query.rawFilter,
            equals({
              'name': {r'$regex': 'acme\\.\\*corp', r'$options': 'imxs'}
            }));
      });
      test(r'$text', () {
        var query = where..$text('Coffee -shop', caseSensitive: true);
        expect(
            query.rawFilter,
            equals({
              r'$text': {r'$search': 'Coffee -shop', r'$caseSensitive': true}
            }));
        query = where
          ..$text('Coffee -shop',
              language: 'es', diacriticSensitive: true, caseSensitive: true);
        expect(
            query.rawFilter,
            equals({
              r'$text': {
                r'$search': 'Coffee -shop',
                r'$language': 'es',
                r'$diacriticSensitive': true,
                r'$caseSensitive': true
              }
            }));
      });
      test(r'$where', () {
        var query = where
          ..$where('function() { return (hex_md5(this.name) == '
              '"9b53e667f30cd329dca1ec9e6a83e994")}');
        expect(query.rawFilter, {
          r'$where': 'function() { return (hex_md5(this.name) == '
              '"9b53e667f30cd329dca1ec9e6a83e994")}'
        });
      });
    });
    group('Geospatial Query Operators', () {
      test(r'$geoIntersects', () {
        var query = where
          ..$geoIntersects(
              'loc',
              GeoPolygon.coordinates([
                [
                  [0, 0],
                  [3, 6],
                  [6, 1],
                  [0, 0]
                ]
              ]));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoIntersects': {
                  r'$geometry': {
                    'type': "Polygon",
                    'coordinates': [
                      [
                        [0, 0],
                        [3, 6],
                        [6, 1],
                        [0, 0]
                      ]
                    ]
                  }
                }
              }
            }));
      });
      test(r'$geoWithin', () {
        var query = where
          ..$geoWithin(
              'loc',
              GeoPolygon.coordinates([
                [
                  [0, 0],
                  [3, 6],
                  [6, 1],
                  [0, 0]
                ]
              ]));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$geometry': {
                    'type': "Polygon",
                    'coordinates': [
                      [
                        [0, 0],
                        [3, 6],
                        [6, 1],
                        [0, 0]
                      ]
                    ]
                  }
                }
              }
            }));

        query = where
          ..$geoWithin('loc', $box(bottomLeft: [0, 0], upperRight: [100, 100]));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$box': [
                    [0, 0],
                    [100, 100]
                  ]
                }
              }
            }));
      });
      test(r'$near', () {
        var query = where
          ..$near('location', GeoPoint.coordinates([-73.9667, 40.78]),
              maxDistance: 5000, minDistance: 1000);
        expect(
            query.rawFilter,
            equals({
              'location': {
                r'$near': {
                  r'$geometry': {
                    'type': "Point",
                    'coordinates': [-73.9667, 40.78]
                  },
                  r'$minDistance': 1000,
                  r'$maxDistance': 5000
                }
              }
            }));
      });
      test(r'nearLegacy', () {
        var query = where
          ..nearLegacy('location', [-73.9667, 40.78], maxDistance: 5000);
        expect(
            query.rawFilter,
            equals({
              'location': {
                r'$near': [-73.9667, 40.78],
                r'$maxDistance': 5000
              }
            }));
      });
      test(r'$nearSphere', () {
        var query = where
          ..$nearSphere('location', GeoPoint.coordinates([-73.9667, 40.78]),
              maxDistance: 5000, minDistance: 1000);
        expect(
            query.rawFilter,
            equals({
              'location': {
                r'$nearSphere': {
                  r'$geometry': {
                    'type': "Point",
                    'coordinates': [-73.9667, 40.78]
                  },
                  r'$minDistance': 1000,
                  r'$maxDistance': 5000
                }
              }
            }));
      });
      test(r'nearSphereLegacy', () {
        var query = where
          ..nearSphereLegacy('location', [-73.9667, 40.78], maxDistance: 5000);
        expect(
            query.rawFilter,
            equals({
              'location': {
                r'$nearSphere': [-73.9667, 40.78],
                r'$maxDistance': 5000
              }
            }));
      });
      test(r'$box - ShapeOperator', () {
        var query = where
          ..$geoWithin('loc', $box(bottomLeft: [0, 0], upperRight: [100, 100]));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$box': [
                    [0, 0],
                    [100, 100]
                  ]
                }
              }
            }));
      });
      test(r'$center - ShapeOperator', () {
        var query = where
          ..$geoWithin('loc', $center(center: [-74, 40.74], radius: 10));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$center': [
                    [-74, 40.74],
                    10
                  ]
                }
              }
            }));
      });
      test(r'$centerSphere - ShapeOperator', () {
        var query = where
          ..$geoWithin('loc', $centerSphere(center: [-74, 40.74], radius: 10));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$centerSphere': [
                    [-74, 40.74],
                    10
                  ]
                }
              }
            }));
      });
      test(r'$geometry - ShapeOperator', () {
        var query = where
          ..$geoWithin(
              'loc',
              $geometry(
                geometry: Geometry.polygon([
                  [
                    [0, 0],
                    [3, 6],
                    [6, 1],
                    [0, 0]
                  ]
                ]),
              ));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$geometry': {
                    'type': "Polygon",
                    'coordinates': [
                      [
                        [0, 0],
                        [3, 6],
                        [6, 1],
                        [0, 0]
                      ]
                    ]
                  }
                }
              }
            }));
      });
      test(r'$polygon - ShapeOperator', () {
        var query = where
          ..$geoWithin(
              'loc',
              $polygon(points: [
                [0, 0],
                [3, 6],
                [6, 0]
              ]));
        expect(
            query.rawFilter,
            equals({
              'loc': {
                r'$geoWithin': {
                  r'$polygon': [
                    [0, 0],
                    [3, 6],
                    [6, 0]
                  ]
                }
              }
            }));
      });
    });
    group('Array Query Operators', () {
      test(r'$all', () {
        var query = where..$all('tags', ["appliance", "school", "book"]);
        expect(
            query.rawFilter,
            equals({
              'tags': {
                r'$all': ["appliance", "school", "book"]
              }
            }));
      });
      test(r'$elemMatch', () {
        var query = where..$elemMatch('results', {r'$gte': 80, r'$lt': 85});
        expect(
            query.rawFilter,
            equals({
              'results': {
                r'$elemMatch': {r'$gte': 80, r'$lt': 85}
              }
            }));
      });
      test(r'$size', () {
        var query = where..$size('field', 1);
        expect(
            query.rawFilter,
            equals({
              'field': {r'$size': 1}
            }));
      });
    });
    group('Bitwise Query Operators', () {
      test(r'$bitsAllClear 1', () {
        var query = where..$bitsAllClear('bits', [1, 5]);
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAllClear': [1, 5]
          }
        });

        query = where..$bitsAllClear('bits', 35);
        expect(query.rawFilter, {
          'bits': {r'$bitsAllClear': 35}
        });

        query = where..$bitsAllClear('bits', BsonBinary.fromHexString('23'));
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAllClear': BsonBinary.from([35])
          }
        });
      });
      test(r'$bitsAllSet 1', () {
        var query = where..$bitsAllSet('bits', [1, 5]);
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAllSet': [1, 5]
          }
        });

        query = where..$bitsAllSet('bits', 35);
        expect(query.rawFilter, {
          'bits': {r'$bitsAllSet': 35}
        });

        query = where..$bitsAllSet('bits', BsonBinary.fromHexString('23'));
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAllSet': BsonBinary.from([35])
          }
        });
      });
      test(r'$bitsAllSet 1', () {
        var query = where..$bitsAllSet('bits', [1, 5]);
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAllSet': [1, 5]
          }
        });

        query = where..$bitsAllSet('bits', 35);
        expect(query.rawFilter, {
          'bits': {r'$bitsAllSet': 35}
        });

        query = where..$bitsAllSet('bits', BsonBinary.fromHexString('23'));
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAllSet': BsonBinary.from([35])
          }
        });
      });
      test(r'$bitsAnyClear 1', () {
        var query = where..$bitsAnyClear('bits', [1, 5]);
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAnyClear': [1, 5]
          }
        });

        query = where..$bitsAnyClear('bits', 35);
        expect(query.rawFilter, {
          'bits': {r'$bitsAnyClear': 35}
        });

        query = where..$bitsAnyClear('bits', BsonBinary.fromHexString('23'));
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAnyClear': BsonBinary.from([35])
          }
        });
      });
      test(r'$bitsAnySet 1', () {
        var query = where..$bitsAnySet('bits', [1, 5]);
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAnySet': [1, 5]
          }
        });

        query = where..$bitsAnySet('bits', 35);
        expect(query.rawFilter, {
          'bits': {r'$bitsAnySet': 35}
        });

        query = where..$bitsAnySet('bits', BsonBinary.fromHexString('23'));
        expect(query.rawFilter, {
          'bits': {
            r'$bitsAnySet': BsonBinary.from([35])
          }
        });
      });
    });
    group('Miscellaneous Query Operators', () {
      test(r'$comment', () {
        var query = where..$comment('Find even values.');
        expect(query.rawFilter, equals({r'$comment': 'Find even values.'}));
      });
      test(r'$rand', () {
        var query = where..$rand();
        expect(query.rawFilter, equals({r'$rand': {}}));
      });
      test(r'$natural', () {
        var query = where..$natural();
        expect(query.rawFilter, equals({r'$natural': 1}));
        query = where..$natural(ascending: false);
        expect(query.rawFilter, equals({r'$natural': -1}));
      });
    });

    group('Projection Operators', () {
      test(r'$', () {
        var query = where..$('grades');
        expect(query.fields.build(), equals({r'grades.$': 1}));
      });
      test(r'$elemMatchProjection', () {
        var query = where
          ..$elemMatchProjection('games', FilterExpression()..$gt('score', 5));
        expect(
            query.fields.build(),
            equals({
              'games': {
                r'$elemMatch': {
                  'score': {r'$gt': 5}
                }
              }
            }));
        query = where
          ..$elemMatchProjection(
              'students',
              FilterExpression()
                ..$eq('school', 5)
                ..$gt('age', 10));
        expect(query.fields.build(), {
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
