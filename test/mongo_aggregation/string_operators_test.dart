import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('concat', () {
    expect(Concat([TestExpr(), 'string']).rawContent, {
      '\$concat': ['\$field', 'string']
    });
  });

  test('indexOfBytes', () {
    expect(IndexOfBytes(TestExpr(), 'substr', 1, 10).rawContent, {
      '\$indexOfBytes': ['\$field', 'substr', 1, 10]
    });
  });

  test('indexOfCP', () {
    expect(IndexOfCP(TestExpr(), 'substr', 1, 10).rawContent, {
      '\$indexOfCP': ['\$field', 'substr', 1, 10]
    });
  });

  test('ltrim', () {
    expect(Ltrim(input: TestExpr(), chars: '*').rawContent, {
      '\$ltrim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('regexFind', () {
    expect(
        RegexFind(input: TestExpr(), regex: 'regex', options: 'is').rawContent,
        {
          '\$regexFind': {'input': '\$field', 'regex': 'regex', 'options': 'is'}
        });
  });

  test('regexFindAll', () {
    expect(
        RegexFindAll(input: TestExpr(), regex: 'regex', options: 'is')
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
        RegexMatch(input: TestExpr(), regex: 'regex', options: 'is').rawContent,
        {
          '\$regexMatch': {
            'input': '\$field',
            'regex': 'regex',
            'options': 'is'
          }
        });
  });

  test('rtrim', () {
    expect(Rtrim(input: TestExpr(), chars: '*').rawContent, {
      '\$rtrim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('split', () {
    expect(Split(TestExpr(), ',').rawContent, {
      '\$split': ['\$field', ',']
    });
  });

  test('strLenBytes', () {
    expect(StrLenBytes(TestExpr()).rawContent, {'\$strLenBytes': '\$field'});
  });

  test('strLenCP', () {
    expect(StrLenCP(TestExpr()).rawContent, {'\$strLenCP': '\$field'});
  });

  test('strcasecmp', () {
    expect(StrCaseCmp(TestExpr(), TestExpr()).rawContent, {
      '\$strcasecmp': ['\$field', '\$field']
    });
  });

  test('substrBytes', () {
    expect(SubstrBytes(TestExpr(), 5, 3).rawContent, {
      '\$substrBytes': ['\$field', 5, 3]
    });
  });

  test('substrCP', () {
    expect(SubstrCP(TestExpr(), 5, 3).rawContent, {
      '\$substrCP': ['\$field', 5, 3]
    });
  });

  test('toLower', () {
    expect(ToLower(TestExpr()).rawContent, {'\$toLower': '\$field'});
  });

  test('toString', () {
    expect(ToString(TestExpr()).rawContent, {'\$toString': '\$field'});
  });

  test('trim', () {
    expect(Trim(input: TestExpr(), chars: '*').rawContent, {
      '\$trim': {'input': '\$field', 'chars': '*'}
    });
  });

  test('toUpper', () {
    expect(ToUpper(TestExpr()).rawContent, {'\$toUpper': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  String build() => '\$field';

  @override
  get rawContent => '\$field';
}
