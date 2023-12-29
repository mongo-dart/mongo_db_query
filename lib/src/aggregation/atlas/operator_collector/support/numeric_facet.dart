part of 'facet_type.dart';

/// Numeric facets allow you to determine the frequency of numeric values in
/// your search results by breaking the results into separate ranges of numbers.
///
/// Example
///
/// Expected Result
/// ```
///  {
///    "yearFacet": {
///      "type": "number",
///      "path": "year",
///      "boundaries": [1980,1990,2000],
///      "default": "other"
///    }
///  }
/// ```
final class NumericFacet extends FacetType {
  /// [name] - name of the facet
  /// [path] - Field path to facet on. You can specify a field that is indexed
  /// [boundaries] - List of numeric values, in ascending order, that specify
  /// the boundaries for each bucket. You must specify at least two boundaries.
  ///  Each adjacent pair of values acts as the inclusive lower bound and the
  /// exclusive upper bound for the bucket. You can specify any combination
  /// of values of the following types:
  /// - 32-bit integer (Int32)
  /// - 64-bit integer (int or Int64)
  /// - 64-bit binary floating point (double)
  /// [additionalBucket] - Name of an additional bucket that counts documents returned
  ///  from the operator that do not fall within the specified boundaries.
  /// If omitted, Atlas Search includes the results of the facet operator
  /// that do not fall under a specified bucket also, but doesn't include it
  /// in any bucket counts.
  NumericFacet(String name, String path, List<num> boundaries,
      {String? additionalBucket})
      : super('number', name, path, options: {
          'boundaries': boundaries,
          if (additionalBucket != null) 'default': additionalBucket
        });
}
