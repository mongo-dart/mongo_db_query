import '../base/common/operators_def.dart';
import '../query_expression/query_expression.dart';
import 'aggregation_base.dart';

/// `$convert` operator
class $convert extends Operator {
  /// Creates `$convert` operator expression
  ///
  /// The argument can be any expression as long as it resolves to a string.
  ///
  /// * [input] - The argument can be any valid expression.
  /// * [to] - The argument can be any valid expression that resolves to one of
  /// the following numeric or string identifiers:
  ///   * 'double'
  ///   * 'string'
  ///   * 'objectId'
  ///   * 'bool'
  ///   * 'date'
  ///   * 'int'
  ///   * 'long'
  ///   * 'decimal'
  /// * [onError] - Optional. The value to return on encountering an error during
  /// conversion, including unsupported type conversions. The arguments can be
  /// any valid expression. If unspecified, the operation throws an error upon
  /// encountering an error and stops.
  /// * [onNull] - Optional. The value to return if the input is null or missing.
  /// The arguments can be any valid expression. If unspecified, `$convert` returns
  /// `null` if the input is null or missing.
  $convert({required input, required to, onError, onNull})
      : super(
            op$convert,
            valueToContent({
              'input': input,
              'to': to,
              'onError': onError,
              'onNull': onNull
            }));
}

/// `$toBool` operator
class $toBool extends Operator {
  /// Creates `$toBool` operator expression
  ///
  /// Converts a value to a boolean.
  ///
  /// The [$toBool] takes any valid expression.
  $toBool(expr) : super(op$toBool, valueToContent(expr));
}

/// `$toDecimal` operator
class $toDecimal extends Operator {
  /// Creates `$toDecimal` operator expression
  ///
  /// Converts a value to a decimal. If the value cannot be converted to a
  /// decimal, `$toDecimal` errors. If the value is `null` or missing,
  /// `$toDecimal` returns `null`.
  ///
  /// The [$toDecimal] takes any valid expression.
  $toDecimal(expr) : super(op$toDecimal, valueToContent(expr));
}

/// `$toDouble` operator
class $toDouble extends Operator {
  /// Creates `$toDouble` operator expression
  ///
  /// Converts a value to a double. If the value cannot be converted to an
  /// double, `$toDouble` errors. If the value is `null` or missing, `$toDouble`
  /// returns `null`.
  ///
  /// The [$toDouble] takes any valid expression.
  $toDouble(expr) : super(op$toDouble, valueToContent(expr));
}

/// `$toInt` operator
class $toInt extends Operator {
  /// Creates `$toInt` operator expression
  ///
  /// Converts a value to an integer. If the value cannot be converted to an
  /// integer, `$toInt` errors. If the value is `null` or missing, `$toInt`
  /// returns `null`.
  ///
  /// The [$toInt] takes any valid expression.
  $toInt(expr) : super(op$toInt, valueToContent(expr));
}

/// `$toLong` operator
class $toLong extends Operator {
  /// Creates `$toLong` operator expression
  ///
  /// Converts a value to a long. If the value cannot be converted to a long,
  /// `$toLong` errors. If the value is `null` or missing, `$toLong` returns
  /// `null`.
  ///
  /// The [$toLong] takes any valid expression.
  $toLong(expr) : super(op$toLong, valueToContent(expr));
}

/// `$toObjectId` operator
class $toObjectId extends Operator {
  /// Creates `$toObjectId` operator expression
  ///
  /// Converts a value to an ObjectId. If the value cannot be converted to an
  /// `ObjectId`, `$toObjectId` errors. If the value is `null` or missing,
  /// `$toObjectId` returns `null`.
  ///
  /// The [$toObjectId] takes any valid expression.
  $toObjectId(expr) : super(op$toObjectId, valueToContent(expr));
}

/// `$type` operator
class $type extends Operator {
  /// Creates `$type` operator expression
  ///
  /// Returns a string that specifies the BSON type of the argument.
  ///
  /// The argument can be any valid expression.
  $type(expr) : super(op$type, valueToContent(expr));
}
