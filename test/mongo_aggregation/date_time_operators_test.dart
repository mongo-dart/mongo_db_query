import 'package:mongo_db_query/mongo_db_query.dart';
import 'package:mongo_db_query/src/base/abstract/expression_content.dart';
import 'package:test/test.dart';

void main() {
  test('dateFromParts', () {
    expect(
        $dateFromParts(
                year: 2019,
                month: 9,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                timezone: 'Europe/Moscow')
            .build(),
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
            .build(),
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
        $dateFromString(
                dateString: '06-15-2018',
                format: '%m-%d-%Y',
                timezone: 'Europe/Moscow',
                onError: TestExpr(),
                onNull: TestExpr())
            .build(),
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
        $dateToParts(TestExpr(), timezone: 'Europe/Moscow', iso8601: true)
            .build(),
        {
          '\$dateToParts': {
            'date': '\$field',
            'timezone': 'Europe/Moscow',
            'iso8601': true
          }
        });
  });

  test('dayOfMonth', () {
    expect($dayOfMonth(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$dayOfMonth': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('dayOfWeek', () {
    expect($dayOfWeek(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$dayOfWeek': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('dayOfYear', () {
    expect($dayOfYear(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$dayOfYear': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('hour', () {
    expect($hour(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$hour': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('isoDayOfWeek', () {
    expect($isoDayOfWeek(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$isoDayOfWeek': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('isoWeek', () {
    expect($isoWeek(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$isoWeek': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('isoWeekYear', () {
    expect($isoWeekYear(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$isoWeekYear': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('millisecond', () {
    expect($millisecond(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$millisecond': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('minute', () {
    expect($minute(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$minute': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('month', () {
    expect($month(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$month': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('second', () {
    expect($second(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$second': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('week', () {
    expect($week(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$week': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('year', () {
    expect($year(TestExpr(), timezone: 'Europe/Moscow').build(), {
      '\$year': {'date': '\$field', 'timezone': 'Europe/Moscow'}
    });
  });

  test('toDate', () {
    expect($toDate(TestExpr()).build(), {'\$toDate': '\$field'});
  });
}

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
