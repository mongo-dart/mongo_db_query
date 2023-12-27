import '../../base/common/operators_def.dart';
import '../../query_expression/query_expression.dart';
import '../base/aggregation_base.dart';
import '../aggregation_pipeline_builder.dart';

/// `$facet` aggregation stage
///
/// ### Stage description
///
/// Processes multiple aggregation pipelines within a single stage on the same
/// set of input documents. Each sub-pipeline has its own field in the output
/// document where its results are stored as an array of documents.
///
/// The `$facet` stage allows you to create multi-faceted aggregations which
/// characterize data across multiple dimensions, or facets, within a single
/// aggregation stage. Multi-faceted aggregations provide multiple filters and
/// categorizations to guide data browsing and analysis. Retailers commonly
/// use faceting to narrow search results by creating filters on product
/// price, manufacturer, size, etc.
///
/// Input documents are passed to the `$facet` stage only once. `$facet` enables
/// various aggregations on the same set of input documents, without needing
/// to retrieve the input documents multiple times.
///
/// Example:
///
/// Dart code:
/// ```
///  $facet({
///    'categorizedByTags': [
///      $unwind(Field('tags')),
///      $sortByCount(Field('tags'))
///    ],
///    'categorizedByPrice': [
///      $match((where..$exists('price')).rawFilter),
///      $bucket(
///          groupBy: Field('price'),
///          boundaries: [0, 150, 200, 300, 400],
///          defaultId: 'Other',
///          output: {'count': $sum(1), 'titles': $push(Field('title'))})
///    ],
///    'categorizedByYears(Auto)': [
///      $bucketAuto(groupBy: Field('year'), buckets: 4)
///    ]
///  }).build()
/// ```
/// Equivalent aggreagtion stage:
/// ```
/// {
///  $facet: {
///    "categorizedByTags": [
///      { $unwind: "$tags" },
///      { $sortByCount: "$tags" }
///    ],
///    "categorizedByPrice": [
///      { $match: { price: { $exists: true } } },
///      {
///        $bucket: {
///          groupBy: "$price",
///          boundaries: [  0, 150, 200, 300, 400 ],
///          default: "Other",
///          output: {
///            "count": { $sum: 1 },
///            "titles": { $push: "$title" }
///          }
///        }
///      }
///    ],
///    "categorizedByYears(Auto)": [
///      {
///        $bucketAuto: {
///          groupBy: "$year",
///          buckets: 4
///        }
///      }
///    ]
///  }
/// }
/// ```
/// https://docs.mongodb.com/manual/reference/operator/aggregation/facet/
class $facet extends AggregationStage {
  /// Creates `$facet` aggregation stage
  $facet(Map<String, AggregationPipeline> pipelines)
      : super(
            st$facet,
            valueToContent({
              for (var pipeline in pipelines.entries)
                pipeline.key: valueToContent(pipeline.value)
            }));
}
