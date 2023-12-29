part of 'facet_type.dart';

/// Date facets allow you to narrow down search results based on a date.
///
/// Example
///
/// Expected Result
/// ```
///  {
///    "yearFacet": {
///      "type": "date",
///      "path": "released",
///      "boundaries": [DateTime(2000, 01, 01), DateTime(2005, 01, 01), DateTime(2010, 01, 01), DateTime(2015, 01, 01)],
///      "default": "other"
///    }
///  }
/// ```
final class DateFacet extends FacetType {
  /// [name] - name of the facet
  /// [path] - Field path to facet on. You can specify a field that is indexed
  /// [boundaries] - List of date values that specify the boundaries for each
  /// bucket. You must specify:
  /// - At least two boundaries
  /// - Values in ascending order, with the earliest date first
  ///
  /// Each adjacent pair of values acts as the inclusive lower bound and
  /// the exclusive upper bound for the bucket.
  /// [additionalBucket] - Name of an additional bucket that counts documents
  /// returned from the operator that do not fall within the specified
  /// boundaries.
  /// If omitted, Atlas Search includes the results of the facet operator
  /// that do not fall under a specified bucket also, but doesn't include it
  /// in any bucket counts.
  DateFacet(String name, String path, List<DateTime> boundaries,
      {String? additionalBucket})
      : super('date', name, path, options: {
          'boundaries': boundaries,
          if (additionalBucket != null) 'default': additionalBucket
        });
}
