part of 'facet_type.dart';

/// String facets allow you to narrow down Atlas Search results based on the
/// most frequent string values in the specified string field. Note that the
/// string field must be indexed.
///
/// Example
///
/// Expected Result
/// ```
///  {
///    "genresFacet": {
///      "type": "string",
///      "path": "genres"
///    }
///  }
/// ```
final class StringFacet extends FacetType {
  /// [name] - name of the facet
  /// [path] - Field path to facet on. You can specify a field that is indexed
  /// [numBuckets] - Maximum number of facet categories to return in the
  /// results. Value must be less than or equal to 1000. If specified,
  /// Atlas Search may return fewer categories than requested if the data
  /// is grouped into fewer categories than your requested number.
  /// If omitted, defaults to 10, which means that Atlas Search will return
  /// only the top 10 facet categories by count.
  StringFacet(String name, String path, {int? numBuckets})
      : super('string', name, path,
            options: {if (numBuckets != null) 'numBuckets': numBuckets});
}
