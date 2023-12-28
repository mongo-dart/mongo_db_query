import '../../base/common/operators_def.dart';
import '../../base/operator_expression.dart';
import '../../query_expression/query_expression.dart';

/// Creates `$convert` operator expression
class $convert extends OperatorExpression {
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
