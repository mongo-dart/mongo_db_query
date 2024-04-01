import '../../base/abstract/expression_content.dart';

/// Granularity for [$bucketAuto]
///
/// Granularity ensures that the boundaries of all buckets adhere to a specified
/// preferred number series. Using a preferred number series provides more
/// control on where the bucket boundaries are set among the range of values in
/// the `groupBy` expression. They may also be used to help logarithmically and
/// evenly set bucket boundaries when the range of the `groupBy` expression
/// scales exponentially.
///
/// ### Renard Series
///
/// The Renard number series are sets of numbers derived by taking either the
/// 5th, 10 th, 20 th, 40 th, or 80 th root of 10, then including various powers
/// of the root that equate to values between 1.0 to 10.0 (10.3 in the case of
/// R80).
///
/// Set granularity to R5, R10, R20, R40, or R80 to restrict bucket boundaries
/// to values in the series. The values of the series are multiplied by a power
/// of 10 when the groupBy values are outside of the 1.0 to 10.0 (10.3 for R80)
/// range.
///
/// Example:
///
/// The R5 series is based off of the fifth root of 10, which is 1.58, and
/// includes various powers of this root (rounded) until 10 is reached. The R5
/// series is derived as follows:
///
/// * 10 0/5 = 1
/// * 10 1/5 = 1.584 ~ 1.6
/// * 10 2/5 = 2.511 ~ 2.5
/// * 10 3/5 = 3.981 ~ 4.0
/// * 10 4/5 = 6.309 ~ 6.3
/// * 10 5/5 = 10
///
/// The same approach is applied to the other Renard series to offer finer
/// granularity, i.e., more intervals between 1.0 and 10.0 (10.3 for R80).
///
/// ### E Series
///
/// The E number series are similar to the Renard series in that they subdivide
/// the interval from 1.0 to 10.0 by the 6 th, 12 th, 24 th, 48 th, 96 th, or
/// 192 nd root of ten with a particular relative error.
///
/// Set granularity to E6, E12, E24, E48, E96, or E192 to restrict bucket
/// boundaries to values in the series. The values of the series are multiplied
/// by a power of 10 when the groupBy values are outside of the 1.0 to 10.0
/// range. To learn more about the E-series and their respective relative
/// errors, see preferred number series.
///
/// ### 1-2-5 Series
///
/// The 1-2-5 series behaves like a three-value Renard series, if such a series
/// existed.
///
/// Set granularity to 1-2-5 to restrict bucket boundaries to various powers of
/// the third root of 10, rounded to one significant digit.
///
/// Example:
///
/// The following values are part of the 1-2-5 series: 0.1, 0.2, 0.5, 1, 2, 5,
/// 10, 20, 50, 100, 200, 500, 1000, and so on…
///
/// ### Powers of Two Series
/// Set granularity to POWERSOF2 to restrict bucket boundaries to numbers that
/// are a power of two.
///
/// Example:
///
/// The following numbers adhere to the power of two Series:
///
/// * 2^0 = 1
/// * 2^1 = 2
/// * 2^2 = 4
/// * 2^3 = 8
/// * 2^4 = 16
/// * 2^5 = 32
/// * and so on…
///
/// A common implementation is how various computer components, like memory,
/// often adhere to the POWERSOF2 set of preferred numbers:
///
/// 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, and so on….
///
/// https://docs.mongodb.com/manual/reference/operator/aggregation/bucketAuto/#granularity
class Granularity extends ExpressionContent {
  const Granularity(this._value);

  final String _value;
  @override
  String get rawContent => _value;

  static const r5 = Granularity('R5');
  static const r10 = Granularity('R10');
  static const r20 = Granularity('R20');
  static const r40 = Granularity('R40');
  static const r80 = Granularity('R80');
  static const g125 = Granularity('1-2-5');
  static const e6 = Granularity('E6');
  static const e12 = Granularity('E12');
  static const e24 = Granularity('E24');
  static const e48 = Granularity('E48');
  static const e96 = Granularity('E96');
  static const e192 = Granularity('E192');
  static const powersof2 = Granularity('POWERSOF2');
}
