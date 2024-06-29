import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/aggregation/base/aggregation_stage.dart';
import 'package:test/test.dart';

void main() {
  group('pipeline', () {
    test('add', () {
      var builder = pipelineBuilder
        ..addStage($match($expr($and([
          $eq(Field('stock_item'), Var('order_item')),
          $gte(Field('instock'), Var('order_qty'))
        ]))))
        ..addStage($project.raw({'stock_item': 0, '_id': 0}));

      expect(builder.build(), [
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
      ]);
    });
    test('List', () {
      var builder = AggregationPipelineBuilder([
        $match($expr($and([
          $eq(Field('stock_item'), Var('order_item')),
          $gte(Field('instock'), Var('order_qty'))
        ]))),
        $project(excluded: ['stock_item', '_id'])
      ]);

      expect(builder.build(), [
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
      ]);
    });
    test('Mix', () {
      var builder = AggregationPipelineBuilder([
        $match($expr($and([
          $eq(Field('stock_item'), Var('order_item')),
          $gte(Field('instock'), Var('order_qty'))
        ]))),
        AggregationStage.raw(r'$project', {'stock_item': 0, '_id': 0})
      ]);

      expect(builder.build(), [
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
      ]);
    });
  });
}
