import 'package:mongo_db_query/src/base/field_expression.dart';

import '../../../base/map_expression.dart';
import '../../../base/common/document_types.dart';

part 'string_facet.dart';
part 'numeric_facet.dart';
part 'date_facet.dart';

/// Facet Type - Defines the basic info for a specific facet
///
/// Support information for facet collector
abstract base class FacetType extends FieldExpression {
  /// [type] - type of the facet (string | number | date)
  /// [name] - name of the facet
  /// [path] - Field path to facet on. You can specify a field that is indexed
  /// [options] - Specific info for the type
  FacetType(String type, String name, String path, {MongoDocument? options})
      : super(name, MapExpression({'type': type, 'path': path, ...?options}));
}
