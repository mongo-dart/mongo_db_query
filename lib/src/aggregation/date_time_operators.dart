import '../base/expression_content.dart';
import '../base/operator_expression.dart';
import '../query_expression/query_expression.dart';

import '../base/common/operators_def.dart';

/// `$dateFromParts`
class $dateFromParts extends OperatorExpression {
  /// Creates `$dateFromParts` operator expression
  ///
  /// Constructs and returns a Date object given the date’s constituent
  /// properties.
  $dateFromParts(
      {required year, month, day, hour, minute, second, millisecond, timezone})
      : super(
            op$dateFromParts,
            valueToContent({
              'year': year,
              if (month != null) 'month': month,
              if (day != null) 'day': day,
              if (hour != null) 'hour': hour,
              if (minute != null) 'minute': minute,
              if (second != null) 'second': second,
              if (millisecond != null) 'millisecond': millisecond,
              if (timezone != null) 'timezone': valueToContent(timezone)
            }));
}

/// ISO date from parts
///
/// Variant of `$dateFromParts` operator
class IsoDateFromParts extends OperatorExpression {
  /// Creates `$dateFromParts` operator expression
  ///
  /// Uses ISO Week Date fields to construct Date
  IsoDateFromParts(
      {required year, week, day, hour, minute, second, millisecond, timezone})
      : super(
            op$dateFromParts,
            valueToContent({
              'isoWeekYear': year,
              if (week != null) 'isoWeek': week,
              if (day != null) 'isoDayOfWeek': day,
              if (hour != null) 'hour': hour,
              if (minute != null) 'minute': minute,
              if (second != null) 'second': second,
              if (millisecond != null) 'millisecond': millisecond,
              if (timezone != null) 'timezone': valueToContent(timezone)
            }));
}

/// `$dateFromString` operator
class $dateFromString extends OperatorExpression {
  /// Creates `$dateFromString` operator expression
  ///
  /// Converts a date/time string to a date object.
  ///
  /// * [dateString] - The date/time string to convert to a date object.
  /// * [format] - Optional. The date format specification of the [dateString].
  /// The format can be any expression that evaluates to a string literal,
  /// containing 0 or more format specifiers.
  /// * {timezone} - Optional. The time zone to use to format the date.
  /// * [onError] - Optional. If $dateFromString encounters an error while
  /// parsing the given dateString, it outputs the result value of the provided
  /// [onError] expression. This result value can be of any type. If you do not
  /// specify [onError], `$dateFromString` throws an error if it cannot parse
  /// [dateString].
  /// * [onNull] - Optional. If the [dateString] provided to `$dateFromString` is
  /// `null` or missing, it outputs the result value of the provided [onNull]
  /// expression. This result value can be of any type. If you do not specify
  /// [onNull] and dateString is null or missing, then $dateFromString outputs null.
  $dateFromString(
      {required String dateString, format, timezone, onError, onNull})
      : super(
            op$dateFromString,
            valueToContent({
              'dateString': dateString,
              if (format != null) 'format': valueToContent(format),
              if (timezone != null) 'timezone': valueToContent(timezone),
              if (onError != null) 'onError': onError,
              if (onNull != null) 'onNull': onNull
            }));
}

/// `$dateToParts` operator
class $dateToParts extends OperatorExpression {
  /// Creates `$dateToParts` operator expression
  ///
  /// Returns a document that contains the constituent parts of a given BSON Date
  /// value as individual properties. The properties returned are year, month,
  /// day, hour, minute, second and millisecond. You can set the iso8601 property
  /// to true to return the parts representing an ISO week date instead. This will
  /// return a document where the properties are isoWeekYear, isoWeek,
  /// isoDayOfWeek, hour, minute, second and millisecond.
  $dateToParts(date, {timezone, bool iso8601 = false})
      : super(
            op$dateToParts,
            valueToContent({
              'date': valueToContent(date),
              if (timezone != null) 'timezone': valueToContent(timezone),
              'iso8601': iso8601
            }));
}

/// `$dayOfMonth` operator
class $dayOfMonth extends OperatorExpression {
  /// Creates `$dayOfMonth` operator expression
  ///
  /// Returns the day of the month for a date as a number between 1 and 31.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $dayOfMonth(date, {timezone})
      : super(op$dayOfMonth, _getDateExpression(date, timezone: timezone));
}

/// `$dayOfWeek` operator
class $dayOfWeek extends OperatorExpression {
  /// Creates `$dayOfWeek` operator expression
  ///
  /// Returns the day of the week for a date as a number between 1 (Sunday) and
  /// 7 (Saturday).
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $dayOfWeek(date, {timezone})
      : super(op$dayOfWeek, _getDateExpression(date, timezone: timezone));
}

