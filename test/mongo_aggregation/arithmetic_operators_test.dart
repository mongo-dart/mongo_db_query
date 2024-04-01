import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/abstract/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('abs', () {
    expect($abs(TestExpr()).build(), {'\$abs': '\$field'});
  });

  test('add', () {
    expect($add([TestExpr(), 1]).build(), {
      r'$add': [r'$field', 1]
    });
  });

  test('ceil', () {
    expect($ceil(TestExpr()).build(), {'\$ceil': '\$field'});
  });

  test('divide', () {
    expect($divide(TestExpr(), 2).build(), {
      '\$divide': ['\$field', 2]
    });
  });

  test('exp', () {
    expect($exp(TestExpr()).build(), {'\$exp': '\$field'});
  });

  test('floor', () {
    expect($floor(TestExpr()).build(), {r'$floor': r'$field'});
  });

  test('ln', () {
    expect($ln(TestExpr()).build(), {'\$ln': '\$field'});
  });

  test('log', () {
    expect($log(TestExpr(), 2).build(), {
      '\$log': ['\$field', 2]
    });
  });

  test('log10', () {
    expect($log10(TestExpr()).build(), {'\$log10': '\$field'});
  });

  test('mod', () {
    expect($mod(TestExpr(), 2).build(), {
      '\$mod': ['\$field', 2]
    });
  });

  test('multiply', () {
    expect($multiply([TestExpr(), 3]).build(), {
      '\$multiply': ['\$field', 3]
    });
  });

  test('pow', () {
    expect($pow(TestExpr(), 3).build(), {
      '\$pow': ['\$field', 3]
    });
  });

  test('round', () {
    expect($round(TestExpr(), 3).build(), {
      '\$round': ['\$field', 3]
    });
  });

  test('sqrt', () {
    expect($sqrt(TestExpr()).build(), {'\$sqrt': '\$field'});
  });

  test('subtract', () {
    expect($subtract(TestExpr(), 3).build(), {
      '\$subtract': ['\$field', 3]
    });
  });

  test('trunc', () {
    expect($trunc(TestExpr(), 3).build(), {
      '\$trunc': ['\$field', 3]
    });
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
