import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:test/test.dart';

void main() {
  test('concat', () {
    expect($concat([TestExpr(), 'string']).build(), {
      '\$concat': ['\$field', 'string']
    });
  });

  test('indexOfBytes', () {
    expect($indexOfBytes(TestExpr(), 'substr', 1, 10).build(), {
      '\$indexOfBytes': ['\$field', 'substr', 1, 10]
    });
  });

  test('indexOfCP', () {
    expect($indexOfCP(TestExpr(), 'substr', 1, 10).build(), {
      '\$indexOfCP': ['\$field', 'substr', 1, 10]
    });
  });

  test('ltrim', () {
    expect($ltrim(input: TestExpr(), chars: '*').build(), {
      '\$ltrim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('regexFind', () {
    expect(
        $regexFind(input: TestExpr(), regex: 'regex', options: 'is').build(), {
      '\$regexFind': {'input': '\$field', 'regex': 'regex', 'options': 'is'}
    });
  });

  test('regexFindAll', () {
    expect(
        $regexFindAll(input: TestExpr(), regex: 'regex', options: 'is').build(),
        {
          '\$regexFindAll': {
            'input': '\$field',
            'regex': 'regex',
            'options': 'is'
          }
        });
  });

  test('regexMatch', () {
    expect(
        $regexMatch(input: TestExpr(), regex: 'regex', options: 'is').build(), {
      '\$regexMatch': {'input': '\$field', 'regex': 'regex', 'options': 'is'}
    });
  });

  test('rtrim', () {
    expect($rtrim(input: TestExpr(), chars: '*').build(), {
      '\$rtrim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('split', () {
    expect($split(TestExpr(), ',').build(), {
      '\$split': ['\$field', ',']
    });
  });

  test('strLenBytes', () {
    expect($strLenBytes(TestExpr()).build(), {'\$strLenBytes': '\$field'});
  });

  test('strLenCP', () {
    expect($strLenCP(TestExpr()).build(), {'\$strLenCP': '\$field'});
  });

  test('strcasecmp', () {
    expect($strCaseCmp(TestExpr(), TestExpr()).build(), {
      '\$strcasecmp': ['\$field', '\$field']
    });
  });

  test('substrBytes', () {
    expect($substrBytes(TestExpr(), 5, 3).build(), {
      '\$substrBytes': ['\$field', 5, 3]
    });
  });

  test('substrCP', () {
    expect($substrCP(TestExpr(), 5, 3).build(), {
      '\$substrCP': ['\$field', 5, 3]
    });
  });

  test('toLower', () {
    expect($toLower(TestExpr()).build(), {'\$toLower': '\$field'});
  });

  test('toString', () {
    expect($toString(TestExpr()).build(), {'\$toString': '\$field'});
  });

  test('trim', () {
    expect($trim(input: TestExpr(), chars: '*').build(), {
      '\$trim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('toUpper', () {
    expect($toUpper(TestExpr()).build(), {'\$toUpper': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