/// `$dayOfYear` operator
class $dayOfYear extends OperatorExpression {
  /// Creates `$dayOfYear` operator expression
  ///
  /// Returns the day of the year for a date as a number between 1 and 366.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $dayOfYear(date, {timezone})
      : super(op$dayOfYear, _getDateExpression(date, timezone: timezone));
}

/// `$hour` operator
class $hour extends OperatorExpression {
  /// Creates `$hour` operator expression
  ///
  /// Returns the hour portion of a date as a number between 0 and 23.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $hour(date, {timezone})
      : super(op$hour, _getDateExpression(date, timezone: timezone));
}

/// `$isoDayOfWeek` operator
class $isoDayOfWeek extends OperatorExpression {
  /// Creates `$isoDayOfWeek` operator expression
  ///
  /// Returns the weekday number in ISO 8601 format, ranging from 1 (for Monday)
  /// to 7 (for Sunday).
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $isoDayOfWeek(date, {timezone})
      : super(op$isoDayOfWeek, _getDateExpression(date, timezone: timezone));
}

/// `$isoWeek` operator
class $isoWeek extends OperatorExpression {
  /// Creates `$isoWeek` operator expression
  ///
  /// Returns the week number in ISO 8601 format, ranging from 1 to 53. Week
  /// numbers start at 1 with the week (Monday through Sunday) that contains
  /// the year’s first Thursday.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $isoWeek(date, {timezone})
      : super(op$isoWeek, _getDateExpression(date, timezone: timezone));
}

/// `$isoWeekYear` operator
class $isoWeekYear extends OperatorExpression {
  /// Creates `$isoWeekYear` operator expression
  ///
  /// Returns the year number in ISO 8601 format. The year starts with the
  /// Monday of week 1 and ends with the Sunday of the last week.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $isoWeekYear(date, {timezone})
      : super(op$isoWeekYear, _getDateExpression(date, timezone: timezone));
}

/// `$millisecond` operator
class $millisecond extends OperatorExpression {
  /// Creates `$millisecond` operator expression
  ///
  /// Returns the millisecond portion of a date as an integer between 0 and 999.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $millisecond(date, {timezone})
      : super(op$millisecond, _getDateExpression(date, timezone: timezone));
}

/// `$minute` operator
class $minute extends OperatorExpression {
  /// Creates `$minute` operator expression
  ///
  /// Returns the minute portion of a date as a number between 0 and 59.
  ///
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $minute(date, {timezone})
      : super(op$minute, _getDateExpression(date, timezone: timezone));
}

/// `$month` operator
class $month extends OperatorExpression {
  /// Creates `$month` operator expression
  ///
  /// Returns the month of a date as a number between 1 and 12.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $month(date, {timezone})
      : super(op$month, _getDateExpression(date, timezone: timezone));
}

/// `$second` operator
class $second extends OperatorExpression {
  /// Creates `$second` operator expression
  ///
  /// Returns the second portion of a date as a number between 0 and 59, but can
  /// be 60 to account for leap seconds.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $second(date, {timezone})
      : super(op$second, _getDateExpression(date, timezone: timezone));
}

/// `$toDate` operator
class $toDate extends OperatorExpression {
  /// Creates `$toDate` operator expression
  ///
  /// Converts a value to a date. If the value cannot be converted to a date,
  /// `$toDate` errors. If the value is `null` or missing, `$toDate` returns `null`.
  $toDate(expr) : super(op$toDate, valueToContent(expr));
}

/// `$week` operator
class $week extends OperatorExpression {
  /// Creates `$week` operator expression
  ///
  /// Returns the week of the year for a date as a number between 0 and 53.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $week(date, {timezone})
      : super(op$week, _getDateExpression(date, timezone: timezone));
}

/// `$year` operator
class $year extends OperatorExpression {
  /// Creates `$year` operator expression
  ///
  /// Returns the year portion of a date.
  ///
  /// * [date] - The date to which the operator is applied. [date] must be a
  /// valid expression that resolves to a Date, a Timestamp, or an ObjectID.
  /// * {timezone} - Optional. The timezone of the operation result. {timezone}
  /// must be a valid expression that resolves to a string formatted as either
  /// an Olson Timezone Identifier or a UTC Offset. If no timezone is provided,
  /// the result is displayed in UTC.
  $year(date, {timezone})
      : super(op$year, _getDateExpression(date, timezone: timezone));
}

ExpressionContent _getDateExpression(date, {timezone}) {
  return valueToContent(timezone == null
      ? valueToContent(date)
      : {'date': valueToContent(date), 'timezone': valueToContent(timezone)});
}
