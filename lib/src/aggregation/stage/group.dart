import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$group` aggregation stage
///
/// ### Stage description
///
/// Groups documents by some specified expression and outputs to the next
/// stage a document for each distinct grouping. The output documents contain
/// an `_id` field which contains the distinct group by key. The output
/// documents can also contain computed fields that hold the values of some
/// accumulator expression grouped by the `$group`’s `_id` field. `$group`
/// does not order its output documents.
///
/// Examples:
///
/// #### Group by Month, Day, and Year
///
/// The following aggregation operation uses the `$group` stage to group the
/// documents by the month, day, and year and calculates the total price and
/// the average quantity as well as counts the documents per each group:
///
/// Dart code:
/// ```
/// $group(id: {
///   'month': $month(Field('date')),
///   'day': $dayOfMonth(Field('date')),
///   'year': $year(Field('date'))
///  }, fields: {
///    'totalPrice': $sum($multiply([Field('price'), Field('quantity')])),
///    'averageQuantity': $avg(Field('quantity')),
///   'count': $sum(1)
///  }).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///   $group : {
///     _id : {
///       month: { $month: { date: "$date" }},
///       day: { $dayOfMonth: { date: "$date" }},
///       year: { $year: { date: "$date" }}
///     },
///     totalPrice: { $sum: { $multiply: [ "$price", "$quantity" ] } },
///     averageQuantity: { $avg: "$quantity" },
///     count: { $sum: 1 }
///   }
/// }
/// ```
///
/// #### Group by null
///
/// The following aggregation operation specifies a group `_id` of `null`,
/// calculating the total price and the average quantity as well as counts
/// for all documents in the collection:
///
/// Dart code:
/// ```
///  $group(id: null, fields: {
///    'totalPrice': $sum($multiply([Field('price'), Field('quantity')])),
///    'averageQuantity': $avg(Field('quantity')),
///    'count': $sum(1)
///  }).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///   $group : {
///      _id : null,
///      totalPrice: { $sum: { $multiply: [ "$price", "$quantity" ] } },
///      averageQuantity: { $avg: "$quantity" },
///      count: { $sum: 1 }
///   }
/// }
/// ```
///
/// #### Retrieve Distinct Values
///
/// The following aggregation operation uses the `$group` stage to group the
/// documents by the item to retrieve the distinct item values:
///
/// Dart code:
/// ```
/// $group(id: Field('item')).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $group : { _id : "$item" } }
/// ```
///
/// #### Group title by author
///
/// The following aggregation operation pivots the data in the books
/// collection to have titles grouped by authors.
///
/// Dart code:
/// ```
/// $group(id: Field('author'), fields: {'books': $push(Field('title'))})
///      .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $group : { _id : "$author", books: { $push: "$title" } } }
/// ```
///
/// #### Group Documents by author
///
/// The following aggregation operation uses the $$ROOT system variable to
/// group the documents by authors. The resulting documents must not exceed
/// the BSON Document Size limit.
///
/// Dart code:
/// ```
/// $group(id: Field('author'), fields: {'books': $push(Var.root)}).build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// { $group : { _id : "$author", books: { $push: "$$ROOT" } } }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/group/
class $group extends AggregationStage {
  /// Creates `$group` aggregation stage
  $group({required id, Map<String, Accumulator> fields = const {}})
      : super(
            st$group,
            valueToContent({
              '_id': valueToContent(id),
              for (var field in fields.entries)
                field.key: valueToContent(field.value)
            }));
}
