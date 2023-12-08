import 'package:bson/src/types/bson_null.dart';
import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:test/test.dart' hide Skip;

void main() {
  test('addFields', () {
    expect(
        $addFields([
          fieldSum('totalHomework', Field('homework')),
          fieldSum('totalQuiz', r'$quiz')
        ]).build(),
        {
          r'$addFields': {
            'totalHomework': {r'$sum': r'$homework'},
            'totalQuiz': {r'$sum': r'$quiz'}
          }
        });
    expect(
        $addFields.raw({
          'totalHomework': {r'$sum': r'$homework'},
          'totalQuiz': {r'$sum': r'$quiz'}
        }).build(),
        {
          r'$addFields': {
            'totalHomework': {r'$sum': r'$homework'},
            'totalQuiz': {r'$sum': r'$quiz'}
          }
        });
    expect(
        $addFields.raw({
          'totalHomework': $sum(Field('homework')),
          'totalQuiz': $sum(r'$quiz')
        }).build(),
        {
          r'$addFields': {
            'totalHomework': {r'$sum': r'$homework'},
            'totalQuiz': {r'$sum': r'$quiz'}
          }
        });
  });

  test('set', () {
    expect(
        $set([
          fieldSum('totalHomework', Field('homework')),
          fieldSum('totalQuiz', r'$quiz')
        ]).build(),
        {
          r'$set': {
            'totalHomework': {r'$sum': r'$homework'},
            'totalQuiz': {r'$sum': r'$quiz'}
          }
        });
    expect(
        $set.raw({
          'totalHomework': {r'$sum': r'$homework'},
          'totalQuiz': {r'$sum': r'$quiz'}
        }).build(),
        {
          r'$set': {
            'totalHomework': {r'$sum': r'$homework'},
            'totalQuiz': {r'$sum': r'$quiz'}
          }
        });
    expect(
        $set.raw({
          ...FieldExpression('totalHomework', $sum(Field('homework'))).build(),
          'totalQuiz': $sum(r'$quiz')
        }).build(),
        {
          r'$set': {
            'totalHomework': {r'$sum': r'$homework'},
            'totalQuiz': {r'$sum': r'$quiz'}
          }
        });
  });

  test('setWindowFields', () {
    expect(
        $setWindowFields(
            partitionBy: {r'$year': r"$orderDate"},
            sortBy: {'orderDate': 1},
            output: Output('cumulativeQuantityForYear', $sum(r'$quantity'),
                documents: ["unbounded", "current"])).build(),
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
        $setWindowFields(
                partitionBy: r'$state',
                sortBy: {'orderDate': 1},
                output: Output('recentOrders', $push(r'$orderDate'),
                    range: ["unbounded", -10], unit: "month"))
            .build(),
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
        $setWindowFields(output: Output('recentOrders', $avg(r'$orderDate')))
            .build(),
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
        $setWindowFields(partitionBy: {
          r'$year': r'$orderDate'
        }, sortBy: {
          'orderDate': 1
        }, output: [
          Output('cumulativeQuantityForYear', $sum(r'$quantity'),
              documents: ["unbounded", "current"]),
          Output('maximumQuantityForYear', $max(r'$quantity'),
              documents: ["unbounded", "unbounded"])
        ]).build(),
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
    expect(
        $setWindowFields.raw({
          'partitionBy': $year(Field('orderDate')).build(),
          'sortBy': {'orderDate': 1},
          'output': {
            'cumulativeQuantityForYear': {
              ...$sum(Field('quantity')).build(),
              'window': {
                'documents': ["unbounded", "current"]
              }
            },
            'maximumQuantityForYear': {
              ...$max(Field('quantity')).build(),
              'window': {
                'documents': ["unbounded", "unbounded"]
              }
            }
          }
        }).build(),
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
    expect($unset(['isbn', 'author.first', 'copies.warehouse']).build(), {
      '\$unset': ['isbn', 'author.first', 'copies.warehouse']
    });
  });

  test('bucket', () {
    expect(
        $bucket(
                groupBy: Field('price'),
                boundaries: [0, 200, 400],
                defaultId: 'Other',
                output: {'count': $sum(1), 'titles': $push(Field('title'))})
            .build(),
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
        $bucketAuto(
            groupBy: Field('_id'),
            buckets: 5,
            granularity: Granularity.r5,
            output: {'count': $sum(1)}).build(),
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
    expect($count('myCount').build(), {'\$count': 'myCount'});
  });

  test('facet', () {
    expect(
        $facet({
          'categorizedByTags': [
            $unwind(Field('tags')),
            $sortByCount(Field('tags'))
          ],
          'categorizedByPrice': [
            $match((where..$exists('price')).rawFilter),
            $bucket(
                groupBy: Field('price'),
                boundaries: [0, 150, 200, 300, 400],
                defaultId: 'Other',
                output: {'count': $sum(1), 'titles': $push(Field('title'))})
          ],
          'categorizedByYears(Auto)': [
            $bucketAuto(groupBy: Field('year'), buckets: 4)
          ]
        }).build(),
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
    expect($replaceWith(Field('name')).build(), {'\$replaceWith': '\$name'});
    expect(
        $replaceWith($mergeObjects([
          {'_id': Field('_id'), 'first': '', 'last': ''},
          Field('name')
        ])).build(),
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
        $group(id: {
          'month': $month(Field('date')),
          'day': $dayOfMonth(Field('date')),
          'year': $year(Field('date'))
        }, fields: {
          'totalPrice': $sum($multiply([Field('price'), Field('quantity')])),
          'averageQuantity': $avg(Field('quantity')),
          'count': $sum(1)
        }).build(),
        {
          r'$group': {
            '_id': {
              'month': {r'$month': r'$date'},
              'day': {r'$dayOfMonth': r'$date'},
              'year': {r'$year': r'$date'}
            },
            'totalPrice': {
              r'$sum': {
                r'$multiply': [r'$price', r'$quantity']
              }
            },
            'averageQuantity': {r'$avg': r'$quantity'},
            'count': {r'$sum': 1}
          }
        });
    final nullId = BsonNull();
    expect(
        $group(id: nullId, fields: {
          'totalPrice': $sum($multiply([Field('price'), Field('quantity')])),
          'averageQuantity': $avg(Field('quantity')),
          'count': $sum(1)
        }).build(),
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
    expect($group(id: Field('item')).build(), {
      '\$group': {'_id': '\$item'}
    });
    expect(
        $group(id: Field('author'), fields: {'books': $push(Field('title'))})
            .build(),
        {
          '\$group': {
            '_id': '\$author',
            'books': {'\$push': '\$title'}
          }
        });
    expect(
        $group(id: Field('author'), fields: {'books': $push(Var.root)}).build(),
        {
          '\$group': {
            '_id': '\$author',
            'books': {'\$push': '\$\$ROOT'}
          }
        });
  });

  test('match', () {
    expect(
        $match((where
                  ..$eq('author', 'dave')
                  ..filter)
                .rawFilter)
            .build(),
        {
          '\$match': {
            'author': {r'$eq': 'dave'}
          }
        });
    expect($match($expr($eq(Field('author'), 'dave'))).build(), {
      '\$match': {
        '\$expr': {
          '\$eq': ['\$author', 'dave']
        }
      }
    });
  });

  test('lookup', () {
    expect(
        $lookup(
                from: 'inventory',
                localField: 'item',
                foreignField: 'sku',
                as: 'inventory_docs')
            .build(),
        {
          '\$lookup': {
            'from': 'inventory',
            'localField': 'item',
            'foreignField': 'sku',
            'as': 'inventory_docs'
          }
        });
    expect(
        $lookup
            .withPipeline(
                from: 'warehouses',
                let: {
                  'order_item': Field('item'),
                  'order_qty': Field('ordered')
                },
                pipeline: [
                  $match($expr($and([
                    $eq(Field('stock_item'), Var('order_item')),
                    $gte(Field('instock'), Var('order_qty'))
                  ]))),
                  $project({'stock_item': 0, '_id': 0})
                ],
                as: 'stockdata')
            .build(),
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
        $graphLookup(
                from: 'employees',
                startWith: 'reportsTo',
                connectFromField: 'reportsTo',
                connectToField: 'name',
                as: 'reportingHierarchy',
                depthField: 'depth',
                maxDepth: 5,
                restrictSearchWithMatch: where..$eq('field', 'value'))
            .build(),
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
    expect($unwind(Field('sizes')).build(), {
      '\$unwind': {'path': '\$sizes'}
    });
  });

  test('project', () {
    expect($project({'_id': 0, 'title': 1, 'author': 1}).build(), {
      '\$project': {'_id': 0, 'title': 1, 'author': 1}
    });
  });

  test('skip', () {
    expect($skip(5).build(), {'\$skip': 5});
  });

  test('limit', () {
    expect($limit(5).build(), {'\$limit': 5});
  });

  test('sort', () {
    expect($sort({'age': -1, 'posts': 1}).build(), {
      '\$sort': {'age': -1, 'posts': 1}
    });
  });

  test('sortByCount', () {
    expect($sortByCount(Field('employee')).build(),
        {'\$sortByCount': '\$employee'});
    expect(
        $sortByCount($mergeObjects([Field('employee'), Field('business')]))
            .build(),
        {
          '\$sortByCount': {
            '\$mergeObjects': ['\$employee', '\$business']
          }
        });
  });

  test('geoNear', () {
    expect(
        $geoNear(
                near: $geometry.point([-73.99279, 40.719296]),
                distanceField: 'dist.calculated',
                maxDistance: 2,
                query: where
                  ..$eq('category', 'Parks')
                  ..filter.rawContent,
                includeLocs: 'dist.location',
                spherical: true)
            .build(),
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

    expect($sortByCount(Field('employee')).build(),
        {'\$sortByCount': '\$employee'});
    expect(
        $sortByCount($mergeObjects([Field('employee'), Field('business')]))
            .build(),
        {
          '\$sortByCount': {
            '\$mergeObjects': ['\$employee', '\$business']
          }
        });
  });
  test('unionWith', () {
    expect(
        $unionWith(
          coll: 'warehouses',
          pipeline: [
            $project({'state': 1, '_id': 0})
          ],
        ).build(),
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
        $unionWith(coll: 'warehouses', pipeline: [
          $match($expr($and([
            $eq(Field('stock_item'), Var('order_item')),
            $gte(Field('instock'), Var('order_qty'))
          ]))),
          $project({'stock_item': 0, '_id': 0})
        ]).build(),
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
