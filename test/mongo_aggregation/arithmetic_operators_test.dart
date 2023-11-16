import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('abs', () {
    expect(Abs(TestExpr()).build(), {'\$abs': '\$field'});
  });

  test('add', () {
    expect(Add([TestExpr(), 1]).build(), {
      r'$add': [r'$field', 1]
    });
  });

  test('ceil', () {
    expect(Ceil(TestExpr()).build(), {'\$ceil': '\$field'});
  });

  test('divide', () {
    expect(Divide(TestExpr(), 2).build(), {
      '\$divide': ['\$field', 2]
    });
  });

  test('exp', () {
    expect(Exp(TestExpr()).build(), {'\$exp': '\$field'});
  });

  test('floor', () {
    expect(Floor(TestExpr()).rawContent, {'\$floor': '\$field'});
  });

  test('ln', () {
    expect(Ln(TestExpr()).rawContent, {'\$ln': '\$field'});
  });

  test('log', () {
    expect(Log(TestExpr(), 2).rawContent, {
      '\$log': ['\$field', 2]
    });
  });

  test('log10', () {
    expect(Log10(TestExpr()).rawContent, {'\$log10': '\$field'});
  });

  test('mod', () {
    expect(Mod(TestExpr(), 2).rawContent, {
      '\$mod': ['\$field', 2]
    });
  });

  test('multiply', () {
    expect(Multiply([TestExpr(), 3]).rawContent, {
      '\$multiply': ['\$field', 3]
    });
  });

  test('pow', () {
    expect(Pow(TestExpr(), 3).rawContent, {
      '\$pow': ['\$field', 3]
    });
  });

  test('round', () {
    expect(Round(TestExpr(), 3).rawContent, {
      '\$round': ['\$field', 3]
    });
  });

  test('sqrt', () {
    expect(Sqrt(TestExpr()).rawContent, {'\$sqrt': '\$field'});
  });

  test('subtract', () {
    expect(Subtract(TestExpr(), 3).rawContent, {
      '\$subtract': ['\$field', 3]
    });
  });

  test('trunc', () {
    expect(Trunc(TestExpr(), 3).rawContent, {
      '\$trunc': ['\$field', 3]
    });
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
