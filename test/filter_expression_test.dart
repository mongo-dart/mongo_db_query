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
        filter = FilterExpression()..$eq('qty', 20);
        expect(filter.build(), {
          'qty': {r'$eq': 20}
        });
      });
      test(r'id', () {
        var filter = FilterExpression()..id(995);
        expect(
            filter.build(),
            equals({
              '_id': {r'$eq': 995}
            }));
      });
      test(r'$gt', () {
        var filter = FilterExpression()..$gt('quantity', 20);
        expect(
            filter.build(),
            equals({
              'quantity': {r'$gt': 20}
            }));
      });
      test(r'$gte', () {
        var filter = FilterExpression()..$gte('quantity', 20);
        expect(
            filter.build(),
            equals({
              'quantity': {r'$gte': 20}
            }));
      });
      test(r'$in', () {
        var filter = FilterExpression()..$in('quantity', [5, 15]);
        expect(
            filter.build(),
            equals({
              'quantity': {
                r'$in': [5, 15]
              }
            }));
      });
      test(r'$lt', () {
        var filter = FilterExpression()..$lt('quantity', 20);
        expect(
            filter.build(),
            equals({
              'quantity': {r'$lt': 20}
            }));
      });
      test(r'$lte', () {
        var filter = FilterExpression()..$lte('quantity', 20);
        expect(
            filter.build(),
            equals({
              'quantity': {r'$lte': 20}
            }));
      });
      test(r'$ne', () {
        var filter = FilterExpression()..$ne('quantity', 20);
        expect(
            filter.build(),
            equals({
              'quantity': {r'$ne': 20}
            }));
      });
      test(r'$nin', () {
        var filter = FilterExpression()..$nin('quantity', [5, 15]);
        expect(
            filter.build(),
            equals({
              'quantity': {
                r'$nin': [5, 15]
              }
            }));
      });
      test(r'inRange', () {
        var filter = FilterExpression()..inRange('quantity', 5, 15);
        expect(
            filter.build(),
            equals({
              'quantity': {
                r'$gte': 5,
                r'$lt': 15,
              }
            }));

        filter = FilterExpression()
          ..inRange('quantity', 5, 15, minInclude: false, maxInclude: true);
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$and
          ..$exists('price');
        expect(
            filter.build(),
            equals({
              'price': {r'$ne': 1.99, r'$exists': true}
            }));
        filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$exists('price');
        expect(
            filter.build(),
            equals({
              'price': {r'$ne': 1.99, r'$exists': true}
            }));
        filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$exists('quantity');
        expect(
            filter.build(),
            equals({
              'price': {r'$ne': 1.99},
              'quantity': {r'$exists': true}
            }));
      });
      test(r'$not', () {
        var filter = FilterExpression()
          ..$not
          ..$gt('price', 1.99);
        expect(
            filter.build(),
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
        filter = FilterExpression()
          ..$not
          ..$jsonSchema(schemaMap);
        expect(
            filter.build(),
            equals({
              r'$not': {r'$jsonSchema': schemaMap}
            }));
        filter = FilterExpression()
          ..$gt('price', 1.99)
          ..$not;
        expect(
            filter.build(),
            equals({
              'price': {r'$gt': 1.99}
            }));
        filter = FilterExpression()
          ..$gt('price', 1.99)
          ..$and
          ..$not;
        expect(
            filter.build(),
            equals({
              'price': {r'$gt': 1.99}
            }));

        filter = FilterExpression()
          ..$gt('price', 1.99)
          ..$not
          ..$and
          ..$eq('quantity', 20);
        expect(
            filter.build(),
            equals({
              'price': {r'$gt': 1.99},
              'quantity': {r'$eq': 20}
            }));
      });
      test(r'$not - excluded and', () {
        var filter = FilterExpression()
          ..$gt('price', 1.99)
          ..$not
          ..$and;

        expect(
            filter.build(),
            equals({
              'price': {r'$gt': 1.99}
            }));
      });

      test(r'$not - excluded - and - 2', () {
        var filter = FilterExpression()
          ..$not
          ..$gt('price', 1.99)
          ..$not
          ..$and;

        expect(
            filter.build(),
            equals({
              'price': {
                r'$not': {r'$gt': 1.99}
              }
            }));
      });
      test(r'$not - excluded - and - 3', () {
        var filter = FilterExpression()
          ..$not
          ..$not
          ..$and;

        expect(filter.build(), equals({}));
      });

      test(r'$not - excluded or', () {
        var filter = FilterExpression()
          ..$gt('price', 1.99)
          ..$not
          ..$or;

        expect(
            filter.build(),
            equals({
              r'$or': [
                {
                  'price': {r'$gt': 1.99}
                }
              ]
            }));
      });

      test(r'$not - excluded - or - 2', () {
        var filter = FilterExpression()
          ..$not
          ..$gt('price', 1.99)
          ..$not
          ..$or;

        expect(
            filter.build(),
            equals({
              r'$or': [
                {
                  'price': {
                    r'$not': {r'$gt': 1.99}
                  }
                }
              ]
            }));
      });
      test(r'$not - excluded - or - 3', () {
        var filter = FilterExpression()
          ..$not
          ..$not
          ..$or;

        expect(filter.build(), equals({}));
      });

      test(r'$not - excluded nor', () {
        var filter = FilterExpression()
          ..$gt('price', 1.99)
          ..$not
          ..$nor;

        expect(
            filter.build(),
            equals({
              r'$nor': [
                {
                  'price': {r'$gt': 1.99}
                }
              ]
            }));
      });

      test(r'$not - excluded - nor - 2', () {
        var filter = FilterExpression()
          ..$not
          ..$gt('price', 1.99)
          ..$not
          ..$nor;

        expect(
            filter.build(),
            equals({
              r'$nor': [
                {
                  'price': {
                    r'$not': {r'$gt': 1.99}
                  }
                }
              ]
            }));
      });
      test(r'$not - excluded - nor - 3', () {
        var filter = FilterExpression()
          ..$not
          ..$not
          ..$nor;

        expect(filter.build(), equals({}));
      });

      test(r'$nor', () {
        var filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$nor
          ..$exists('price');
        expect(
            filter.build(),
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
        filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$nor
          ..$exists('price');
        expect(
            filter.build(),
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
        filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$nor
          ..$exists('quantity');
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$or
          ..$exists('price');
        expect(
            filter.build(),
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
        filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$or
          ..$exists('price');
        expect(
            filter.build(),
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
        filter = FilterExpression()
          ..$ne('price', 1.99)
          ..$or
          ..$exists('quantity');
        expect(
            filter.build(),
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
        var filter = FilterExpression()..$exists('quantity');
        expect(
            filter.build(),
            equals({
              'quantity': {r'$exists': true}
            }));
      });
      test('notExists', () {
        var filter = FilterExpression()..notExists('quantity');
        expect(
            filter.build(),
            equals({
              'quantity': {r'$exists': false}
            }));
      });
      test(r'$type', () {
        var filter = FilterExpression()..$type('zipCode', 2);
        expect(
            filter.build(),
            equals({
              'zipCode': {r'$type': 2}
            }));
        filter = FilterExpression()..$type('zipCode', 'string');
        expect(
            filter.build(),
            equals({
              'zipCode': {r'$type': 'string'}
            }));
        filter = FilterExpression()..$type('zipCode', [3, 'string']);
        expect(
            filter.build(),
            equals({
              'zipCode': {
                r'$type': [3, 'string']
              }
            }));
      });
    });
    group('Evaluation Query Operators', () {
      test(r'$expr', () {
        var filter = FilterExpression()..$expr($gt(Field('spent'), r'$budget'));
        expect(
            filter.build(),
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
        var filter = FilterExpression()..$jsonSchema(schemaMap);
        expect(filter.build(), equals({r'$jsonSchema': schemaMap}));
      });
      test(r'$mod', () {
        var filter = FilterExpression()..$mod('qty', 4);
        expect(
            filter.build(),
            equals({
              'qty': {
                r'$mod': [4, 0]
              }
            }));
        filter = FilterExpression()..$mod('qty', 4, reminder: 1);
        expect(
            filter.build(),
            equals({
              'qty': {
                r'$mod': [4, 1]
              }
            }));
      });
      test(r'$regex', () {
        var filter = FilterExpression()
          ..$regex('name', 'acme.*corp', caseInsensitive: true);
        expect(
            filter.build(),
            equals({
              'name': {r'$regex': 'acme.*corp', r'$options': 'i'}
            }));
        filter = FilterExpression()
          ..$regex('name', 'acme.*corp',
              caseInsensitive: true,
              multiLineAnchorMatch: true,
              extendedIgnoreWhiteSpace: true,
              dotMatchAll: true,
              escapePattern: true);
        expect(
            filter.build(),
            equals({
              'name': {r'$regex': 'acme\\.\\*corp', r'$options': 'imxs'}
            }));
      });
      test(r'$text', () {
        var filter = FilterExpression()
          ..$text('Coffee -shop', caseSensitive: true);
        expect(
            filter.build(),
            equals({
              r'$text': {r'$search': 'Coffee -shop', r'$caseSensitive': true}
            }));
        filter = FilterExpression()
          ..$text('Coffee -shop',
              language: 'es', diacriticSensitive: true, caseSensitive: true);
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$where('function() { return (hex_md5(this.name) == '
              '"9b53e667f30cd329dca1ec9e6a83e994")}');
        expect(filter.build(), {
          r'$where': 'function() { return (hex_md5(this.name) == '
              '"9b53e667f30cd329dca1ec9e6a83e994")}'
        });
      });
    });
    group('Geospatial Query Operators', () {
      test(r'$geoIntersects', () {
        var filter = FilterExpression()
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
            filter.build(),
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
        var filter = FilterExpression()
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
            filter.build(),
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

        filter = FilterExpression()
          ..$geoWithin('loc', $box(bottomLeft: [0, 0], upperRight: [100, 100]));
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$near('location', GeoPoint.coordinates([-73.9667, 40.78]),
              maxDistance: 5000, minDistance: 1000);
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..nearLegacy('location', [-73.9667, 40.78], maxDistance: 5000);
        expect(
            filter.build(),
            equals({
              'location': {
                r'$near': [-73.9667, 40.78],
                r'$maxDistance': 5000
              }
            }));
      });
      test(r'$nearSphere', () {
        var filter = FilterExpression()
          ..$nearSphere('location', GeoPoint.coordinates([-73.9667, 40.78]),
              maxDistance: 5000, minDistance: 1000);
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..nearSphereLegacy('location', [-73.9667, 40.78], maxDistance: 5000);
        expect(
            filter.build(),
            equals({
              'location': {
                r'$nearSphere': [-73.9667, 40.78],
                r'$maxDistance': 5000
              }
            }));
      });
      test(r'$box - ShapeOperator', () {
        var filter = FilterExpression()
          ..$geoWithin('loc', $box(bottomLeft: [0, 0], upperRight: [100, 100]));
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$geoWithin('loc', $center(center: [-74, 40.74], radius: 10));
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$geoWithin('loc', $centerSphere(center: [-74, 40.74], radius: 10));
        expect(
            filter.build(),
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
        var filter = FilterExpression()
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
            filter.build(),
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
        var filter = FilterExpression()
          ..$geoWithin(
              'loc',
              $polygon(points: [
                [0, 0],
                [3, 6],
                [6, 0]
              ]));
        expect(
            filter.build(),
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
        var filter = FilterExpression()
          ..$all('tags', ["appliance", "school", "book"]);
        expect(
            filter.build(),
            equals({
              'tags': {
                r'$all': ["appliance", "school", "book"]
              }
            }));
      });
      test(r'$elemMatch', () {
        var filter = FilterExpression()
          ..$elemMatch('results', {r'$gte': 80, r'$lt': 85});
        expect(
            filter.build(),
            equals({
              'results': {
                r'$elemMatch': {r'$gte': 80, r'$lt': 85}
              }
            }));
      });
      test(r'$size', () {
        var filter = FilterExpression()..$size('field', 1);
        expect(
            filter.build(),
            equals({
              'field': {r'$size': 1}
            }));
      });
    });
  });
}
