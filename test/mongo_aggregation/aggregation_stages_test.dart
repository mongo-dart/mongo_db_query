import 'package:bson/src/types/bson_null.dart';
import 'package:mongo_db_query/mongo_db_query.dart';
//import 'package:mongo_dart_query/mongo_dart_query.dart';
import 'package:test/test.dart' hide Skip;

void main() {
  test('addFields', () {
    expect(
        AddFields({
          'totalHomework': Sum(Field('homework')),
          'totalQuiz': Sum(Field('quiz'))
        }).rawContent,
        {
          '\$addFields': {
            'totalHomework': {'\$sum': '\$homework'},
            'totalQuiz': {'\$sum': '\$quiz'}
          }
        });
  });

  test('set', () {
    expect(
        SetStage({
          'totalHomework': Sum(Field('homework')),
          'totalQuiz': Sum(Field('quiz'))
        }).rawContent,
        {
          '\$set': {
            'totalHomework': {'\$sum': '\$homework'},
            'totalQuiz': {'\$sum': '\$quiz'}
          }
        });
  });

  test('setWindowFields', () {
    expect(
        SetWindowFields(
            partitionBy: {r'$year': r"$orderDate"},
            sortBy: {'orderDate': 1},
            output: Output('cumulativeQuantityForYear', Sum(r'$quantity'),
                documents: ["unbounded", "current"])).rawContent,
        {
          r'$setWindowFields': {
            'partitionBy': {r'$year': r"$orderDate"},
            'sortBy': {'orderDate': 1},
            'output': {
              'cumulativeQuantityForYear': {
                r'$sum': r"$quantity",
                'window': {
                  'documents': ["unbounded", "current"]
                }
              }
            }
          }
        });
    expect(
        SetWindowFields(
                partitionBy: r'$state',
                sortBy: {'orderDate': 1},
                output: Output('recentOrders', Push(r'$orderDate'),
                    range: ["unbounded", -10], unit: "month"))
            .rawContent,
        {
          r'$setWindowFields': {
            'partitionBy': r"$state",
            'sortBy': {'orderDate': 1},
            'output': {
              'recentOrders': {
                r'$push': r"$orderDate",
                'window': {
                  'range': ["unbounded", -10],
                  'unit': "month"
                }
              }
            }
          }
        });
    expect(
        SetWindowFields(output: Output('recentOrders', Avg(r'$orderDate')))
            .rawContent,
        {
          r'$setWindowFields': {
            'output': {
              'recentOrders': {
                r'$avg': r"$orderDate",
              }
            }
          }
        });
    expect(
        SetWindowFields(partitionBy: {
          r'$year': r'$orderDate'
        }, sortBy: {
          'orderDate': 1
        }, output: [
          Output('cumulativeQuantityForYear', Sum(r'$quantity'),
              documents: ["unbounded", "current"]),
          Output('maximumQuantityForYear', Max(r'$quantity'),
              documents: ["unbounded", "unbounded"])
        ]).rawContent,
        {
          r'$setWindowFields': {
            'partitionBy': {r'$year': r'$orderDate'},
            'sortBy': {'orderDate': 1},
            'output': {
              'cumulativeQuantityForYear': {
                r'$sum': r'$quantity',
                'window': {
                  'documents': ["unbounded", "current"]
                }
              },
              'maximumQuantityForYear': {
                r'$max': r'$quantity',
                'window': {
                  'documents': ["unbounded", "unbounded"]
                }
              }
            }
          }
        });
  });

  test('unset', () {
    expect(Unset(['isbn', 'author.first', 'copies.warehouse']).rawContent, {
      '\$unset': ['isbn', 'author.first', 'copies.warehouse']
    });
  });

  test('bucket', () {
    expect(
        Bucket(
                groupBy: Field('price'),
                boundaries: [0, 200, 400],
                defaultId: 'Other',
                output: {'count': Sum(1), 'titles': Push(Field('title'))})
            .rawContent,
        {
          '\$bucket': {
            'groupBy': '\$price',
            'boundaries': [0, 200, 400],
            'default': 'Other',
            'output': {
              'count': {'\$sum': 1},
              'titles': {'\$push': '\$title'}
            }
          }
        });
  });

  test('granularity', () {
    expect(Granularity.r5.rawContent, 'R5');
    expect(Granularity.r10.rawContent, 'R10');
    expect(Granularity.r20.rawContent, 'R20');
    expect(Granularity.r40.rawContent, 'R40');
    expect(Granularity.r80.rawContent, 'R80');
    expect(Granularity.e6.rawContent, 'E6');
    expect(Granularity.e12.rawContent, 'E12');
    expect(Granularity.e24.rawContent, 'E24');
    expect(Granularity.e48.rawContent, 'E48');
    expect(Granularity.e96.rawContent, 'E96');
    expect(Granularity.e192.rawContent, 'E192');
    expect(Granularity.g125.rawContent, '1-2-5');
    expect(Granularity.powersof2.rawContent, 'POWERSOF2');
  });

  test('bucketAuto', () {
    expect(
        BucketAuto(
            groupBy: Field('_id'),
            buckets: 5,
            granularity: Granularity.r5,
            output: {'count': Sum(1)}).rawContent,
        {
          '\$bucketAuto': {
            'groupBy': '\$_id',
            'buckets': 5,
            'granularity': 'R5',
            'output': {
              'count': {'\$sum': 1}
            }
          }
        });
  });

  test('count', () {
    expect(Count('myCount').rawContent, {'\$count': 'myCount'});
  });

  test('facet', () {
    expect(
        Facet({
          'categorizedByTags': [
            Unwind(Field('tags')),
            SortByCount(Field('tags'))
          ],
          'categorizedByPrice': [
            Match((where..$exists('price')).rawFilter),
            Bucket(
                groupBy: Field('price'),
                boundaries: [0, 150, 200, 300, 400],
                defaultId: 'Other',
                output: {'count': Sum(1), 'titles': Push(Field('title'))})
          ],
          'categorizedByYears(Auto)': [
            BucketAuto(groupBy: Field('year'), buckets: 4)
          ]
        }).rawContent,
        {
          '\$facet': {
            'categorizedByTags': [
              {
                '\$unwind': {'path': '\$tags'}
              },
              {'\$sortByCount': '\$tags'}
            ],
            'categorizedByPrice': [
              {
                '\$match': {
                  'price': {'\$exists': true}
                }
              },
              {
                '\$bucket': {
                  'groupBy': '\$price',
                  'boundaries': [0, 150, 200, 300, 400],
                  'default': 'Other',
                  'output': {
                    'count': {'\$sum': 1},
                    'titles': {'\$push': '\$title'}
                  }
                }
              }
            ],
            'categorizedByYears(Auto)': [
              {
                '\$bucketAuto': {'groupBy': '\$year', 'buckets': 4}
              }
            ]
          }
        });
  });

  test('replaceWith', () {
    expect(ReplaceWith(Field('name')).rawContent, {'\$replaceWith': '\$name'});
    expect(
        ReplaceWith(MergeObjects([
          {'_id': Field('_id'), 'first': '', 'last': ''},
          Field('name')
        ])).rawContent,
        {
          '\$replaceWith': {
            '\$mergeObjects': [
              {'_id': '\$_id', 'first': '', 'last': ''},
              '\$name'
            ]
          }
        });
  });

  test('group', () {
    expect(
        Group(id: {
          'month': Month(Field('date')),
          'day': DayOfMonth(Field('date')),
          'year': Year(Field('date'))
        }, fields: {
          'totalPrice': Sum($Multiply([Field('price'), Field('quantity')])),
          'averageQuantity': Avg(Field('quantity')),
          'count': Sum(1)
        }).rawContent,
        {
          '\$group': {
            '_id': {
              'month': {
                '\$month': {'date': '\$date'}
              },
              'day': {
                '\$dayOfMonth': {'date': '\$date'}
              },
              'year': {
                '\$year': {'date': '\$date'}
              }
            },
            'totalPrice': {
              '\$sum': {
                '\$multiply': ['\$price', '\$quantity']
              }
            },
            'averageQuantity': {'\$avg': '\$quantity'},
            'count': {'\$sum': 1}
          }
        });
    final nullId = BsonNull();
    expect(
        Group(id: nullId, fields: {
          'totalPrice': Sum($Multiply([Field('price'), Field('quantity')])),
          'averageQuantity': Avg(Field('quantity')),
          'count': Sum(1)
        }).rawContent,
        {
          '\$group': {
            '_id': nullId,
            'totalPrice': {
              '\$sum': {
                '\$multiply': ['\$price', '\$quantity']
              }
            },
            'averageQuantity': {'\$avg': '\$quantity'},
            'count': {'\$sum': 1}
          }
        });
    expect(Group(id: Field('item')).rawContent, {
      '\$group': {'_id': '\$item'}
    });
    expect(
        Group(id: Field('author'), fields: {'books': Push(Field('title'))})
            .rawContent,
        {
          '\$group': {
            '_id': '\$author',
            'books': {'\$push': '\$title'}
          }
        });
    expect(
        Group(id: Field('author'), fields: {'books': Push(Var.root)})
            .rawContent,
        {
          '\$group': {
            '_id': '\$author',
            'books': {'\$push': '\$\$ROOT'}
          }
        });
  });

  test('match', () {
    expect(
        Match((where
                  ..$eq('author', 'dave')
                  ..filter)
                .rawFilter)
            .rawContent,
        {
          '\$match': {
            'author': {r'$eq': 'dave'}
          }
        });
    expect(Match(Expr(Eq(Field('author'), 'dave'))).rawContent, {
      '\$match': {
        '\$expr': {
          '\$eq': ['\$author', 'dave']
        }
      }
    });
  });

  test('lookup', () {
    expect(
        Lookup(
                from: 'inventory',
                localField: 'item',
                foreignField: 'sku',
                as: 'inventory_docs')
            .rawContent,
        {
          '\$lookup': {
            'from': 'inventory',
            'localField': 'item',
            'foreignField': 'sku',
            'as': 'inventory_docs'
          }
        });
    expect(
        Lookup.withPipeline(
                from: 'warehouses',
                let: {
                  'order_item': Field('item'),
                  'order_qty': Field('ordered')
                },
                pipeline: [
                  Match(Expr(And([
                    Eq(Field('stock_item'), Var('order_item')),
                    Gte(Field('instock'), Var('order_qty'))
                  ]))),
                  Project({'stock_item': 0, '_id': 0})
                ],
                as: 'stockdata')
            .rawContent,
        {
          '\$lookup': {
            'from': 'warehouses',
            'let': {'order_item': '\$item', 'order_qty': '\$ordered'},
            'pipeline': [
              {
                '\$match': {
                  '\$expr': {
                    '\$and': [
                      {
                        '\$eq': ['\$stock_item', '\$\$order_item']
                      },
                      {
                        '\$gte': ['\$instock', '\$\$order_qty']
                      }
                    ]
                  }
                }
              },
              {
                '\$project': {'stock_item': 0, '_id': 0}
              }
            ],
            'as': 'stockdata'
          }
        });
  });

  test('graphLookup', () {
    expect(
        GraphLookup(
                from: 'employees',
                startWith: 'reportsTo',
                connectFromField: 'reportsTo',
                connectToField: 'name',
                as: 'reportingHierarchy',
                depthField: 'depth',
                maxDepth: 5,
                restrictSearchWithMatch: where..$eq('field', 'value'))
            .rawContent,
        {
          r'$graphLookup': {
            'from': 'employees',
            'startWith': r'$reportsTo',
            'connectFromField': 'reportsTo',
            'connectToField': 'name',
            'as': 'reportingHierarchy',
            'depthField': 'depth',
            'maxDepth': 5,
            'restrictSearchWithMatch': {
              'field': {r'$eq': 'value'}
            }
          }
        });
  });
  test('unwind', () {
    expect(Unwind(Field('sizes')).rawContent, {
      '\$unwind': {'path': '\$sizes'}
    });
  });

  test('project', () {
    expect(Project({'_id': 0, 'title': 1, 'author': 1}).rawContent, {
      '\$project': {'_id': 0, 'title': 1, 'author': 1}
    });
  });

  test('skip', () {
    expect(Skip(5).rawContent, {'\$skip': 5});
  });

  test('limit', () {
    expect(Limit(5).rawContent, {'\$limit': 5});
  });

  test('sort', () {
    expect(Sort({'age': -1, 'posts': 1}).rawContent, {
      '\$sort': {'age': -1, 'posts': 1}
    });
  });

  test('sortByCount', () {
    expect(SortByCount(Field('employee')).rawContent,
        {'\$sortByCount': '\$employee'});
    expect(
        SortByCount(MergeObjects([Field('employee'), Field('business')]))
            .rawContent,
        {
          '\$sortByCount': {
            '\$mergeObjects': ['\$employee', '\$business']
          }
        });
  });

  test('geoNear', () {
    expect(
        GeoNear(
                near: Geometry.point([-73.99279, 40.719296]),
                distanceField: 'dist.calculated',
                maxDistance: 2,
                query: where
                  ..$eq('category', 'Parks')
                  ..filter.rawContent,
                includeLocs: 'dist.location',
                spherical: true)
            .rawContent,
        {
          r'$geoNear': {
            'near': {
              'type': 'Point',
              'coordinates': [-73.99279, 40.719296]
            },
            'distanceField': 'dist.calculated',
            'maxDistance': 2,
            'query': {
              'category': {r'$eq': 'Parks'}
            },
            'includeLocs': 'dist.location',
            'spherical': true
          }
        });

    expect(SortByCount(Field('employee')).rawContent,
        {'\$sortByCount': '\$employee'});
    expect(
        SortByCount(MergeObjects([Field('employee'), Field('business')]))
            .rawContent,
        {
          '\$sortByCount': {
            '\$mergeObjects': ['\$employee', '\$business']
          }
        });
  });
  test('unionWith', () {
    expect(
        UnionWith(
          coll: 'warehouses',
          pipeline: [
            Project({'state': 1, '_id': 0})
          ],
        ).rawContent,
        {
          r'$unionWith': {
            'coll': 'warehouses',
            'pipeline': [
              {
                r'$project': {'state': 1, '_id': 0}
              }
            ]
          }
        });
    expect(
        UnionWith(coll: 'warehouses', pipeline: [
          Match(Expr(And([
            Eq(Field('stock_item'), Var('order_item')),
            Gte(Field('instock'), Var('order_qty'))
          ]))),
          Project({'stock_item': 0, '_id': 0})
        ]).rawContent,
        {
          r'$unionWith': {
            'coll': 'warehouses',
            'pipeline': [
              {
                r'$match': {
                  r'$expr': {
                    r'$and': [
                      {
                        r'$eq': [r'$stock_item', r'$$order_item']
                      },
                      {
                        r'$gte': [r'$instock', r'$$order_qty']
                      }
                    ]
                  }
                }
              },
              {
                r'$project': {'stock_item': 0, '_id': 0}
              }
            ]
          }
        });
  });
}
