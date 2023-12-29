import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_stage.dart';

/// `$merge` aggregation stage
///
/// ### Stage description
///
/// Writes the results of the aggregation pipeline to a specified collection.
/// The $merge operator must be the last stage in the pipeline.
/// The $merge stage:
/// - Can output to a collection in the same or different database.
/// - Starting in MongoDB 4.4:
///    -  $merge can output to the same collection that is being aggregated.
/// For more information, see Output to the Same Collection that is Being
/// Aggregated.
///    -  Pipelines with the $merge stage can run on replica set secondary
///  nodes if all the nodes in cluster have featureCompatibilityVersion set
/// to 4.4 or higher and the Read Preference allows secondary reads.
///         - Read operations of the $merge statement are sent to secondary
/// nodes, while the write operations occur only on the primary node.
///         - Not all driver versions support targeting of $merge operations
/// to replica set secondary nodes. Check your driver documentation to see when
///  your driver added support for $merge read operations running on
/// secondary nodes.
/// - Creates a new collection if the output collection does not already exist.
/// - Can incorporate results (insert new documents, merge documents,
/// replace documents, keep existing documents, fail the operation,
/// process documents with a custom update pipeline) into an existing
/// collection.
/// - Can output to a sharded collection. Input collection can also be sharded.
///
/// Examples:
///
/// Dart code:
/// ```
/// $merge(
///    into: 'myOutput',
///    on: '_id',
///    whenMatched: 'replace',
///    whenNotMatched: 'insert')
/// .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
/// $merge:
///    {
///      into: "myOutput",
///      on: "_id",
///      whenMatched: "replace",
///      whenNotMatched: "insert"
///    }
/// }
/// ```
///
/// or
/// ```
/// $merge
///   .raw( {
///   'into': "myOutput",
///   'on': "_id",
///   'whenMatched': "replace",
///   'whenNotMatched': "insert"
/// })
///   .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
/// $merge:
///    {
///      into: "myOutput",
///      on: "_id",
///      whenMatched: "replace",
///      whenNotMatched: "insert"
///    }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/merge/
class $merge extends AggregationStage {
  /// Creates ordinary `$merge` stage
  ///
  /// * [into] - The output collection. Specify either:
  /// - The collection name as a string to output to a collection in the same
  /// database where the aggregation is run. For example:
  /// into: "myOutput"
  /// - The database and collection name in a document to output to a
  /// collection in the specified database. For example:
  /// into: { db:"myDB", coll:"myOutput" }
  /// * [on] -  Field or fields that act as a unique identifier for a document.
  /// The identifier determines if a results document matches an existing
  /// document in the output collection. Specify either:
  /// - A single field name as a string. For example: on: "_id"
  /// - A combination of fields in an array. For example:
  /// on: [ "date", "customerId" ]
  /// - The order of the fields in the array does not matter, and you cannot
  /// specify the same field multiple times.
  ///
  /// For the specified field or fields:
  /// - The aggregation results documents must contain the field(s) specified in
  /// the on, unless the on field is the _id field. If the _id field is missing
  /// from a results document, MongoDB adds it automatically.
  /// - The specified field or fields cannot contain a null or an array value.
  ///
  /// $merge requires a unique, index with keys that correspond to the on
  /// identifier fields. Although the order of the index key specification does
  /// not matter, the unique index must only contain the on fields as its keys.
  /// - The index must also have the same collation as the aggregation's
  /// collation.
  /// - The unique index can be a sparse index.
  /// - The unique index cannot be a partial index.
  /// - For output collections that already exist, the corresponding index must
  /// already exist.
  ///
  /// The default value for [on] depends on the output collection:
  /// - If the output collection does not exist, the on identifier must be and
  /// defaults to the _id field. The corresponding unique _id index is
  /// automatically created.
  /// - If the existing output collection is unsharded, the on identifier
  /// defaults to the _id field.
  /// - If the existing output collection is a sharded collection,
  ///  the on identifier defaults to all the shard key fields and the _id field.
  /// If specifying a different on identifier, the on must contain all the
  /// shard key fields.
  /// * [let] - Specifies variables for use in the whenMatched pipeline.
  /// Specify a document with the variable names and value expressions:
  /// { <variable_name_1>: <expression_1>,
  /// ...,
  /// <variable_name_n>: <expression_n> }
  /// If unspecified, defaults to { new: "$$ROOT" } (see ROOT).
  /// The whenMatched pipeline can access the $$new variable.
  /// * [whenMatched] - The behavior of $merge if a result document and an
  /// existing document in the collection have the same value for the specified
  /// on field(s).
  /// You can specify either:
  ///   -  One of the pre-defined action strings:
  ///      - "replace" -> Replace the existing document in the output
  ///       collection with the matching results document.
  ///       When performing a replace, the replacement document cannot result
  ///       in a modification of the _id value or, if the output collection is
  ///       sharded, the shard key value. Otherwise, the operation generates
  ///       an error.
  ///      - "keepExisting" -> Keep the existing document in the output
  ///         collection.
  ///      - "merge" (Default) -> Merge the matching documents (similar to the
  ///        $mergeObjects operator).
  ///        If the results document contains fields not in the existing
  ///        document, add these new fields to the existing document.
  ///        If the results document contains fields in the existing document,
  ///        replace the existing field values with those from the results
  ///        document.
  ///        For example, if the output collection has the document:
  ///        { _id: 1, a: 1, b: 1 }
  ///        And the aggregation results has the document:
  ///        { _id: 1, b: 5, z: 1 }
  ///        Then, the merged document is:
  ///        { _id: 1, a: 1, b: 5, z: 1 }
  ///        When performing a merge, the merged document cannot result in a
  ///        modification of the _id value or, if the output collection is
  ///        sharded, the shard key value. Otherwise, the operation generates
  ///        an error.
  ///      - "fail" -> Stop and fail the aggregation operation. Any changes to
  ///        the output collection from previous documents are not reverted.
  ///    - An aggregation pipeline to update the document in the collection.
  ///      [ <stage1>, <stage2> ... ]
  ///      The pipeline can only consist of the following stages:
  ///      - $addFields and its alias $set
  ///      - $project and its alias $unset
  ///      - $replaceRoot and its alias $replaceWith
  ///      The pipeline cannot modify the on field's value. For example,
  ///      if you are matching on the field month, the pipeline cannot modify
  ///      the month field.
  ///      The whenMatched pipeline can directly access the fields of the
  ///      existing documents in the output collection using $<field>.
  ///      To access the fields from the aggregation results documents,
  ///      use either:
  ///      - The built-in $$new variable to access the field. Specifically,
  ///      $$new.<field>. The $$new variable is only available if the let
  ///      specification is omitted.
  ///      - The user-defined variables in the let field.
  ///      Specify the double dollar sign ($$) prefix together with the
  ///      variable name in the form $$<variable_name>. For example, $$year.
  ///      If the variable is set to a document, you can also include a
  ///      document field in the form $$<variable_name>.<field>. For example,
  ///      $$year.month.
  /// * [whenNotMatched] - The behavior of $merge if a result document does not
  /// match an existing document in the out collection.
  /// You can specify one of the pre-defined action strings:
  ///   - "insert" (Default) -> Insert the document into the output collection. |
  ///   - "discard" -> Discard the document. Specifically, $merge does not insert
  /// the document into the output collection.
  ///   - "fail" -> Stop and fail the aggregation operation. Any changes already
  /// written to the output collection are not reverted.
  $merge({required into, on, let, String? whenMatched, String? whenNotMatched})
      : super(
            st$merge,
            valueToContent({
              'into': into,
              if (on != null) 'on': on,
              if (let != null) 'let': let,
              if (whenMatched != null) 'whenMatched': whenMatched,
              if (whenNotMatched != null) 'whenNotMatched': whenNotMatched
            }));
  $merge.raw(MongoDocument raw) : super.raw(st$merge, raw);
}
