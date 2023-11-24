import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('concat', () {
    expect($concat([TestExpr(), 'string']).rawContent, {
      '\$concat': ['\$field', 'string']
    });
  });

  test('indexOfBytes', () {
    expect($indexOfBytes(TestExpr(), 'substr', 1, 10).rawContent, {
      '\$indexOfBytes': ['\$field', 'substr', 1, 10]
    });
  });

  test('indexOfCP', () {
    expect($indexOfCP(TestExpr(), 'substr', 1, 10).rawContent, {
      '\$indexOfCP': ['\$field', 'substr', 1, 10]
    });
  });

  test('ltrim', () {
    expect($ltrim(input: TestExpr(), chars: '*').rawContent, {
      '\$ltrim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('regexFind', () {
    expect(
        $regexFind(input: TestExpr(), regex: 'regex', options: 'is').rawContent,
        {
          '\$regexFind': {'input': '\$field', 'regex': 'regex', 'options': 'is'}
        });
  });

  test('regexFindAll', () {
    expect(
        $regexFindAll(input: TestExpr(), regex: 'regex', options: 'is')
            .rawContent,
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
        $regexMatch(input: TestExpr(), regex: 'regex', options: 'is')
            .rawContent,
        {
          '\$regexMatch': {
            'input': '\$field',
            'regex': 'regex',
            'options': 'is'
          }
        });
  });

  test('rtrim', () {
    expect($rtrim(input: TestExpr(), chars: '*').rawContent, {
      '\$rtrim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('split', () {
    expect($split(TestExpr(), ',').rawContent, {
      '\$split': ['\$field', ',']
    });
  });

  test('strLenBytes', () {
    expect($strLenBytes(TestExpr()).rawContent, {'\$strLenBytes': '\$field'});
  });

  test('strLenCP', () {
    expect($strLenCP(TestExpr()).rawContent, {'\$strLenCP': '\$field'});
  });

  test('strcasecmp', () {
    expect($strCaseCmp(TestExpr(), TestExpr()).rawContent, {
      '\$strcasecmp': ['\$field', '\$field']
    });
  });

  test('substrBytes', () {
    expect($substrBytes(TestExpr(), 5, 3).rawContent, {
      '\$substrBytes': ['\$field', 5, 3]
    });
  });

  test('substrCP', () {
    expect($substrCP(TestExpr(), 5, 3).rawContent, {
      '\$substrCP': ['\$field', 5, 3]
    });
  });

  test('toLower', () {
    expect($toLower(TestExpr()).rawContent, {'\$toLower': '\$field'});
  });

  test('toString', () {
    expect($toString(TestExpr()).rawContent, {'\$toString': '\$field'});
  });

  test('trim', () {
    expect($trim(input: TestExpr(), chars: '*').rawContent, {
      '\$trim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('toUpper', () {
    expect($toUpper(TestExpr()).rawContent, {'\$toUpper': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
