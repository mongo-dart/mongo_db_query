import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';
import '../aggregation_pipeline_builder.dart';

/// `$lookup` aggregation stage
///
/// ### Stage description
///
/// Performs a left outer join to an unsharded collection in the same database
/// to filter in documents from the “joined” collection for processing. To each
/// input document, the $lookup stage adds a new array field whose elements are
/// the matching documents from the “joined” collection. The $lookup stage
/// passes these reshaped documents to the next stage.
///
/// Examples:
///
/// 1. Single Equality Join
///
/// Dart code:
/// ```
/// $lookup(
///          from: 'inventory',
///          localField: 'item',
///          foreignField: 'sku',
///          as: 'inventory_docs')
///      .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///   $lookup: {
///     from: "inventory",
///     localField: "item",
///     foreignField: "sku",
///     as: "inventory_docs"
///   }
/// }
/// ```
///
/// 2. Specify Multiple Join Conditions:
///
/// Dart code:
/// ```
///  $lookup
///     .withPipeline(
///          from: 'warehouses',
///          let: {
///            'order_item': Field('item'),
///            'order_qty': Field('ordered')
///          },
///          pipeline: [
///            $match($expr($and([
///              $eq(Field('stock_item'), Var('order_item')),
///              $gte(Field('instock'), Var('order_qty'))
///            ]))),
///            $project({'stock_item': 0, '_id': 0})
///          ],
///         as: 'stockdata')
///      .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
///   $lookup: {
///     from: "warehouses",
///     let: { order_item: "$item", order_qty: "$ordered" },
///     pipeline: [
///       { $match:
///         { $expr:
///           { $and:
///             [
///               { $eq: [ "$stock_item",  "$$order_item" ] },
///               { $gte: [ "$instock", "$$order_qty" ] }
///             ]
///           }
///         }
///       },
///       { $project: { stock_item: 0, _id: 0 } }
///     ],
///     as: "stockdata"
///   }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/lookup/
class $lookup extends AggregationStage {
  /// Creates ordinary `$lookup` stage
  ///
  /// * [from] - Specifies the collection in the same database to perform the join
  /// with. The from collection cannot be sharded.
  /// * [localField] - Specifies the field from the documents input to the
  /// `$lookup` stage. `$lookup` performs an equality match on the [localField] to
  /// the [foreignField] from the documents of the from collection. If an input
  /// document does not contain the [localField], the `$lookup` treats the field as
  /// having a value of `null` for matching purposes.
  /// * [foreignField] - Specifies the field from the documents in the from
  /// collection. `$lookup` performs an equality match on the [foreignField] to
  /// the [localField] from the input documents. If a document in the from
  /// collection does not contain the [foreignField], the `$lookup` treats the
  /// value as `null` for matching purposes.
  /// * [as] - Specifies the name of the new array field to add to the input
  /// documents. The new array field contains the matching documents from the
  /// from collection. If the specified name already exists in the input
  /// document, the existing field is overwritten.
  $lookup(
      {required String from,
      required String localField,
      required String foreignField,
      required String as})
      : super(
            st$lookup,
            valueToContent({
              'from': from,
              'localField': localField,
              'foreignField': foreignField,
              'as': as
            }));

  /// Creates `$lookup` stage with it's own pipeline
  ///
  /// * [from] - Specifies the collection in the same database to perform the join
  /// with. The from collection cannot be sharded.
  /// * [let] - Optional. Specifies variables to use in the pipeline field
  /// stages. Use the variable expressions to access the fields from the
  /// documents input to the $lookup stage. The pipeline cannot directly access
  /// the input document fields. Instead, first define the variables for the
  /// input document fields, and then reference the variables in the stages in
  /// the pipeline. To access the let variables in the pipeline, use the
  /// `$expr` ([Expr]) operator.
  ///
  /// NOTE:
  ///
  /// The let variables are accessible by the stages in the pipeline, including
  /// additional `$lookup` stages nested in the pipeline.
  /// * [pipeline] - Specifies the pipeline to run on the joined collection.
  /// The pipeline determines the resulting documents from the joined
  /// collection. To return all documents, specify an empty pipeline `[]`.
  ///
  /// The pipeline cannot include the `$out` stage or the `$merge` stage.
  ///
  /// The pipeline cannot directly access the input document fields. Instead,
  /// first define the variables for the input document fields, and then
  /// reference the variables in the stages in the pipeline.
  /// * [as] - Specifies the name of the new array field to add to the input
  /// documents. The new array field contains the matching documents from the
  /// from collection. If the specified name already exists in the input
  /// document, the existing field is overwritten.
  $lookup.withPipeline(
      {required String from,
      required Map<String, dynamic> let,
      required AggregationPipeline pipeline,
      required String as})
      : super(
            st$lookup,
            valueToContent({
              'from': from,
              'let': valueToContent(let),
              'pipeline': valueToContent(pipeline),
              'as': as
            }));
}
