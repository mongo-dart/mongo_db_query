/* import 'package:mongo_db_query/src/aggregation/aggregation_stage_new.dart';
import 'package:test/test.dart';

import 'test_expression.dart';

void main() {
  test('abs', () {
    expect((Stage('Test')..$abs(TestExpr())).build()['Test'],
        {'\$abs': '\$field'});
  });

  test('add', () {
    expect((Stage('Test')..$add([TestExpr(), 1])).build()['Test'], {
      r'$add': [r'$field', 1]
    });
  });

  test('ceil', () {
    expect((Stage('Test')..$ceil(TestExpr())).build()['Test'],
        {'\$ceil': '\$field'});
  });

  test('divide', () {
    expect((Stage('Test')..$divide(TestExpr(), 2)).build()['Test'], {
      '\$divide': ['\$field', 2]
    });
  });

  test('exp', () {
    expect((Stage('Test')..$exp(TestExpr())).build()['Test'],
        {'\$exp': '\$field'});
  });

  test('floor', () {
    expect((Stage('Test')..$floor(TestExpr())).build()['Test'],
        {r'$floor': r'$field'});
  });

  test('ln', () {
    expect(
        (Stage('Test')..$ln(TestExpr())).build()['Test'], {'\$ln': '\$field'});
  });

  test('log', () {
    expect((Stage('Test')..$log(TestExpr(), 2)).build()['Test'], {
      '\$log': ['\$field', 2]
    });
  });

  test('log10', () {
    expect((Stage('Test')..$log10(TestExpr())).build()['Test'],
        {'\$log10': '\$field'});
  });

  test('mod', () {
    expect((Stage('Test')..$mod(TestExpr(), 2)).build()['Test'], {
      '\$mod': ['\$field', 2]
    });
  });

  test('multiply', () {
    expect((Stage('Test')..$multiply([TestExpr(), 3])).build()['Test'], {
      '\$multiply': ['\$field', 3]
    });
  });

  test('pow', () {
    expect((Stage('Test')..$pow(TestExpr(), 3)).build()['Test'], {
      '\$pow': ['\$field', 3]
    });
  });

  test('round', () {
    expect((Stage('Test')..$round(TestExpr(), 3)).build()['Test'], {
      '\$round': ['\$field', 3]
    });
  });

  test('sqrt', () {
    expect((Stage('Test')..$sqrt(TestExpr())).build()['Test'],
        {'\$sqrt': '\$field'});
  });

  test('subtract', () {
    expect((Stage('Test')..$subtract(TestExpr(), 3)).build()['Test'], {
      '\$subtract': ['\$field', 3]
    });
  });

  test('trunc', () {
    expect((Stage('Test')..$trunc(TestExpr(), 3)).build()['Test'], {
      '\$trunc': ['\$field', 3]
    });
  });
}
 */