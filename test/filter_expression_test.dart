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
  });
}
