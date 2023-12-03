import '../../base/map_expression.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';
import '../../base/common/operators_def.dart';
import 'sequence_mixin.dart';

mixin DateTimeMixin implements SequenceMixin<MapExpression> {
  /// `$dateFromParts`
  /// Creates `$dateFromParts` operator expression
  ///
  /// Constructs and returns a Date object given the date’s constituent
  /// properties.
  $dateFromParts(
          {required year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dateFromParts,
          valueToContent({
            'year': year,
            if (month != null) 'month': month,
            if (day != null) 'day': day,
            if (hour != null) 'hour': hour,
            if (minute != null) 'minute': minute,
            if (second != null) 'second': second,
            if (millisecond != null) 'millisecond': millisecond,
            if (timezone != null) 'timezone': timezone
          }))));

  /// Variant of `$dateFromParts` operator
  /// Creates `$dateFromParts` operator expression
  ///
  /// Uses ISO Week Date fields to construct Date
  isoDateFromParts(
          {required year,
          week,
          day,
          hour,
          minute,
          second,
          millisecond,
          timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dateFromParts,
          valueToContent({
            'isoWeekYear': year,
            if (week != null) 'isoWeek': week,
            if (day != null) 'isoDayOfWeek': day,
            if (hour != null) 'hour': hour,
            if (minute != null) 'minute': minute,
            if (second != null) 'second': second,
            if (millisecond != null) 'millisecond': millisecond,
            if (timezone != null) 'timezone': timezone
          }))));

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
  $dateFromString({required dateString, format, timezone, onError, onNull}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dateFromString,
          valueToContent({
            'dateString': dateString,
            if (format != null) 'format': format,
            if (timezone != null) 'timezone': timezone,
            if (onError != null) 'onError': onError,
            if (onNull != null) 'onNull': onNull
          }))));

  /// Creates `$dateToParts` operator expression
  ///
  /// Returns a document that contains the constituent parts of a given BSON Date
  /// value as individual properties. The properties returned are year, month,
  /// day, hour, minute, second and millisecond. You can set the iso8601 property
  /// to true to return the parts representing an ISO week date instead. This will
  /// return a document where the properties are isoWeekYear, isoWeek,
  /// isoDayOfWeek, hour, minute, second and millisecond.
  $dateToParts(date, {timezone, bool iso8601 = false}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dateToParts,
          valueToContent({
            'date': date,
            if (timezone != null) 'timezone': timezone,
            'iso8601': iso8601
          }))));

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
  $dayOfMonth(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dayOfMonth,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $dayOfWeek(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dayOfWeek,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $dayOfYear(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$dayOfYear,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $hour(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$hour,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $isoDayOfWeek(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$isoDayOfWeek,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $isoWeek(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$isoWeek,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $isoWeekYear(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$isoWeekYear,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $millisecond(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$millisecond,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $minute(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$minute,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $month(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$month,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $second(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$second,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

  /// Creates `$toDate` operator expression
  ///
  /// Converts a value to a date. If the value cannot be converted to a date,
  /// `$toDate` errors. If the value is `null` or missing, `$toDate` returns `null`.
  $toDate(expr) => sequence.add(MapExpression.expression(
      OperatorExpression(op$toDate, valueToContent(expr))));

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
  $week(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$week,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));

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
  $year(date, {timezone}) =>
      sequence.add(MapExpression.expression(OperatorExpression(
          op$year,
          valueToContent(
              {'date': date, if (timezone != null) 'timezone': timezone}))));
}
