import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('dateFromParts', () {
    expect(
        DateFromParts(
                year: 2019,
                month: 9,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                timezone: 'Europe/Moscow')
            .rawContent,
        {
          '\$dateFromParts': {
            'year': 2019,
            'month': 9,
            'day': 1,
            'hour': 0,
            'minute': 0,
            'second': 0,
            'millisecond': 0,
            'timezone': 'Europe/Moscow'
          }
        });
  });

  test('IsoDateFromParts', () {
    expect(
        IsoDateFromParts(
                year: 2019,
                week: 9,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                timezone: 'Europe/Moscow')
            .rawContent,
        {
          '\$dateFromParts': {
            'isoWeekYear': 2019,
            'isoWeek': 9,
            'isoDayOfWeek': 1,
            'hour': 0,
            'minute': 0,
            'second': 0,
            'millisecond': 0,
            'timezone': 'Europe/Moscow'
          }
        });
  });

  test('dateFromString', () {
    expect(
        DateFromString(
                dateString: '06-15-2018',
                format: '%m-%d-%Y',
                timezone: 'Europe/Moscow',
                onError: TestExpr(),
                onNull: TestExpr())
            .rawContent,
        {
          '\$dateFromString': {
            'dateString': '06-15-2018',
            'format': '%m-%d-%Y',
            'timezone': 'Europe/Moscow',
            'onError': '\$field',
            'onNull': '\$field'
          }
        });
  });

  test('dateToParts', () {
    expect(
        DateToParts(TestExpr(), timezone: 'Europe/Moscow', iso8601: true)
            .rawContent,
        {
          '\$dateToParts': {
            'date': '\$field',
            'timezone': 'Europe/Moscow',
            'iso8601': true
          }
        });
  });

  test('dayOfMonth', () {
    expect(DayOfMonth(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$dayOfMonth': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('dayOfWeek', () {
    expect(DayOfWeek(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$dayOfWeek': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('dayOfYear', () {
    expect(DayOfYear(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$dayOfYear': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('hour', () {
    expect(Hour(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$hour': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('isoDayOfWeek', () {
    expect(IsoDayOfWeek(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$isoDayOfWeek': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('isoWeek', () {
    expect(IsoWeek(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$isoWeek': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('isoWeekYear', () {
    expect(IsoWeekYear(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$isoWeekYear': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('millisecond', () {
    expect(Millisecond(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$millisecond': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('minute', () {
    expect(Minute(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$minute': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('month', () {
    expect(Month(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$month': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('second', () {
    expect(Second(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$second': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('week', () {
    expect(Week(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$week': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('year', () {
    expect(Year(TestExpr(), timezone: 'Europe/Moscow').rawContent, {
      '\$year': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('toDate', () {
    expect(ToDate(TestExpr()).rawContent, {'\$toDate': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
