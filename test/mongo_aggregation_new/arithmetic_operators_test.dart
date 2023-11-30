import 'package:mongo_db_query/src/aggregation/aggregation_stage_new.dart';
import 'package:test/test.dart';

import 'test_expression.dart';

void main() {
  test('abs', () {
    expect((AggregationStageNew()..$abs(TestExpr())).build(),
        {'\$abs': '\$field'});
  });

  test('add', () {
    expect((AggregationStageNew()..$add([TestExpr(), 1])).build(), {
      r'$add': [r'$field', 1]
    });
  });

  test('ceil', () {
    expect((AggregationStageNew()..$ceil(TestExpr())).build(),
        {'\$ceil': '\$field'});
  });

  test('divide', () {
    expect((AggregationStageNew()..$divide(TestExpr(), 2)).build(), {
      '\$divide': ['\$field', 2]
    });
  });

  test('exp', () {
    expect((AggregationStageNew()..$exp(TestExpr())).build(),
        {'\$exp': '\$field'});
  });

  test('floor', () {
    expect((AggregationStageNew()..$floor(TestExpr())).build(),
        {r'$floor': r'$field'});
  });

  test('ln', () {
    expect(
        (AggregationStageNew()..$ln(TestExpr())).build(), {'\$ln': '\$field'});
  });

  test('log', () {
    expect((AggregationStageNew()..$log(TestExpr(), 2)).build(), {
      '\$log': ['\$field', 2]
    });
  });

  test('log10', () {
    expect((AggregationStageNew()..$log10(TestExpr())).build(),
        {'\$log10': '\$field'});
  });

  test('mod', () {
    expect((AggregationStageNew()..$mod(TestExpr(), 2)).build(), {
      '\$mod': ['\$field', 2]
    });
  });

  test('multiply', () {
    expect((AggregationStageNew()..$multiply([TestExpr(), 3])).build(), {
      '\$multiply': ['\$field', 3]
    });
  });

  test('pow', () {
    expect((AggregationStageNew()..$pow(TestExpr(), 3)).build(), {
      '\$pow': ['\$field', 3]
    });
  });

  test('round', () {
    expect((AggregationStageNew()..$round(TestExpr(), 3)).build(), {
      '\$round': ['\$field', 3]
    });
  });

  test('sqrt', () {
    expect((AggregationStageNew()..$sqrt(TestExpr())).build(),
        {'\$sqrt': '\$field'});
  });

  test('subtract', () {
    expect((AggregationStageNew()..$subtract(TestExpr(), 3)).build(), {
      '\$subtract': ['\$field', 3]
    });
  });

  test('trunc', () {
    expect((AggregationStageNew()..$trunc(TestExpr(), 3)).build(), {
      '\$trunc': ['\$field', 3]
    });
  });
}
