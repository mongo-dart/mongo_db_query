import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../base/abstract/expression_content.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';
import '../support_classes/common.dart';
import '../support_classes/output.dart';

/// `$setWindowFields` aggregation stage
///
/// ### Stage description
///
/// Available since MongoDB version 5.0
///
/// Performs operations on a specified span of documents in a collection,
/// known as a window, and returns the results based on the chosen
/// window operator.
///
/// For example, you can use the $setWindowFields stage to output the:
/// -   Difference in sales between two documents in a collection.
/// -   Sales rankings.
/// -   Cumulative sales totals.
/// -   Analysis of complex time series information without exporting the data
///     to an external database.
///
/// Example:
///
/// Dart code:
/// ```dart
/// $setWindowFields(partitionBy: {
///    r'$year': r'$orderDate'
///  }, sortBy: {
///    'orderDate': 1
///  }, output: [
///    Output('cumulativeQuantityForYear', $sum(r'$quantity'),
///        documents: ["unbounded", "current"]),
///    Output('maximumQuantityForYear', $max(r'$quantity'),
///        documents: ["unbounded", "unbounded"])
///  ]).build()
/// ```
/// or
/// ```dart
///   $setWindowFields.raw({
///    'partitionBy': $year(Field('orderDate')).build(),
///    'sortBy': {'orderDate': 1},
///    'output': {
///      'cumulativeQuantityForYear': {
///        ...$sum(Field('quantity')).build(),
///        'window': {
///          'documents': ["unbounded", "current"]
///        }
///      },
///      'maximumQuantityForYear': {
///        ...$max(Field('quantity')).build(),
///        'window': {
///          'documents': ["unbounded", "unbounded"]
///        }
///      }
///    }
///  }).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
///  {
///    r'$setWindowFields': {
///      'partitionBy': {r'$year': r'$orderDate'},
///      'sortBy': {'orderDate': 1},
///      'output': {
///        'cumulativeQuantityForYear': {
///          r'$sum': r'$quantity',
///          'window': {
///            'documents': ["unbounded", "current"]
///          }
///        },
///        'maximumQuantityForYear': {
///          r'$max': r'$quantity',
///          'window': {
///            'documents': ["unbounded", "unbounded"]
///          }
///        }
///      }
///    }
///  }
/// ```
/// https://www.mongodb.com/docs/manual/reference/operator/aggregation/setWindowFields/
class $setWindowFields extends AggregationStage {
  /// Creates `$setWindowFields` aggregation stage
  ///
  /// * [partitionBy] Optional - Specifies an expression to group the documents.
  ///   In the $setWindowFields stage, the group of documents is known as a
  ///   partition. Default is one partition for the entire collection.
  /// * [sortBy] Required for some operators
  ///   Specifies the field(s) to sort the documents by in the partition.
  ///   Uses the same syntax as the $sort stage.
  ///   Default is no sorting.
  /// * [output] - Specifies the field(s) an related parameters to append to
  ///   the documents in the output returned by the $setWindowFields stage.
  ///   Each field is set to the result returned by the window operator.
  ///   The field can either an Output object, a list of Output Objects or a
  ///   document containing the explicit description of the output required
  $setWindowFields(
      {partitionBy, IndexDocument? sortBy, defaultId, required dynamic output})
      : super(
            st$setWindowFields,
            valueToContent({
              if (partitionBy != null) spPartitionBy: partitionBy,
              if (sortBy != null) spSortBy: valueToContent(sortBy),
              'output': _getOutputDocument(output),
            }));

  $setWindowFields.raw(MongoDocument raw) : super.raw(st$setWindowFields, raw);

  static ExpressionContent _getOutputDocument(output) {
    if (output is Output) {
      return valueToContent(output.rawContent);
    } else if (output is List<Output>) {
      return valueToContent(
          {for (Output element in output) ...element.rawContent});
    } else if (output is Map<String, dynamic>) {
      return valueToContent(output);
    } else {
      throw Exception(
          'output parm must be Map<String,dynamic>, Output or List<Output>');
    }
  }
}
