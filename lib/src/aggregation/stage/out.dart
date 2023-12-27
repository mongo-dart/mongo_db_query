import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';

/// `$out` aggregation stage
///
/// ### Stage description
///
/// Takes the documents returned by the aggregation pipeline and writes them
/// to a specified collection. Starting in MongoDB 4.4, you can specify the
/// output database.
/// The $out stage must be the last stage in the pipeline. The $out operator
/// lets the aggregation framework return result sets of any size.
///
/// ***Warning*** $out replaces the specified collection if it exists.
///
/// Examples:
///
/// Dart code:
/// ```
/// $out(
///    db: 'reporting',
///    coll: 'authors')
/// .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
/// $out : { db: "reporting", coll: "authors" }
/// }
/// ```
///
/// or
/// ```
/// $out
///   .raw( { db: "reporting", coll: "authors" })
///   .build()
/// ```
/// Equivalent mongoDB aggregation stage:
/// ```
/// {
/// $out : { db: "reporting", coll: "authors" }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/out/
class $out extends AggregationStage {
  /// Creates ordinary `$out` stage
  ///
  /// * [db] - The output database name.
  /// - For a replica set or a standalone, if the output database does not
  /// exist, $out also creates the database.
  /// - For a sharded cluster, the specified output database must already exist.
  /// * [coll] - The output collection name.
  $out({String? db, required String coll})
      : super(
            st$out,
            valueToContent({
              if (db != null) 'db': db,
              'coll': coll,
            }));
  $out.raw(MongoDocument raw) : super.raw(st$out, raw);
}
