import '../../../base/common/operators_def.dart';
import '../../../query_expression/query_expression.dart';
import '../../base/atlas_operator.dart';
import '../options/score_modify.dart';

/// The embeddedDocument operator is similar to `$elemMatch` operator.
/// It constrains multiple query predicates to be satisfied from a single
/// element of an array of embedded documents. embeddedDocument can be used
/// only for queries over fields of the embeddedDocuments type.
///
/// Example
///
/// Expected result:
/// ```
///
/// ```
///
/// Expected result:
/// ```
///
/// ```
///
/// https://www.mongodb.com/docs/atlas/atlas-search/embedded-document
class EmbeddedDocument extends AtlasOperator {
  /// [operator] - Operator to use to query each document in the array of
  ///  documents that you specify in the path. The moreLikeThis operator is not
  /// supported.
  ///
  /// [path] - Indexed embeddedDocuments type field to search.
  /// The specified field must be a parent for all operators and fields
  /// specified using the operator option.
  ///
  /// [score] - Score to assign to matching search results. You can use the
  ///  embedded scoring option to configure scoring options.
  ///
  EmbeddedDocument(
      {required AtlasOperator operator,
      required String path,
      ScoreModify? score})
      : super(opEmbeddedDocument, {
          'path': valueToContent(path),
          'operator': operator,
          if (score != null) ...score.build(),
        });
}
