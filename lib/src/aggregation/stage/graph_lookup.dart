import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/expression_content.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$graphLookup`
///
/// ### Stage description
/// Performs a recursive search on a collection, with options for restricting
/// the search by recursion depth and query filter.
/// [see mongo db documentation](https://docs.mongodb.com/manual/reference/operator/aggregation/graphLookup/)
///
///
/// Dart code:
///
/// ```
///    $graphLookup(
///         from: 'employees',
///         startWith: 'reportsTo',
///         connectFromField: 'reportsTo',
///         connectToField: 'name',
///         as: 'reportingHierarchy',
///         depthField: 'depth',
///         maxDepth: 5,
///         restrictSearchWithMatch: where..$eq('field', 'value'))
///     .build();
/// ```
///
/// Equivalent mongoDB aggregation stage:
///
/// ```
///   $graphLookup: {
///     from: "employees",
///     startWith: "$reportsTo",
///     connectFromField: "reportsTo",
///     connectToField: "name",
///     as : "reportingHierarchy",
///     depthField: "depth",
///     maxDepth: 5,
///     restrictSearchWithMatch : {
///       field : {$eq: "value"}
///     }
///   }
/// ```
///
///
class $graphLookup extends AggregationStage {
  $graphLookup(
      {required String from,
      required String startWith,
      required String connectFromField,
      required String connectToField,
      required String as,
      int? maxDepth,
      String? depthField,
      restrictSearchWithMatch})
      : super(
            st$graphLookup,
            valueToContent({
              'from': from,
              'startWith': '\$$startWith',
              'connectFromField': connectFromField,
              'connectToField': connectToField,
              'as': as,
              if (maxDepth != null) 'maxDepth': maxDepth,
              if (depthField != null) 'depthField': depthField,
              if (restrictSearchWithMatch != null)
                'restrictSearchWithMatch':
                    _getRestrictSearchWithMatch(restrictSearchWithMatch)
            }));

  static ExpressionContent _getRestrictSearchWithMatch(
      restrictSearchWithMatch) {
    if (restrictSearchWithMatch is QueryExpression) {
      return valueToContent(restrictSearchWithMatch);
    } else if (restrictSearchWithMatch is MongoDocument) {
      return valueToContent(restrictSearchWithMatch);
    } else {
      throw Exception('restrictSearchWithMatch must be '
          'Map<String,dynamic> or QueryExpression');
    }
  }
}
